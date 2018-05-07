//
//  AddLabelVC.m
//  RFIDAPP
//
//  Created by lipeiyao on 2018/4/25.
//  Copyright © 2018年 Apple Developer. All rights reserved.
//

#import "AddLabelVC.h"
#import "ScanVC.h"

@interface AddLabelVC ()
@property (weak, nonatomic) IBOutlet UITextField *labelIdTextField;
@property (weak, nonatomic) IBOutlet UITextField *labelUserTextField;
@property (weak, nonatomic) IBOutlet UITextField *labelDescTextField;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;

@property (weak, nonatomic) IBOutlet UITextField *libraryNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *borrowedNumbersTextField; ///< 已借阅数量
@property (weak, nonatomic) IBOutlet UITextField *recommendedBooksTextField; ///< 推荐的书籍
@property (weak, nonatomic) IBOutlet UITextField *appointmentedBooksTextField; ///< 预约的书籍
@property (weak, nonatomic) IBOutlet UISwitch *statusSwitch; ///< 标签的状态,0关，1开


@end

@implementation AddLabelVC

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChange:) name:UITextFieldTextDidChangeNotification object:nil];
    [self.addBtn activateBtn:[self checkEmpty]];
}


#pragma mark - 设置UI

#pragma mark - 私有方法

//检查输入
- (BOOL)checkEmpty {
    //检查账号和密码是否为空
    if (self.labelIdTextField.text.length <= 0) {
        return NO;
    }
    if (self.labelUserTextField.text.length <= 0) {
        return NO;
    }
    if (self.labelDescTextField.text.length <= 0) {
        return NO;
    }
    
    if (self.libraryNameTextField.text.length <= 0) {
        return NO;
    }
    
    if (self.borrowedNumbersTextField.text.length <= 0) {
        return NO;
    }
    if (self.recommendedBooksTextField.text.length <= 0) {
        return NO;
    }
    
    if (self.appointmentedBooksTextField.text.length <= 0) {
        return NO;
    }
    
    return YES;
}

#pragma mark - 公有方法

#pragma mark - tableView 相关

#pragma mark - delegate 相关

#pragma mark - 事件响应




//监听textField 内容变化
- (void)textFieldDidChange:(NSNotification *)notification {
    UITextField *textField = notification.object;
    NSString *toBeString = textField.text;
    BOOL ok = NO;
    if (textField == self.labelIdTextField) {
        ok = toBeString.length  && self.labelUserTextField.text.length && self.labelDescTextField.text.length && self.libraryNameTextField.text.length && self.borrowedNumbersTextField.text.length && self.recommendedBooksTextField.text.length && self.appointmentedBooksTextField.text.length;
    }else if (textField == self.labelUserTextField){

        ok = toBeString.length  && self.labelIdTextField  && self.labelDescTextField.text.length && self.libraryNameTextField.text.length && self.borrowedNumbersTextField.text.length && self.recommendedBooksTextField.text.length && self.appointmentedBooksTextField.text.length;
    }else if (textField == self.labelDescTextField){
        ok = toBeString.length  && self.labelIdTextField && self.labelUserTextField.text.length  && self.libraryNameTextField.text.length && self.borrowedNumbersTextField.text.length && self.recommendedBooksTextField.text.length && self.appointmentedBooksTextField.text.length;
    }else if (textField == self.libraryNameTextField){
        ok = toBeString.length  && self.labelIdTextField && self.labelUserTextField.text.length && self.labelDescTextField.text.length  && self.borrowedNumbersTextField.text.length && self.recommendedBooksTextField.text.length && self.appointmentedBooksTextField.text.length;
    }else if (textField == self.borrowedNumbersTextField){
        ok = toBeString.length  && self.labelIdTextField && self.labelUserTextField.text.length && self.labelDescTextField.text.length && self.libraryNameTextField.text.length && self.recommendedBooksTextField.text.length && self.appointmentedBooksTextField.text.length;
    }else if (textField == self.recommendedBooksTextField){
        ok = toBeString.length  && self.labelIdTextField && self.labelUserTextField.text.length && self.labelDescTextField.text.length && self.libraryNameTextField.text.length && self.borrowedNumbersTextField.text.length  && self.appointmentedBooksTextField.text.length;
    }else if (textField == self.appointmentedBooksTextField){
        ok = toBeString.length  && self.labelIdTextField && self.labelUserTextField.text.length && self.labelDescTextField.text.length && self.libraryNameTextField.text.length && self.borrowedNumbersTextField.text.length && self.recommendedBooksTextField.text.length ;
    }
    
    else{
        return;
    }
    [self.addBtn activateBtn:ok];
}

//扫描按钮
- (IBAction)scanBtnOnClick:(id)sender {
    ScanVC *vc = [[ScanVC alloc] init];
    __weak typeof(self) weakSelf = self;//防止循环引用
    vc.scanCallback = ^(NSString *content) {
        //扫描到的结果填入书库狂
        weakSelf.labelIdTextField.text = content;
    };
    //隐藏BottomBar
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}


- (IBAction)addBtnOnClick:(id)sender {
    [BMShowHUD show];
    [self.view endEditing:YES];
    //检查用户是否存在
    @weakify(self);
    [[MySQLManager shareInstance] checkUserNameExist:self.labelUserTextField.text callback:^(BOOL exist, NSString *errMsg) {
        @strongify(self);
        if (errMsg) {
            [BMShowHUD showMessage:errMsg];
            return ;
        }
        if (!exist) {
            [BMShowHUD showMessage:@"用户不存在"];
            [self.labelUserTextField becomeFirstResponder];
            return ;
        }

        //检查标签+用户名 是否重复录入
        [[MySQLManager shareInstance] checkLabelExist:self.labelIdTextField.text userName:self.labelUserTextField.text callback:^(BOOL exist, NSString *errMsg) {
            @strongify(self);
            if (errMsg) {
                [BMShowHUD showMessage:errMsg];
            }else {
                if (exist) {
                    [BMShowHUD showMessage:@"该用户已经存在相同的标签!"];
                    [self.labelUserTextField becomeFirstResponder];
                    return ;
                }
            }
 
            
            [[MySQLManager shareInstance] addLabel:self.labelIdTextField.text userName:self.labelUserTextField.text desc:self.labelDescTextField.text libraryName:self.libraryNameTextField.text borrowedNumbers:self.borrowedNumbersTextField.text recommendedBooks:self.recommendedBooksTextField.text appointmentedBooks:self.appointmentedBooksTextField.text  status:self.statusSwitch.on   callback:^(BOOL success, NSString *errMsg) {
                if (success) {
                    [BMShowHUD showSuccess:@"添加成功"];
                    [self.navigationController popViewControllerAnimated:YES];
                    //清空
                }else{
                    if (errMsg) {
                        [BMShowHUD showError:errMsg];
                    } else {
                        [BMShowHUD showError:@"添加失败"];
                    }
                    
                }
            }];
            

        }];
        
    }];


}



@end
