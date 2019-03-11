#import "FloatingSearchBarPlugin.h"
#import <floating_search_bar/floating_search_bar-Swift.h>

@implementation FloatingSearchBarPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFloatingSearchBarPlugin registerWithRegistrar:registrar];
}
@end
