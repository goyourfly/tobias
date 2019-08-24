#import "TobiasPlugin.h"


__weak TobiasPlugin* __tobiasPlugin;

@interface TobiasPlugin()

@property (readwrite,copy,nonatomic) FlutterResult callback;

@end



@implementation TobiasPlugin

-(id)init{
    if(self = [super init]){
        
        __tobiasPlugin  = self;
        
    }
    return self;
}

-(void)dealloc{
    
}

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"com.jarvanmo/tobias"
            binaryMessenger:[registrar messenger]];
  TobiasPlugin* instance = [[TobiasPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}



+(BOOL)handleOpenURL:(NSURL*)url{
  
    if(!__tobiasPlugin)return NO;
    return [__tobiasPlugin handleOpenURL:url];
    
}


-(BOOL)handleOpenURL:(NSURL*)url{
    
    if ([url.host isEqualToString:@"safepay"]) {

        __weak TobiasPlugin* __self = self;

        
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
             [__self onPayResultReceived:resultDic];
        }];

        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
             [__self onAuthResultReceived:resultDic];
         }];

        return YES;
    }
    return NO;
}

@end
