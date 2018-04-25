//
//  BlindCountVC.m
//  RFIDAPP
//
//  Created by Apple Developer on 4/2/16.
//  Copyright © 2016 Apple Developer. All rights reserved.
//

#import "BlindCountVC.h"

@interface BlindCountVC ()

@end

@implementation BlindCountVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
}

- (void)initUI {
    [commonUtils setFontSizeLabel:self.titleLabel];
    [commonUtils setFontSizeButton:self.acceptButton];
    [commonUtils setRoundedRectBorderButton:self.acceptButton withBorderRadius:self.acceptButton.frame.size.height/2];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pushToSelectHospitalVC:(id)sender {
    SelectHospitalVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"SelectHospitalVC"];
    [self.navigationController pushViewController:vc animated:NO];
    [UIView transitionWithView:self.navigationController.view duration:1 options:UIViewAnimationOptionTransitionFlipFromRight animations:nil completion:nil];
}
@end
