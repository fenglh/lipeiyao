//
//  BMShowHUD.m
//  BMOnlineManagement
//
//  Created by lipeiyao on 2017/9/6.
//  Copyright © 2017年 xxx. All rights reserved.
//

#import "BMShowHUD.h"
#import "MBProgressHUD.h"
#import <objc/runtime.h>

typedef NS_ENUM(NSUInteger , BMHUDType){
    BMHUDTypeLoading,
    BMHUDTypeMessage,
    BMHUDTypeSuccess,
    BMHUDTypeError
};


@interface BMShowHUD ()<MBProgressHUDDelegate>

@property (nonatomic, assign) CGFloat keyboardHeight;
@property (nonatomic, weak) MBProgressHUD *hud;

@end
@implementation BMShowHUD

#pragma mark - 生命周期
+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    static BMShowHUD *shareInstance;
    dispatch_once(&onceToken, ^{
        shareInstance = [[BMShowHUD alloc] init];
        [shareInstance registerNotifications];
    });
    return shareInstance;
}



#pragma mark - 公有方法

//dismiss
+ (void)dismiss {
    [self dismiss:0];
}

+ (void)dismiss:(NSTimeInterval)delay {
    [[BMShowHUD shareInstance] dismiss:delay];
}

//loading
+ (void)show {
    [self show:nil];
}

+ (void)showToView:(UIView *)view {
    [self show:nil toView:view];
}

+ (void)show:(NSString *)message {
    [self show:message toView:nil];
}

+ (void)show:(NSString *)message toView:(UIView *)view {
    [self show:message toView:view afterDelay:20.f];
}

+ (void)show:(NSString *)message toView:(UIView *)view afterDelay:(CGFloat)delay {
    [[BMShowHUD shareInstance] show:message toView:view afterDelay:delay];
}

//文本
+ (void)showMessage:(NSString *)message {
    [self showMessage:message toView:nil];
}

+ (void)showMessage:(NSString *)message toView:(UIView *)view {
    [self showMessage:message toView:view afterDelay:3.f];
}

+ (void)showMessage:(NSString *)message toView:(UIView *)view afterDelay:(CGFloat)delay {
    [[BMShowHUD shareInstance] showMessage:message toView:view afterDelay:delay];
}

//成功
+ (void)showSuccess:(NSString *)success {
    [self showSuccess:success toView:nil];
}

+ (void)showSuccess:(NSString *)success toView:(UIView *)view {
    [self showSuccess:success toView:view afterDelay:3.f];
}

+ (void)showSuccess:(NSString *)success toView:(UIView *)view afterDelay:(CGFloat)delay {
    [[BMShowHUD shareInstance] showSuccess:success toView:view afterDelay:delay];
}

//失败
+ (void)showError:(NSString *)error {
    [self showError:error toView:nil];
}
+ (void)showError:(NSString *)error toView:(UIView *)view {
    [self showError:error toView:view afterDelay:3.f];
}

+ (void)showError:(NSString *)error toView:(UIView *)view afterDelay:(CGFloat)delay {
    [[BMShowHUD shareInstance] showError:error toView:view afterDelay:delay];
}

#pragma mark -  私有方法




- (void)keyboardWillShow:(NSNotification *)notification
{
    NSDictionary *info = notification.userInfo;
    self.keyboardHeight = [info[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    if (self.hud) {
        if (self.hud.centerY - self.keyboardHeight <= 40) {
            self.hud.offset =CGPointMake(0, -40);
        }
    }
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    self.keyboardHeight = 0;
    if (self.hud) {
        self.hud.offset =CGPointMake(0, 0);
    }
}

- (void)registerNotifications {

    //键盘事件通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}


- (void)show:(NSString *)message toView:(UIView *)view afterDelay:(CGFloat)delay {
    MBProgressHUD *hud = [self hud:BMHUDTypeLoading message:message toView:view afterDelay:delay];
    [self showHUD:hud toView:view duration:delay];
}


- (void)showMessage:(NSString *)message toView:(UIView *)view afterDelay:(CGFloat)delay {
    if (message == nil) {
        return;
    }
    MBProgressHUD *hud = [self hud:BMHUDTypeMessage message:message toView:view afterDelay:delay];
    [self showHUD:hud toView:view duration:delay];
}

- (void)showError:(NSString *)error toView:(UIView *)view afterDelay:(CGFloat)delay {
    if (error == nil) {
        return;
    }
    MBProgressHUD *hud = [self hud:BMHUDTypeError message:error toView:view afterDelay:delay];
    [self showHUD:hud toView:view duration:delay];
}

- (void)showSuccess:(NSString *)success toView:(UIView *)view afterDelay:(CGFloat)delay {
    if (success == nil) {
        return;
    }
    MBProgressHUD *hud = [self hud:BMHUDTypeSuccess message:success toView:view afterDelay:delay];
    [self showHUD:hud toView:view duration:delay];
}

- (void)dismiss:(CGFloat)delay {
    if (self.hud) {
        [self.hud hideAnimated:YES afterDelay:delay];
    }
}


- (void)showHUD:(MBProgressHUD *)hud toView:(UIView *)view duration:(NSTimeInterval )duration {
    [self dismiss:0];
    if (hud == nil) {
        return;
    }
    if (view == nil) {
        view = [self frontWindow];
    }

    [view addSubview:hud];
    [hud showAnimated:YES];
    [hud hideAnimated:YES afterDelay:duration];
    self.hud = hud;
}



//生成hud
- (MBProgressHUD *)hud:(BMHUDType)type message:(NSString *)message toView:(UIView *)view afterDelay:(CGFloat)delay{
    
    if (view == nil) {
        view = [self frontWindow];
    }
    
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
    objc_setAssociatedObject(hud, "toView", view, OBJC_ASSOCIATION_ASSIGN);
    objc_setAssociatedObject(hud, "duration", @(delay), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(hud, "isTapDismissEnabled", @(YES), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    hud.removeFromSuperViewOnHide = YES;
    [hud.backgroundView removeFromSuperview];
    hud.margin = 10.f;
    hud.label.font = [UIFont systemFontOfSize:15];
    hud.label.text = message;
    hud.label.numberOfLines = 0;
    hud.userInteractionEnabled = NO;
    hud.delegate = self;
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.color = [[UIColor blackColor] colorWithAlphaComponent:0.8];
    hud.contentColor = [UIColor whiteColor];
    CGFloat offsetY = self.keyboardHeight ? -40 :0 ;
    hud.offset = CGPointMake(0, offsetY);//中心位置
    hud.animationType = MBProgressHUDAnimationZoom;
    
    switch (type) {
        case BMHUDTypeLoading:{
            hud.mode = MBProgressHUDModeIndeterminate;
            hud.userInteractionEnabled = YES;
            hud.margin = 18;
        }
            break;
        case BMHUDTypeMessage:{
            hud.mode = MBProgressHUDModeText;
        }
            break;
        case BMHUDTypeSuccess:{
            hud.mode = MBProgressHUDModeCustomView;
            UIImage *image = [[UIImage imageNamed:@"success2"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
            hud.customView = imageView;
        }
            break;
        case BMHUDTypeError:{
            hud.mode = MBProgressHUDModeCustomView;
            UIImage *image = [[UIImage imageNamed:@"error2"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
            hud.customView = imageView;
        }
            break;
        default:
            hud.mode = MBProgressHUDModeText;
            break;
    }
    return hud;
}

- (UIWindow *)frontWindow {
    NSEnumerator *frontToBackWindows = [UIApplication.sharedApplication.windows reverseObjectEnumerator];
    for (UIWindow *window in frontToBackWindows) {
        BOOL windowOnMainScreen = window.screen == UIScreen.mainScreen;
        BOOL windowIsVisible = !window.hidden && window.alpha > 0;
        BOOL windowLevelSupported = (window.windowLevel >= UIWindowLevelNormal && window.windowLevel <= UIWindowLevelNormal);
        BOOL windowKeyWindow = window.isKeyWindow;
        
        if(windowOnMainScreen && windowIsVisible && windowLevelSupported && windowKeyWindow) {
            return window;
        }
    }
    return nil;
}



@end
