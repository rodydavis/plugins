//
//  AudioUtils.swift
//  SwiftMusic
//
//  Created by Gene De Lisa on 2/28/15.
//  Copyright (c) 2015 Gene De Lisa. All rights reserved.
//

import Foundation
import AudioToolbox
import CoreAudio

// swiftlint:disable function_body_length
// swiftlint:disable type_body_length
// swiftlint:disable file_length


#if os(OSX)
    // for UTCreateStringForOSType
    import CoreServices
    
#endif

#if os(tvOS)
#elseif os(iOS)
    import CoreMIDI
#endif

import AVFoundation


/// # A few utilities for using Core Audio.
///
/// I started with [Adamson's](http://amzn.to/1KG0yWe) Objective-C CheckError method. The translation
/// into Swift was a bit of a pain.
///
/// - author: Gene De Lisa
/// - copyright: 2016 Gene De Lisa
/// - date: February 2016
open class AudioUtils {
    
    fileprivate init() {
    }
    
    
    
    ///  Create a String from an encoded 4char.
    ///
    ///  - parameter n: The encoded 4char
    ///
    ///  - returns: The String representation.
    class func stringFrom4(_ n: Int) -> String {
        
        var scalar = UnicodeScalar((n >> 24) & 255)
        if !scalar!.isASCII {
            return ""
        }
        var s = String(describing: scalar)
        
        scalar = UnicodeScalar((n >> 16) & 255)
        if !scalar!.isASCII {
            return ""
        }
        s.append(String(describing: scalar))
        
        scalar = UnicodeScalar((n >> 8) & 255)
        if !scalar!.isASCII {
            return ""
        }
        s.append(String(describing: scalar))
        
        scalar = UnicodeScalar(n & 255)
        if !scalar!.isASCII {
            return ""
        }
        s.append(String(describing: scalar))
        
        
        return s
    }
    
    ///  Create a String from an encoded 4char.
    ///
    ///  - parameter status: an `OSStatus` containing the encoded 4char.
    ///
    ///  - returns: The String representation.
    class func stringFrom4(_ status: OSStatus) -> String {
        let n = Int(status)
        return stringFrom4(n)
    }
    
    ///  Create an encoded 4char from a String.
    ///
    ///  - parameter s: The String.
    ///
    ///  - returns: the encoded Int
    class func valueFromString4(_ s: String) -> Int {
        var n = 0
        var r = ""
        
        if s.count > 4 {
            let startIndex = s.index(s.startIndex, offsetBy: 4)
            //            r = s.substring(from: startIndex)
            r = String(s[startIndex...])
        } else {
            r = s + "    "
            let startIndex = s.index(s.startIndex, offsetBy: 4)
            //            r = r.substring(to: startIndex)
            r = String(r[...startIndex])
            
        }
        
        for UniCodeChar in r.unicodeScalars {
            n = (n << 8) + (Int(UniCodeChar.value) & 255)
        }
        
        return n
    }
    
    
    // osx only
    //let s = UTCreateStringForOSType(error)
    //
    //        let e = UInt32(error)
    ////        let swapped = CFSwapInt32HostToBig(e)
    //        let swapped = e
    //
    //        let b1 = Character(UnicodeScalar(swapped & 0b00001))
    //        let b2 = Character(UnicodeScalar(swapped & 0b00010))
    //        let b3 = Character(UnicodeScalar(swapped & 0b00100))
    //        let b4 = Character(UnicodeScalar(swapped & 0b01000))
    //        print("check error string: \(b1) \(b2) \(b3) \(b4)")
    //    func OSTypeFrom(string : String) -> UInt {
    //        var result : UInt = 0
    //        if let data = string.dataUsingEncoding(NSMacOSRomanStringEncoding) {
    //            let bytes = UnsafePointer<UInt8>(data.bytes)
    //            for i in 0..<data.length {
    //                result = result << 8 + UInt(bytes[i])
    //            }
    //        }
    //        return result
    //    }
    
    
    //    func stringValue(unicodeValue: Int) -> String {
    //        var stringValue = ""
    //        var value = unicodeValue
    //        for _ in 0..<4 {
    //            stringValue = String(UnicodeScalar(value & 255)) + stringValue
    //            value = value / 256
    //        }
    //        return stringValue
    //    }
    
    
    
    #if os(tvOS)
    /// Check the status code
    ///
    /// - parameter error: The status to check.
    /// - todo: Finish this for tvOS
    class func CheckError(status: OSStatus) {
    if status == noErr {
    print("no error")
    return
    }
    print("error \(status)")
    }
    #elseif os(iOS)
    ///  Print a description of the status code to stdout if it's an error.
    ///
    ///  - parameter status: the status to check.
    class func CheckError(_ status: OSStatus) {
    
    if status == noErr {
    return
    }
    
    let s = stringFrom4(status)
    print("error chars '\(s)'")
    
    
    switch status {
    // AudioToolbox
    case kAUGraphErr_NodeNotFound:
    print("kAUGraphErr_NodeNotFound")
    
    case kAUGraphErr_OutputNodeErr:
    print("kAUGraphErr_OutputNodeErr")
    
    case kAUGraphErr_InvalidConnection:
    print("kAUGraphErr_InvalidConnection")
    
    case kAUGraphErr_CannotDoInCurrentContext:
    print("kAUGraphErr_CannotDoInCurrentContext")
    
    case kAUGraphErr_InvalidAudioUnit:
    print("kAUGraphErr_InvalidAudioUnit")
    
    case kMIDIInvalidClient :
    print("kMIDIInvalidClient ")
    
    
    case kMIDIInvalidPort :
    print("kMIDIInvalidPort ")
    
    
    case kMIDIWrongEndpointType :
    print("kMIDIWrongEndpointType")
    
    
    case kMIDINoConnection :
    print("kMIDINoConnection ")
    
    
    case kMIDIUnknownEndpoint :
    print("kMIDIUnknownEndpoint ")
    
    
    case kMIDIUnknownProperty :
    print("kMIDIUnknownProperty ")
    
    
    case kMIDIWrongPropertyType :
    print("kMIDIWrongPropertyType ")
    
    
    case kMIDINoCurrentSetup :
    print("kMIDINoCurrentSetup ")
    
    
    case kMIDIMessageSendErr :
    print("kMIDIMessageSendErr ")
    
    
    case kMIDIServerStartErr :
    print("kMIDIServerStartErr ")
    
    
    case kMIDISetupFormatErr :
    print("kMIDISetupFormatErr ")
    
    
    case kMIDIWrongThread :
    print("kMIDIWrongThread ")
    
    
    case kMIDIObjectNotFound :
    print("kMIDIObjectNotFound ")
    
    
    case kMIDIIDNotUnique :
    print("kMIDIIDNotUnique ")
    
    
    case kAudioToolboxErr_InvalidSequenceType :
    print("kAudioToolboxErr_InvalidSequenceType ")
    
    case kAudioToolboxErr_TrackIndexError :
    print("kAudioToolboxErr_TrackIndexError ")
    
    case kAudioToolboxErr_TrackNotFound :
    print("kAudioToolboxErr_TrackNotFound ")
    
    case kAudioToolboxErr_EndOfTrack :
    print("kAudioToolboxErr_EndOfTrack ")
    
    case kAudioToolboxErr_StartOfTrack :
    print("kAudioToolboxErr_StartOfTrack ")
    
    case kAudioToolboxErr_IllegalTrackDestination:
    print("kAudioToolboxErr_IllegalTrackDestination")
    
    case kAudioToolboxErr_NoSequence :
    print("kAudioToolboxErr_NoSequence ")
    
    case kAudioToolboxErr_InvalidEventType    :
    print("kAudioToolboxErr_InvalidEventType")
    
    case kAudioToolboxErr_InvalidPlayerState:
    print("kAudioToolboxErr_InvalidPlayerState")
    
    case kAudioUnitErr_InvalidProperty    :
    print("kAudioUnitErr_InvalidProperty")
    
    case kAudioUnitErr_InvalidParameter    :
    print("kAudioUnitErr_InvalidParameter")
    
    case kAudioUnitErr_InvalidElement :
    print("kAudioUnitErr_InvalidElement")
    
    case kAudioUnitErr_NoConnection    :
    print("kAudioUnitErr_NoConnection")
    
    case kAudioUnitErr_FailedInitialization    :
    print("kAudioUnitErr_FailedInitialization")
    
    case kAudioUnitErr_TooManyFramesToProcess:
    print("kAudioUnitErr_TooManyFramesToProcess")
    
    case kAudioUnitErr_InvalidFile:
    print("kAudioUnitErr_InvalidFile")
    
    case kAudioUnitErr_FormatNotSupported :
    print("kAudioUnitErr_FormatNotSupported")
    
    case kAudioUnitErr_Uninitialized:
    print("kAudioUnitErr_Uninitialized")
    
    case kAudioUnitErr_InvalidScope :
    print("kAudioUnitErr_InvalidScope")
    
    case kAudioUnitErr_PropertyNotWritable :
    print("kAudioUnitErr_PropertyNotWritable")
    
    case kAudioUnitErr_InvalidPropertyValue :
    print("kAudioUnitErr_InvalidPropertyValue")
    
    case kAudioUnitErr_PropertyNotInUse :
    print("kAudioUnitErr_PropertyNotInUse")
    
    case kAudioUnitErr_Initialized :
    print("kAudioUnitErr_Initialized")
    
    case kAudioUnitErr_InvalidOfflineRender :
    print("kAudioUnitErr_InvalidOfflineRender")
    
    case kAudioUnitErr_Unauthorized :
    print("kAudioUnitErr_Unauthorized")
    
    case kAudioUnitErr_CannotDoInCurrentContext:
    print("kAudioUnitErr_CannotDoInCurrentContext")
    
    case kAudioUnitErr_FailedInitialization:
    print("kAudioUnitErr_FailedInitialization")
    
    case kAudioUnitErr_FileNotSpecified:
    print("kAudioUnitErr_FileNotSpecified")
    
    case kAudioUnitErr_FormatNotSupported:
    print("kAudioUnitErr_FormatNotSupported")
    
    case kAudioUnitErr_IllegalInstrument:
    print("kAudioUnitErr_IllegalInstrument")
    
    case kAudioUnitErr_Initialized:
    print("kAudioUnitErr_Initialized")
    
    case kAudioUnitErr_InstrumentTypeNotFound:
    print("kAudioUnitErr_InstrumentTypeNotFound")
    
    case kAudioUnitErr_InvalidElement:
    print("kAudioUnitErr_InvalidElement")
    
    case kAudioUnitErr_InvalidFile:
    print("kAudioUnitErr_InvalidFile")
    
    case kAudioUnitErr_InvalidOfflineRender:
    print("kAudioUnitErr_InvalidOfflineRender")
    
    case kAudioUnitErr_InvalidParameter:
    print("kAudioUnitErr_InvalidParameter")
    
    case kAudioUnitErr_InvalidProperty:
    print("kAudioUnitErr_InvalidProperty")
    
    case kAudioUnitErr_InvalidPropertyValue:
    print("kAudioUnitErr_InvalidPropertyValue")
    
    case kAudioUnitErr_InvalidScope:
    print("kAudioUnitErr_InvalidScope")
    
    case kAudioUnitErr_NoConnection:
    print("kAudioUnitErr_NoConnection")
    
    case kAudioUnitErr_PropertyNotInUse:
    print("kAudioUnitErr_PropertyNotInUse")
    
    case kAudioUnitErr_PropertyNotWritable:
    print("kAudioUnitErr_PropertyNotWritable")
    
    case kAudioUnitErr_TooManyFramesToProcess:
    print("kAudioUnitErr_TooManyFramesToProcess")
    
    case kAudioUnitErr_Unauthorized:
    print("kAudioUnitErr_Unauthorized")
    
    case kAudioUnitErr_Uninitialized:
    print("kAudioUnitErr_Uninitialized")
    
    case kAudioUnitErr_UnknownFileType:
    print("kAudioUnitErr_UnknownFileType")
    
    case kAudioComponentErr_InstanceInvalidated:
    print("kAudioComponentErr_InstanceInvalidated ")
    
    case kAudioComponentErr_DuplicateDescription:
    print("kAudioComponentErr_DuplicateDescription ")
    
    case kAudioComponentErr_UnsupportedType:
    print("kAudioComponentErr_UnsupportedType ")
    
    case kAudioComponentErr_TooManyInstances:
    print("kAudioComponentErr_TooManyInstances ")
    
    case kAudioComponentErr_NotPermitted:
    print("kAudioComponentErr_NotPermitted ")
    
    case kAudioComponentErr_InitializationTimedOut:
    print("kAudioComponentErr_InitializationTimedOut ")
    
    case kAudioComponentErr_InvalidFormat:
    print("kAudioComponentErr_InvalidFormat ")
    
    // in CoreAudioTypes
    case kAudio_UnimplementedError :
    print("kAudio_UnimplementedError")
    
    case kAudio_FileNotFoundError :
    print("kAudio_FileNotFoundError")
    
    case kAudio_FilePermissionError :
    print("kAudio_FilePermissionError")
    
    case kAudio_TooManyFilesOpenError :
    print("kAudio_TooManyFilesOpenError")
    
    case kAudio_BadFilePathError :
    print("kAudio_BadFilePathError")
    
    case kAudio_ParamError :
    print("kAudio_ParamError") // the infamous -50
    
    case kAudio_MemFullError :
    print("kAudio_MemFullError")
    
    
    default:
    print("huh?")
    print("bad status \(status)")
    //print("\(__LINE__) bad status \(error)")
    }
    }
    
    #endif
    
    
}

