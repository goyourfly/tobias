#import "TobiasPlugin.h"


@interface TobiasPlugin()
@end

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {

}


+(BOOL)handleOpenURL:(NSURL*)url{
  return NO;
}