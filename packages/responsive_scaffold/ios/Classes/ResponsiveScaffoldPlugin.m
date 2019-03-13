#import "ResponsiveScaffoldPlugin.h"
#import <responsive_scaffold/responsive_scaffold-Swift.h>

@implementation ResponsiveScaffoldPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftResponsiveScaffoldPlugin registerWithRegistrar:registrar];
}
@end
