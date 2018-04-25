//
//  ForgetPwdMobileVC.m
//  RFIDAPP
//
//  Created by fenglh on 2018/4/24.
//  Copyright © 2018年 Apple Developer. All rights reserved.
//

#import "ForgetPwdMobileVC.h"
#import "SetPasswordVC.h"

@interface ForgetPwdMobileVC ()
@property (weak, nonatomic) IBOutlet UIButton *nexBtn;
@property (weak, nonatomic) IBOutlet UITextField *mobileTextField;
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;

@property (nonatomic, strong) NSString *verificationCode; ///< 验证码

@end

@implementation ForgetPwdMobileVC
- (void)dealloc{
    //移除通知监听
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    //监听手机号码输入
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChange:) name:UITextFieldTextDidChangeNotification object:nil];
}

#pragma mark - 设置UI
- (void)initUI {
    //设置按钮圆角
    [commonUtils setRoundedRectBorderButton:self.nexBtn withBorderRadius:4.f];
    self.userNameTextField.text = self.userName;
    //激活按钮
    [self.nexBtn activateBtn:[self checkEmpty]];
    
    //设置第一响应者。即：聚焦
    if (! self.userNameTextField.text.length) {
        [self.userNameTextField becomeFirstResponder];
    }else{
        [self.mobileTextField becomeFirstResponder];
    }
}







#pragma mark - 私有方法
//检查输入
- (BOOL)checkEmpty {
    if (self.userNameTextField.text.length <= 0) {
        return NO;
    }
    if (self.mobileTextField.text.length <= 0) {
        return NO;
    }
    return YES;
}

#pragma mark - 公有方法

#pragma mark - tableView 相关

#pragma mark - delegate 相关

#pragma mark - 事件响应


#define MobileMaxCount 11


- (void)textFieldDidChange:(NSNotification *)notification {
    UITextField *textField = notification.object;
    NSString *toBeString = textField.text;
    if (MobileMaxCount >0 && toBeString.length > MobileMaxCount) {
        textField.text = [toBeString substringToIndex:MobileMaxCount];
    }
    BOOL ok = NO;
    if (textField == self.mobileTextField) {
        ok = toBeString.length && self.userNameTextField.text.length ;//非0即为真
    } else if (textField == self.userNameTextField){
        ok = toBeString.length && self.mobileTextField.text.length ;//非0即为真
    }else{
        //不是当前界面textFiled 响应，则不做任何处理
        return;
    }
    //激活按钮
    [self.nexBtn activateBtn:ok];
}

//点击空白，收起键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
//跳转前进行判断，return NO则不允许跳转
- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    if ([identifier isEqualToString:@"goSetPwd"]) {
        //判断用户名存在
        BOOL existUserName =  [[MySQLManager shareInstance] checkUserNameExist:self.userNameTextField.text];
        if (!existUserName) {
            [BMShowHUD showMessage:@"用户名不存在"];
            return NO;
        }
        //判断用户名对应的手机号存在
        BOOL exist =  [[MySQLManager shareInstance] checkMobileExist:self.mobileTextField.text userName:self.userNameTextField.text];
        if (!exist) {
            [BMShowHUD showMessage:@"手机号码不正确"];
            return NO;
        }
        //获取手机验证码
        self.verificationCode = [[MySQLManager shareInstance] getVerificationCode:self.mobileTextField.text];
    }
    return YES;
}

//传值
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"goSetPwd"]) {
        SetPasswordVC *vc = segue.destinationViewController;
        vc.userName = self.userNameTextField.text;
        vc.mobile = self.mobileTextField.text;
        vc.verificationCode = self.verificationCode;
    }
}



#pragma mark - getters setters

#pragma mark - 接口相关

@end
