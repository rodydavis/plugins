//
//  Generated file. Do not edit.
//

#import "GeneratedPluginRegistrant.h"
#import <get_version/GetVersionPlugin.h>
#import <package_info/PackageInfoPlugin.h>
#import <shared_preferences/SharedPreferencesPlugin.h>

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [GetVersionPlugin registerWithRegistrar:[registry registrarForPlugin:@"GetVersionPlugin"]];
  [FLTPackageInfoPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTPackageInfoPlugin"]];
  [FLTSharedPreferencesPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTSharedPreferencesPlugin"]];
}

@end
