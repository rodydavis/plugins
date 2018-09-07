#import "GetVersionPlugin.h"
#import <get_version/get_version-Swift.h>

@implementation GetVersionPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftGetVersionPlugin registerWithRegistrar:registrar];
}
@end
