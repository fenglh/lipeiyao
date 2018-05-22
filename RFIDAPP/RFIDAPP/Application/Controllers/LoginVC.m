//
//  LoginVC.m
//  RFIDAPP
//
//  Created by Apple Developer on 4/1/18.
//  Copyright © 2018 Apple Developer. All rights reserved.
//


#import "MySQLManager.h"
#import "ForgetPwdMobileVC.h"
#import "RootNavigationController.h"
#import "AppDelegate.h"
@interface LoginVC ()



@property (strong, nonatomic) IBOutlet UITextField *usernameTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;

@property (strong, nonatomic) IBOutlet UIButton *loginButton;
@property (strong, nonatomic) IBOutlet UIButton *forgotButton;



@end

@implementation LoginVC

- (void)dealloc{
    //移除通知监听
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //隐藏导航栏
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //显示导航栏
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 加载视图后执行任何附加设置.
    [self initUI];
    //监听textFild输入事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChange:) name:UITextFieldTextDidChangeNotification object:nil];
}



#pragma mark - 设置UI

- (void) initUI {
    //圆形按钮
    [commonUtils setRoundedRectBorderButton:self.loginButton withBorderRadius:4];
    //激活按钮
    [self.loginButton activateBtn:[self checkEmpty]];
}


#pragma mark - 私有方法
//检查输入
- (BOOL)checkEmpty {
    //检查账号和密码是否为空
    if (self.usernameTextField.text.length <= 0) {
        return NO;
    }
    if (self.passwordTextField.text.length <= 0) {
        return NO;
    }
    return YES;
}


#pragma mark - 公有方法

#pragma mark - tableView 相关

#pragma mark - delegate 相关

#pragma mark - 事件响应
- (IBAction)userLogin:(id)sender {
    
    [BMShowHUD showToView:self.view];
    [self.view endEditing:YES];
    @weakify(self);;
    [[MySQLManager shareInstance] loginWithUserName:self.usernameTextField.text pwd:self.passwordTextField.text callback:^(BOOL success, NSString *errMsg) {
        @strongify(self);
        if (success) {
            dispatch_async(dispatch_get_main_queue(), ^ {
                @strongify(self);
                //获取Main.storyboard
                UIStoryboard *mainStory = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                //获取Main.storyboard中的第2个视图
                RootNavigationController *vc = [mainStory instantiateViewControllerWithIdentifier:@"RootNavigationController"];
                //切换跟控制器
                [UIApplication sharedApplication].keyWindow.rootViewController = vc;
                [BMShowHUD showSuccess:@"登录成功"];
                //保存当前登录的用户名
                AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
                delegate.currentUserName = self.usernameTextField.text;
            });
        }else{
            if (errMsg) {
                [BMShowHUD showMessage:errMsg];
            }else{
                [BMShowHUD showMessage:@"账号或者密码错误"];
            }

        }
    }];

    
}
//传值
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"forgetpwd"]) {
        ForgetPwdMobileVC *vc = segue.destinationViewController;
        vc.userName = self.usernameTextField.text;
    }
}




//textFile内容输入变化事件
- (void)textFieldDidChange:(NSNotification *)notification {
    UITextField *textField = notification.object;
    NSString *toBeString = textField.text;
    BOOL ok = NO;
    //输入的是用户名
    if (textField == self.usernameTextField) {
        //账号输入框输入的内容长度>0 && 密码框的内容长度 >0
        ok = toBeString.length && self.passwordTextField.text.length;
    }
    //输入的是密码
    else if (textField == self.passwordTextField){
        //密码输入框的内容长度>0 && 账号框的内容长度 >0
        ok = toBeString.length && self.usernameTextField.text.length;
    }else{
        //不是当前界面textFiled 响应，则不做任何处理
        return;
    }
    //激活按钮
    [self.loginButton activateBtn:ok];
}




#pragma mark - getters setters

#pragma mark - 接口相关


@end
