#import "IsPiratedPlugin.h"
#if __has_include(<is_pirated/is_pirated-Swift.h>)
#import <is_pirated/is_pirated-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "is_pirated-Swift.h"
#endif

@implementation IsPiratedPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftIsPiratedPlugin registerWithRegistrar:registrar];
}
@end
