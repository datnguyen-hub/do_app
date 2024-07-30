#import "SahashopCustomerPlugin.h"
#if __has_include(<sahashop_customer/sahashop_customer-Swift.h>)
#import <sahashop_customer/sahashop_customer-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "sahashop_customer-Swift.h"
#endif

@implementation SahashopCustomerPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftSahashopCustomerPlugin registerWithRegistrar:registrar];
}
@end
