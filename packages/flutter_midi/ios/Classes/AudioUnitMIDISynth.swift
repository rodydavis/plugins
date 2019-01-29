import Foundation
import AudioToolbox
import CoreAudio

class AudioUnitMIDISynth: NSObject {

    var processingGraph: AUGraph?
    var midisynthNode   = AUNode()
    var ioNode          = AUNode()
    var midisynthUnit: AudioUnit?
    var ioUnit: AudioUnit?
    var musicSequence: MusicSequence!
    var musicPlayer: MusicPlayer!
    let patch1          = UInt32(46)
    let patch2          = UInt32(0)
    var pitch           = UInt32(60)

    var bankUrl: URL!

    init(soundfont: URL) {
        bankUrl = soundfont;
        super.init()
        augraphSetup()
        loadMIDISynthSoundFont()
        initializeGraph()
        self.musicSequence = createMusicSequence()
        musicPlayer = createPlayer(musicSequence)
        loadPatches()
        startGraph()
    }

    /// Create the `AUGraph`, the nodes and units, then wire them together.
    func augraphSetup() {
        var status = OSStatus(noErr)

        status = NewAUGraph(&processingGraph)
        AudioUtils.CheckError(status)

        createIONode()

        createSynthNode()

        // now do the wiring. The graph needs to be open before you call AUGraphNodeInfo
        status = AUGraphOpen(self.processingGraph!)
        AudioUtils.CheckError(status)

        status = AUGraphNodeInfo(self.processingGraph!, self.midisynthNode, nil, &midisynthUnit)
        AudioUtils.CheckError(status)

        status = AUGraphNodeInfo(self.processingGraph!, self.ioNode, nil, &ioUnit)
        AudioUtils.CheckError(status)


        let synthOutputElement: AudioUnitElement = 0
        let ioUnitInputElement: AudioUnitElement = 0

        status = AUGraphConnectNodeInput(self.processingGraph!,
                                         self.midisynthNode, synthOutputElement, // srcnode, SourceOutputNumber
            self.ioNode, ioUnitInputElement) // destnode, DestInputNumber

        AudioUtils.CheckError(status)
    }

    /// Create the Output Node and add it to the `AUGraph`.
    func createIONode() {
        var cd = AudioComponentDescription(
            componentType: OSType(kAudioUnitType_Output),
            componentSubType: OSType(kAudioUnitSubType_RemoteIO),
            componentManufacturer: OSType(kAudioUnitManufacturer_Apple),
            componentFlags: 0, componentFlagsMask: 0)
        let status = AUGraphAddNode(self.processingGraph!, &cd, &ioNode)
        AudioUtils.CheckError(status)
    }

    /// Create the Synth Node and add it to the `AUGraph`.
    func createSynthNode() {
        var cd = AudioComponentDescription(
            componentType: OSType(kAudioUnitType_MusicDevice),
            componentSubType: OSType(kAudioUnitSubType_MIDISynth),
            componentManufacturer: OSType(kAudioUnitManufacturer_Apple),
            componentFlags: 0, componentFlagsMask: 0)
        let status = AUGraphAddNode(self.processingGraph!, &cd, &midisynthNode)
        AudioUtils.CheckError(status)
    }



    /// This will load the default sound font and set the synth unit's property.
    /// - postcondition: `self.midisynthUnit` will have it's sound font url set.
    func loadMIDISynthSoundFont() {

        if var bankURL = bankUrl {

            let status = AudioUnitSetProperty(
                self.midisynthUnit!,
                AudioUnitPropertyID(kMusicDeviceProperty_SoundBankURL),
                AudioUnitScope(kAudioUnitScope_Global),
                0,
                &bankURL,
                UInt32(MemoryLayout<URL>.size))

            AudioUtils.CheckError(status)
            print("loaded sound font")
        } else {
            print("Could not load sound font")
        }
    }


    /// Pre-load the patches you will use.
    ///
    /// Turn on `kAUMIDISynthProperty_EnablePreload` so the midisynth will load the patch data from the file into memory.
    /// You load the patches first before playing a sequence or sending messages.
    /// Then you turn `kAUMIDISynthProperty_EnablePreload` off. It is now in a state where it will respond to MIDI program
    /// change messages and switch to the already cached instrument data.
    ///
    /// - precondition: the graph must be initialized
    ///
    /// [Doug's post](http://prod.lists.apple.com/archives/coreaudio-api/2016/Jan/msg00018.html)
    func loadPatches() {

        if !isGraphInitialized() {
            fatalError("initialize graph first")
        }

        let channel = UInt32(0)
        var enabled = UInt32(1)

        var status = AudioUnitSetProperty(
            self.midisynthUnit!,
            AudioUnitPropertyID(kAUMIDISynthProperty_EnablePreload),
            AudioUnitScope(kAudioUnitScope_Global),
            0,
            &enabled,
            UInt32(MemoryLayout<UInt32>.size))
        AudioUtils.CheckError(status)

        //        let bankSelectCommand = UInt32(0xB0 | 0)
        //        status = MusicDeviceMIDIEvent(self.midisynthUnit, bankSelectCommand, 0, 0, 0)

        let pcCommand = UInt32(0xC0 | channel)
        status = MusicDeviceMIDIEvent(self.midisynthUnit!, pcCommand, patch1, 0, 0)
        AudioUtils.CheckError(status)
        status = MusicDeviceMIDIEvent(self.midisynthUnit!, pcCommand, patch2, 0, 0)
        AudioUtils.CheckError(status)

        enabled = UInt32(0)
        status = AudioUnitSetProperty(
            self.midisynthUnit!,
            AudioUnitPropertyID(kAUMIDISynthProperty_EnablePreload),
            AudioUnitScope(kAudioUnitScope_Global),
            0,
            &enabled,
            UInt32(MemoryLayout<UInt32>.size))
        AudioUtils.CheckError(status)

        // at this point the patches are loaded. You still have to send a program change at "play time" for the synth
        // to switch to that patch
    }


    /// Check to see if the `AUGraph` is Initialized.
    ///
    /// - returns: `true` if it's running, `false` if not
    /// - seealso: [AUGraphIsInitialized](/https://developer.apple.com/library/prerelease/ios/documentation/AudioToolbox/Reference/AUGraphServicesReference/index.html#//apple_ref/c/func/AUGraphIsInitialized)
    func isGraphInitialized() -> Bool {
        var outIsInitialized = DarwinBoolean(false)
        let status = AUGraphIsInitialized(self.processingGraph!, &outIsInitialized)
        AudioUtils.CheckError(status)
        return outIsInitialized.boolValue
    }

    /// Initializes the `AUGraph.
    func initializeGraph() {
        let status = AUGraphInitialize(self.processingGraph!)
        AudioUtils.CheckError(status)
    }

    /// Starts the `AUGraph`
    func startGraph() {
        let status = AUGraphStart(self.processingGraph!)
        AudioUtils.CheckError(status)
    }

    /// Check to see if the `AUGraph` is running.
    ///
    /// - returns: `true` if it's running, `false` if not
    func isGraphRunning() -> Bool {
        var isRunning = DarwinBoolean(false)
        let status = AUGraphIsRunning(self.processingGraph!, &isRunning)
        AudioUtils.CheckError(status)
        return isRunning.boolValue
    }

    /// Generate a random pitch between 36 (C below middle C) and 100.
    ///
    /// - postcondition: self.pitch is modified
    func generateRandomPitch() {
        pitch = arc4random_uniform(64) + 36 // 36 - 100
    }

//    /// Send a note on message using patch1 on channel 0
//    func playPatch1On() {
//
//        let channel = UInt32(0)
//        let noteCommand = UInt32(0x90 | channel)
//        let pcCommand = UInt32(0xC0 | channel)
//        var status = OSStatus(noErr)
//
//        generateRandomPitch()
//        print(pitch)
//        status = MusicDeviceMIDIEvent(self.midisynthUnit!, pcCommand, patch1, 0, 0)
//        AudioUtils.CheckError(status)
//        status = MusicDeviceMIDIEvent(self.midisynthUnit!, noteCommand, pitch, 64, 0)
//        AudioUtils.CheckError(status)
//    }
//
//    /// Send a note off message using patch1 on channel 0
//    func playPatch1Off() {
//        let channel = UInt32(0)
//        let noteCommand = UInt32(0x80 | channel)
//        var status = OSStatus(noErr)
//        status = MusicDeviceMIDIEvent(self.midisynthUnit!, noteCommand, pitch, 0, 0)
//        AudioUtils.CheckError(status)
//    }
//
//    /// Send a note on message using patch2 on channel 0
//    func playPatch2On(midi: Int) {
//
//        let channel = UInt32(0)
//        let noteCommand = UInt32(0x90 | channel)
//        let pcCommand = UInt32(0xC0 | channel)
//        var status = OSStatus(noErr)
//        pitch = UInt32(midi)
//        //generateRandomPitch()
//        print(pitch)
//        status = MusicDeviceMIDIEvent(self.midisynthUnit!, pcCommand, patch2, 0, 0)
//        AudioUtils.CheckError(status)
//        status = MusicDeviceMIDIEvent(self.midisynthUnit!, noteCommand, pitch, 64, 0)
//        AudioUtils.CheckError(status)
//    }
//
//    /// Send a note off message using patch2 on channel 0
//    func playPatch2Off() {
//        let channel = UInt32(0)
//        let noteCommand = UInt32(0x80 | channel)
//        var status = OSStatus(noErr)
//        status = MusicDeviceMIDIEvent(self.midisynthUnit!, noteCommand, pitch, 0, 0)
//        AudioUtils.CheckError(status)
//    }
//

    /// Send a note on message using patch2 on channel 0
    func playPitch(midi: Int) {

        let channel = UInt32(0)
        let noteCommand = UInt32(0x90 | channel)
        let pcCommand = UInt32(0xC0 | channel)
        var status = OSStatus(noErr)

        status = MusicDeviceMIDIEvent(self.midisynthUnit!, pcCommand, patch2, 0, 0)
        AudioUtils.CheckError(status)
        status = MusicDeviceMIDIEvent(self.midisynthUnit!, noteCommand, UInt32(midi), 64, 0)
        AudioUtils.CheckError(status)
    }

    /// Send a note off message using patch2 on channel 0
    func stopPitch(midi: Int) {
        let channel = UInt32(0)
        let noteCommand = UInt32(0x80 | channel)
        var status = OSStatus(noErr)
        status = MusicDeviceMIDIEvent(self.midisynthUnit!, noteCommand, UInt32(midi), 0, 0)
        AudioUtils.CheckError(status)
    }
    
    
    /// Create a test `MusicSequence`.
    ///
    /// - throws: Nothing, but it should
    /// - todo: create an `ErrorType` ennum
    /// - returns: a `MusicSequence`
    func createMusicSequence() -> MusicSequence {
        
        var musicSequence: MusicSequence?
        var status = NewMusicSequence(&musicSequence)
        if status != noErr {
            print("\(#line) bad status \(status) creating sequence")
        }
        
        // add a track
        var track: MusicTrack?
        status = MusicSequenceNewTrack(musicSequence!, &track)
        if status != noErr {
            print("error creating track \(status)")
        }
        
        var channel = UInt8(0)
        // bank select msb
        var chanmess = MIDIChannelMessage(status: 0xB0 | channel, data1: 0, data2: 0, reserved: 0)
        status = MusicTrackNewMIDIChannelEvent(track!, 0, &chanmess)
        if status != noErr {
            print("creating bank select event \(status)")
        }
        // bank select lsb
        chanmess = MIDIChannelMessage(status: 0xB0 | channel, data1: 32, data2: 0, reserved: 0)
        status = MusicTrackNewMIDIChannelEvent(track!, 0, &chanmess)
        if status != noErr {
            print("creating bank select event \(status)")
        }
        
        // program change. first data byte is the patch, the second data byte is unused for program change messages.
        chanmess = MIDIChannelMessage(status: 0xC0 | channel, data1: UInt8(patch1), data2: 0, reserved: 0)
        status = MusicTrackNewMIDIChannelEvent(track!, 0, &chanmess)
        if status != noErr {
            print("creating program change event \(status)")
        }
        
        // now make some notes and put them on the track
        var beat = MusicTimeStamp(0.0)
        for i: UInt8 in 60...72 {
            var mess = MIDINoteMessage(channel: channel,
                                       note: i,
                                       velocity: 64,
                                       releaseVelocity: 0,
                                       duration: 1.0 )
            status = MusicTrackNewMIDINoteEvent(track!, beat, &mess)
            if status != noErr {
                print("creating new midi note event \(status)")
            }
            beat += 1
        }
        
        // another track
        
        channel = UInt8(1)
        
        track = nil
        status = MusicSequenceNewTrack(musicSequence!, &track)
        if status != noErr {
            print("error creating track \(status)")
        }
        
        chanmess = MIDIChannelMessage(status: 0xB0 | channel, data1: 0, data2: 0, reserved: 0)
        status = MusicTrackNewMIDIChannelEvent(track!, 0, &chanmess)
        if status != noErr {
            print("creating bank select msb event \(status)")
        }
        
        chanmess = MIDIChannelMessage(status: 0xB0 | channel, data1: 32, data2: 0, reserved: 0)
        status = MusicTrackNewMIDIChannelEvent(track!, 0, &chanmess)
        if status != noErr {
            print("creating bank select lsb event \(status)")
        }
        
        chanmess = MIDIChannelMessage(status: 0xC0 | channel, data1: UInt8(patch2), data2: 0, reserved: 0)
        status = MusicTrackNewMIDIChannelEvent(track!, 0, &chanmess)
        if status != noErr {
            print("creating program change event \(status)")
        }
        
        beat = MusicTimeStamp(3.0)
        for i: UInt8 in 60...72 {
            var mess = MIDINoteMessage(channel: channel,
                                       note: i,
                                       velocity: 36,
                                       releaseVelocity: 0,
                                       
                                       duration: 1.0 )
            status = MusicTrackNewMIDINoteEvent(track!, beat, &mess)
            if status != OSStatus(noErr) {
                print("creating new midi note event \(status)")
            }
            beat += 1
        }
        
        // associate the AUGraph with the sequence.
        status = MusicSequenceSetAUGraph(musicSequence!, self.processingGraph)
        
        // Let's see it
        CAShow(UnsafeMutablePointer<MusicSequence>(musicSequence!))
        
        return musicSequence!
    }
    
    /// Create a `MusicPlayer` with the specified sequence.
    ///
    /// - parameters:
    ///   - musicSequence: a valid `MusicSequence` instance
    /// - throws: Nothing, but it should
    /// - todo: create an `ErrorType` ennum
    /// - returns: a `MusicPlayer`
    func createPlayer(_ musicSequence: MusicSequence) -> MusicPlayer {
        var musicPlayer: MusicPlayer?
        
        var status = NewMusicPlayer(&musicPlayer)
        if status != OSStatus(noErr) {
            print("bad status \(status) creating player")
            AudioUtils.CheckError(status)
        }
        
        status = MusicPlayerSetSequence(musicPlayer!, musicSequence)
        if status != OSStatus(noErr) {
            print("setting sequence \(status)")
            AudioUtils.CheckError(status)
        }
        status = MusicPlayerPreroll(musicPlayer!)
        if status != OSStatus(noErr) {
            print("prerolling player \(status)")
            AudioUtils.CheckError(status)
        }
        return musicPlayer!
    }
    
    /// Make the `MusicPlayer` play its sequence
    /// - throws: Nothing, but it should
    /// - todo: create an `ErrorType` ennum
    func musicPlayerPlay() {
        var status = noErr
        var playing: DarwinBoolean = false
        status = MusicPlayerIsPlaying(musicPlayer, &playing)
        if playing != false {
            status = MusicPlayerStop(musicPlayer)
            if status != noErr {
                print("Error stopping \(status)")
                AudioUtils.CheckError(status)
                return
            }
        }
        
        status = MusicPlayerSetTime(musicPlayer, 0)
        if status != noErr {
            print("setting time \(status)")
            AudioUtils.CheckError(status)
            return
        }
        
        status = MusicPlayerStart(musicPlayer)
        if status != noErr {
            print("Error starting \(status)")
            AudioUtils.CheckError(status)
            return
        }
    }
    
}

