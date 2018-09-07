#import "FlutterSmsPlugin.h"
#import <flutter_sms/flutter_sms-Swift.h>

@implementation FlutterSmsPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterSmsPlugin registerWithRegistrar:registrar];
}
@end
