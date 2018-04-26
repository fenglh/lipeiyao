//
//  AuthenticationVC.m
//  RFIDAPP
//
//  Created by fenglh on 2018/4/25.
//  Copyright © 2018年 Apple Developer. All rights reserved.
//

#import "AuthenticationVC.h"
#import "ScanVC.h"

@interface AuthenticationVC ()
@property (weak, nonatomic) IBOutlet UITextField *labelIdTextField; //标签输入框
@property (weak, nonatomic) IBOutlet UIButton *authenticateBtn; //认证按钮

@end

@implementation AuthenticationVC

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChange:) name:UITextFieldTextDidChangeNotification object:nil];
    [self.authenticateBtn activateBtn:[self checkEmpty]];
}


#pragma mark - 设置UI

#pragma mark - 私有方法

//检查输入
- (BOOL)checkEmpty {
    //检查账号和密码是否为空
    if (self.labelIdTextField.text.length <= 0) {
        return NO;
    }
    return YES;
}

#pragma mark - 公有方法

#pragma mark - tableView 相关

#pragma mark - delegate 相关

#pragma mark - 事件响应




- (void)textFieldDidChange:(NSNotification *)notification {
    UITextField *textField = notification.object;
    NSString *toBeString = textField.text;
    BOOL ok = NO;
    if (textField == self.labelIdTextField) {
        ok = toBeString.length ;
    }else{
        return;
    }
    self.authenticateBtn.enabled = ok;
    self.authenticateBtn.backgroundColor = ok ? [UIColor colorWithHexString:@"ff6c47"] : [UIColor colorWithHexString:@"d7d7d7"];
}


//认证按钮点击
- (IBAction)authencateBtnOnClick:(id)sender {
}

//扫描按钮点击
- (IBAction)scanBtnOnClick:(id)sender {
    ScanVC *vc = [[ScanVC alloc] init];
    @weakify(self);
    vc.scanCallback = ^(NSString *content) {
        @strongify(self);
        //扫描到的结果填入书库狂
        self.labelIdTextField.text = content;
        //激活按钮
        [self.authenticateBtn activateBtn:YES];
    };
    //隐藏BottomBar
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
