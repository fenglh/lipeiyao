//
//  AuditTypeVC.m
//  RFIDAPP
//
//  Created by Apple Developer on 4/2/16.
//  Copyright © 2016 Apple Developer. All rights reserved.
//

#import "AuditTypeVC.h"

@interface AuditTypeVC ()

@end

@implementation AuditTypeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // 加载视图后执行任何附加设置.
    [self initUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // 处理可重新创建的任何资源.
}

- (void)initUI {
    [commonUtils setFontSizeLabel:self.titleLabel];
    [commonUtils setFontSizeLabel:self.hospitalNameLabel];
    [commonUtils setFontSizeButton:self.completeAuditButton];
    [commonUtils setRoundedRectBorderButton:self.completeAuditButton withBorderRadius:self.completeAuditButton.frame.size.height/2];
}



- (IBAction)pushToLooseItemsAuditVC:(id)sender {
    LooseItemsAuditVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"LooseItemsAuditVC"];
    [UIView transitionWithView:self.navigationController.view duration:1 options:UIViewAnimationOptionTransitionFlipFromRight animations:nil completion:nil];
    [self.navigationController pushViewController:vc animated:NO];
}

- (IBAction)pushToFieldCommissionVC:(id)sender {
    FieldCommissionVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"FieldCommissionVC"];
    [UIView transitionWithView:self.navigationController.view duration:1 options:UIViewAnimationOptionTransitionFlipFromRight animations:nil completion:nil];
    [self.navigationController pushViewController:vc animated:NO];
}


@end
