//
//  BMShowHUD.h
//  BMOnlineManagement
//
//  Created by lipeiyao on 2017/9/6.
//  Copyright © 2017年 xxx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BMShowHUD : NSObject

+ (void)show;
+ (void)showToView:(UIView *)view;

+ (void)show:(NSString *)message;
+ (void)show:(NSString *)message toView:(UIView *)view;
+ (void)show:(NSString *)message toView:(UIView *)view afterDelay:(CGFloat)delay;



+ (void)showMessage:(NSString *)message;
+ (void)showMessage:(NSString *)message toView:(UIView *)view;
+ (void)showMessage:(NSString *)message toView:(UIView *)view afterDelay:(CGFloat)delay;


+ (void)showError:(NSString *)error;
+ (void)showError:(NSString *)error toView:(UIView *)view;
+ (void)showError:(NSString *)error toView:(UIView *)view afterDelay:(CGFloat)delay;


+ (void)showSuccess:(NSString *)success;
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;
+ (void)showSuccess:(NSString *)success toView:(UIView *)view afterDelay:(CGFloat)delay;

+ (void)dismiss;
+ (void)dismiss:(NSTimeInterval)delay;
@end
