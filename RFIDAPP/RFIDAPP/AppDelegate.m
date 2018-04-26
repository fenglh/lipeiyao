//
//  AppDelegate.m
//  RFIDAPP
//
//  Created by Apple Developer on 4/1/16.
//  Copyright © 2016 Apple Developer. All rights reserved.
//

#import "AppDelegate.h"
#import "MySQLManager.h"
#import "RealReachability.h"
#import "TopToast.h"
#import "NSString+Extension.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    
    GLobalRealReachability.hostForPing = @"www.baidu.com";//其他域名，会导致返回两次网络状态，最后一次为不可达！
    [GLobalRealReachability startNotifier];//网络监测
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(netWorkChange:) name:kRealReachabilityChangedNotification object:nil];

    
    //测试rc4加密
    NSString *str = @"88888888";
    NSString *key =@"lipeiyao";
    

    
    NSString *encodeStr = [NSString encodeRC4:str key:key];
    NSLog(@"加密字符串: %@",encodeStr);
    NSLog(@"加密字符串Base64: %@",[encodeStr base64EncodedString]);
    
    NSString *decodeStr = [NSString encodeRC4:encodeStr key:key];
    NSLog(@"解密字符串: %@",decodeStr);
    return YES;
}


- (void)netWorkChange:(NSNotification *)notification {
    RealReachability *reachability = (RealReachability *)notification.object;
    ReachabilityStatus status = [reachability currentReachabilityStatus];
    NSString *msg;
    switch (status) {
        case RealStatusNotReachable:
        {
            [TopToast showToptoastWithText:@"当前网络不可达，请检查网络!"];
        }
            break;
        case RealStatusViaWWAN:
        {
            [TopToast showToptoastWithText:@"当前网络：2G/3G/4G"];
        }
            break;
        case RealStatusViaWiFi:
        {
            [TopToast showToptoastWithText:@"当前网络：WIFI"];
        }
            break;
            
        default:
            break;
    }
    NSLog(@"%@", msg);
}


void swap(int* s1,int* s2){
    int temp=*s1;
    *s1=*s2;
    *s2=temp;
}

-(NSString*) rc4Key:(NSString*) key str:(NSString*) str
{
    int j = 0;
    unichar res[str.length];
    const unichar* buffer = res;
    unsigned char s[256];
    for (int i = 0; i < 256; i++)
    {
        s[i] = i;
    }
    for (int i = 0; i < 256; i++)
    {
        j = (j + s[i] + [key characterAtIndex:(i % key.length)]) % 256;
        
        swap(s[i], s[j]);
    }
    
    int i = j = 0;
    
    for (int y = 0; y < str.length; y++)
    {
        i = (i + 1) % 256;
        j = (j + s[i]) % 256;
        swap(s[i], s[j]);
        
        unsigned char f = [str characterAtIndex:y] ^ s[ (s[i] + s[j]) % 256];
        res[y] = f;
    }
    return [NSString stringWithCharacters:buffer length:str.length];
}

@end
