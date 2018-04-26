//
//  UserModel.h
//  RFIDAPP
//
//  Created by lipeiyao on 2018/4/24.
//  Copyright © 2018年 Apple Developer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject
@property (nonatomic, strong) NSString *realName;   ///< 真实姓名
@property (nonatomic, strong) NSString *mobile;   ///< 手机号码
@property (nonatomic, strong) NSString *userName;   ///< 登录账号
@property (nonatomic, strong) NSString *userPwd;    ///< 登录密码
@property (nonatomic, strong) NSString *schoolId;   ///< 学号

@end
