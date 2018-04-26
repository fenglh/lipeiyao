//
//  SetPasswordVC.m
//  RFIDAPP
//
//  Created by Apple Developer on 4/1/16.
//  Copyright © 2018 Apple Developer. All rights reserved.
//

#import "SetPasswordVC.h"


#define MAX_COUNT_DOWN 10 //重获获取验证码时间间隔

static unsigned int  countDown ;

@interface SetPasswordVC ()


@property (strong, nonatomic) IBOutlet UIView *mainContainerView;
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;            //验证码输入框
@property (strong, nonatomic) IBOutlet UITextField *passwordText;           //密码
@property (strong, nonatomic) IBOutlet UITextField *confirmPasswordText;    //确认密码
@property (strong, nonatomic) IBOutlet UIButton *setPasswordButton;         //重置密码按钮
@property (weak, nonatomic) IBOutlet UIButton *codeBtn;                     //验证码按钮
@property (nonatomic, strong) NSTimer *timer;                               ///< 定时器
//正常来说，应该在后端校验短信验证码，因为没有后端，所以在前段校验.这里保存从数据库获取回来的验证码

@end

@implementation SetPasswordVC

- (void)dealloc{
    //移除通知监听
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 加载视图后执行任何附加设置
    [self initUI];
    //监听textField控件输入
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChange:) name:UITextFieldTextDidChangeNotification object:nil];
    [self startTimer];
}


#pragma mark - 设置UI

- (void) initUI {
    //设置圆角
    [commonUtils setRoundedRectBorderButton:self.setPasswordButton withBorderRadius:4.f];
    [commonUtils setRoundedRectBorderButton:self.codeBtn withBorderRadius:2.f];
    //激活按钮
    [self.setPasswordButton activateBtn:[self checkEmpty]];
}





#pragma mark - 私有方法
//检查输入
- (BOOL)checkEmpty {
    if (self.codeTextField.text.length <= 0) {
        return NO;
    }
    if (self.passwordText.text.length <= 0) {
        return NO;
    }
    if (self.confirmPasswordText.text.length <= 0) {
        return NO;
    }
    return YES;
}

- (BOOL)checkInput {
    //检查两次输入密码是否一致
    if (![self.passwordText.text isEqualToString:self.confirmPasswordText.text]) {
        [BMShowHUD showMessage:@"两次输入的密码不一致"];
        return  NO;
    }
    
    return YES;
}

//提交重置密码
- (void)submitSetPassword {
    [BMShowHUD show];//loading
    [self.view endEditing:YES];
    //这里直接校验验证码是否正确，如果正确那么调用MySQLManager来修改远程数据库的密码。
    //(正常逻辑应该调用服务端接口，让服务端来操作）
    if (! [self.verificationCode isEqualToString:self.codeTextField.text]) { //本地校验验证码
        [BMShowHUD showMessage:@"验证码不正确"];
        return;
    }
    //模拟服务器请求，延迟1秒处理
    @weakify(self);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[MySQLManager shareInstance] resetPassword:self.userName pwd:self.passwordText.text callback:^(BOOL success, NSString *errMsg) {
            @strongify(self);
            if (success) {
                [BMShowHUD showSuccess:@"密码重置成功!"];
                [self.navigationController popToRootViewControllerAnimated:YES];
            }else{
                if (errMsg) {
                    [BMShowHUD showMessage:errMsg];
                } else {
                    [BMShowHUD showSuccess:@"密码重置失败"];
                }
            }
        }];

    });
    
}

//验证码按钮倒计时
- (void)startTimer {
    
    if (self.timer) {
        return;
    }
    [self activateCodeBtn:NO countDown:MAX_COUNT_DOWN];
    
    countDown = MAX_COUNT_DOWN;
    __weak typeof(self) weakSelf = self; //防止循环引用
    self.timer = [NSTimer timerWithTimeInterval:1.0f target:self selector:@selector(timerEvent:) userInfo:nil repeats:YES];
    //加入runloop
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)timerEvent:(NSTimer *)timer {
    countDown --;
    if (countDown == 0) {
        [self.timer invalidate];
        self.timer = nil;
        [self activateCodeBtn:YES countDown:countDown];
    }else{
        [self activateCodeBtn:NO countDown:countDown];
    }
}

//激活验证码按钮
- (void)activateCodeBtn:(BOOL)enable countDown:(NSInteger)countDown {
    if (enable) {
        self.codeBtn.userInteractionEnabled = YES;
        [self.codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [self.codeBtn setBackgroundColor:[UIColor colorWithHexString:@"A4D7D7"]];
    }else {
        [self.codeBtn setTitle:[NSString stringWithFormat:@"重新获取(%@)", @(countDown)] forState:UIControlStateNormal];
        [self.codeBtn setBackgroundColor:[UIColor colorWithHexString:@"ebebeb"]];
        self.codeBtn.userInteractionEnabled = NO;
    }
}
#pragma mark - 公有方法

#pragma mark - tableView 相关

#pragma mark - delegate 相关

#pragma mark - 事件响应


//监听输入内容变化
- (void)textFieldDidChange:(NSNotification *)notification {
    UITextField *textField = notification.object;
    NSString *toBeString = textField.text;
    BOOL ok = NO;
    if (textField == self.codeTextField) {
        ok = toBeString.length && self.passwordText.text.length && self.confirmPasswordText.text.length;
    }else if (textField == self.passwordText){
        ok = toBeString.length && self.codeTextField.text.length && self.confirmPasswordText.text.length;
    }else if (textField == self.confirmPasswordText){
        ok = toBeString.length && self.codeTextField.text.length && self.passwordText.text.length;
    }else{
        //不是当前界面textFiled 响应，则不做任何处理
        return;
    }
    [self.setPasswordButton activateBtn:ok];
}

//获取验证码
- (IBAction)getVerificationCode:(id)sender {
    //从远程数据库获取验证码
    if ([self getVerificationCode]) {
        [self startTimer];
    }
}

- (BOOL)getVerificationCode {
    self.verificationCode = nil;
    @weakify(self);
    [[MySQLManager shareInstance] getVerificationCode:self.mobile callback:^(NSString *code, NSString *errMsg) {
        @strongify(self);
        if (errMsg) {
            [BMShowHUD showMessage:errMsg];
        }else {
            self.verificationCode = code;//保存一下，以便校验
            [BMShowHUD showMessage:@"验证码已发送"];
        }
    }];

    

    return YES;
}





- (IBAction)setPasswordAction:(id)sender {
    if ([self checkInput]) { //检查两次密码是否一致
        [self submitSetPassword];
    }
}
@end
