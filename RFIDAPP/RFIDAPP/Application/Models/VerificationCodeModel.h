//
//  VerificationCodeModel.h
//  RFIDAPP
//
//  Created by lipeiyao on 2018/4/25.
//  Copyright © 2018年 Apple Developer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VerificationCodeModel : NSObject
@property (nonatomic, strong) NSString *mobile; ///< 手机号
@property (nonatomic, strong) NSString *code;   ///< 验证码
@end
