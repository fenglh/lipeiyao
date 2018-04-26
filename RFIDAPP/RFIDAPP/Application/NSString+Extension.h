//
//  NSString+Extension.h
//  RFIDAPP
//
//  Created by lipeiyao on 2018/4/26.
//  Copyright © 2018年 Apple Developer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)
//RC4加密解密使用相同的函数，将字符串传入后程序会自动识别。
+(NSString*)encodeRC4:(NSString*)aInput key:(NSString*)aKey;

@end
