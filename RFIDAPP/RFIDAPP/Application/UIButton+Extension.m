//
//  UIButton+Extension.m
//  RFIDAPP
//
//  Created by fenglh on 2018/4/24.
//  Copyright © 2018年 Apple Developer. All rights reserved.
//

#import "UIButton+Extension.h"

@implementation UIButton (Extension)

//激活按钮
- (void)activateBtn:(BOOL)enable {
    //设置背景颜色
    self.enabled = enable;//按钮允许点击
    self.backgroundColor = enable ? [UIColor colorWithHexString:@"ff6c47"] : [UIColor colorWithHexString:@"AAAAAA"];
}
@end
