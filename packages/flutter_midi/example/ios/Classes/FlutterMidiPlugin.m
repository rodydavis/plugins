#import "FlutterMidiPlugin.h"
#import <flutter_midi/flutter_midi-Swift.h>

@implementation FlutterMidiPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterMidiPlugin registerWithRegistrar:registrar];
}
@end
