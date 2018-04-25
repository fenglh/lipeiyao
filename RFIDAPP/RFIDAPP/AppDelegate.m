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
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    
    GLobalRealReachability.hostForPing = @"www.baidu.com";//其他域名，会导致返回两次网络状态，最后一次为不可达！
    [GLobalRealReachability startNotifier];//网络监测
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(netWorkChange:) name:kRealReachabilityChangedNotification object:nil];
    // 在应用程序启动后进行自定义的覆盖点.
    [[MySQLManager shareInstance] connetctMySQL];
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


@end
