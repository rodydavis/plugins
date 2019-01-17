#import "CupertinoControllersPlugin.h"
#import <cupertino_controllers/cupertino_controllers-Swift.h>

@implementation CupertinoControllersPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftCupertinoControllersPlugin registerWithRegistrar:registrar];
}
@end
