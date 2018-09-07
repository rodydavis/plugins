#import "AppReviewPlugin.h"
#import <app_review/app_review-Swift.h>

@implementation AppReviewPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftAppReviewPlugin registerWithRegistrar:registrar];
}
@end
