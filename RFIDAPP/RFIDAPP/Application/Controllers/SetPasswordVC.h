//
//  SetPasswordVC.h
//  RFIDAPP
//
//  Created by Apple Developer on 4/1/16.
//  Copyright © 2016 Apple Developer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetPasswordVC : UIViewController<UITextFieldDelegate>
@property (nonatomic, strong) NSString *userName;   ///< 用户名
@property (nonatomic, strong) NSString *mobile;     ///< 手机号码

//上个界面获取到的验证码(因为验证码校验放在前段校验，所在这里直接传过来)
@property (nonatomic, strong) NSString *verificationCode; ///< 验证码
@end
