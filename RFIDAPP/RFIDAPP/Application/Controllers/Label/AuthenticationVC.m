//
//  AuthenticationVC.m
//  RFIDAPP
//
//  Created by fenglh on 2018/4/25.
//  Copyright © 2018年 Apple Developer. All rights reserved.
//

#import "AuthenticationVC.h"

@interface AuthenticationVC ()
@property (weak, nonatomic) IBOutlet UITextField *labelIdTextField; //标签输入框
@property (weak, nonatomic) IBOutlet UIButton *authenticateBtn; //认证按钮

@end

@implementation AuthenticationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


#pragma mark - 设置UI

#pragma mark - 私有方法

#pragma mark - 公有方法

#pragma mark - tableView 相关

#pragma mark - delegate 相关

#pragma mark - 事件响应

//认证按钮点击
- (IBAction)authencateBtnOnClick:(id)sender {
}

//扫描按钮点击
- (IBAction)scanBtnOnClick:(id)sender {
}

@end
