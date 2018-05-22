//
//  RegisterViewController.m
//  RFIDAPP
//
//  Created by fenglh on 2018/5/22.
//  Copyright © 2018年 Apple Developer. All rights reserved.
//

#import "RegisterViewController.h"
#import "MySQLManager.h"

@interface RegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *realNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *schoolIdTextField;
@property (weak, nonatomic) IBOutlet UITextField *mobileTextField;
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;
@property (weak, nonatomic) IBOutlet UITextField *confirmPwdTextField;
@property (weak, nonatomic) IBOutlet UIButton *okBtn;

@end

@implementation RegisterViewController

- (void)dealloc{
    //移除通知监听
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChange:) name:UITextFieldTextDidChangeNotification object:nil];
    [self.okBtn activateBtn:[self checkEmpty]];
}


//检查输入
- (BOOL)checkEmpty {
    //检查账号和密码是否为空
    if (self.realNameTextField.text.length <= 0) {
        return NO;
    }
    if (self.schoolIdTextField.text.length <= 0) {
        return NO;
    }
    if (self.mobileTextField.text.length <= 0) {
        return NO;
    }
    if (self.userNameTextField.text.length <= 0) {
        return NO;
    }
    if (self.pwdTextField.text.length <= 0) {
        return NO;
    }
    if (self.confirmPwdTextField.text.length <= 0) {
        return NO;
    }
    return YES;
}
- (BOOL)checkPwd {
    if (![self.pwdTextField.text isEqualToString:self.confirmPwdTextField.text]) {
        return NO;
    }
    return YES;
}

#define MobileMaxCount 11

- (void)textFieldDidChange:(NSNotification *)notification {
    UITextField *textField = notification.object;
    NSString *toBeString = textField.text;
    BOOL ok = NO;
    if (textField == self.realNameTextField) {
        ok = toBeString.length && self.schoolIdTextField.text.length && self.mobileTextField.text.length &&self.userNameTextField.text.length && self.pwdTextField.text.length && self.confirmPwdTextField.text.length;
    }else  if (textField == self.schoolIdTextField) {
        ok = toBeString.length && self.realNameTextField.text.length  && self.mobileTextField.text.length &&self.userNameTextField.text.length && self.pwdTextField.text.length && self.confirmPwdTextField.text.length;
    }else  if (textField == self.mobileTextField) {
        if (MobileMaxCount >0 && toBeString.length > MobileMaxCount) {
            textField.text = [toBeString substringToIndex:MobileMaxCount];
        }
        ok = toBeString.length && self.realNameTextField.text.length && self.schoolIdTextField.text.length  &&self.userNameTextField.text.length && self.pwdTextField.text.length && self.confirmPwdTextField.text.length;
    }else  if (textField == self.userNameTextField) {
        ok = toBeString.length && self.realNameTextField.text.length && self.schoolIdTextField.text.length && self.mobileTextField.text.length  && self.pwdTextField.text.length && self.confirmPwdTextField.text.length;
    }else  if (textField == self.pwdTextField) {
        ok = toBeString.length && self.realNameTextField.text.length && self.schoolIdTextField.text.length && self.mobileTextField.text.length &&self.userNameTextField.text.length  && self.confirmPwdTextField.text.length;
    }else  if (textField == self.confirmPwdTextField) {
        ok = toBeString.length && self.realNameTextField.text.length && self.schoolIdTextField.text.length && self.mobileTextField.text.length &&self.userNameTextField.text.length && self.pwdTextField.text.length ;
    }
    
    else{
        return;
    }
    self.okBtn.enabled = ok;
    self.okBtn.backgroundColor = ok ? [UIColor colorWithHexString:@"ff6c47"] : [UIColor colorWithHexString:@"d7d7d7"];
}

- (IBAction)registerBtnOnClick:(id)sender {
    [self.view endEditing:YES];
    if (![self checkPwd]) {
        [BMShowHUD showMessage:@"两次密码输入不一致" toView:self.view];
        return;
    }
    [BMShowHUD showToView:self.view];
    //检查用户名是否存在
    [[MySQLManager shareInstance] checkUserNameExist:self.userNameTextField.text callback:^(BOOL exist, NSString *errMsg) {
        if (errMsg) {
            [BMShowHUD showMessage:errMsg];
            return ;
        }
        if (exist) {
            [BMShowHUD showMessage:@"该用户名已存在"];
            [self.userNameTextField becomeFirstResponder];
            return ;
        }
        [[MySQLManager shareInstance] addUser:self.realNameTextField.text schoolId:self.schoolIdTextField.text mobile:self.mobileTextField.text userName:self.userNameTextField.text pwd:self.pwdTextField.text callback:^(BOOL success, NSString *errMsg) {
            if (errMsg) {
                [BMShowHUD showMessage:errMsg];
                return ;
            }
            if (success) {
                [self.navigationController popToRootViewControllerAnimated:YES];
                [BMShowHUD showSuccess:@"注册成功!"];
                
            }
        }];
    }];
    


}

//点击空白，收起键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}


@end
