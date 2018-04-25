//
//  BlindCountVC.h
//  RFIDAPP
//
//  Created by Apple Developer on 4/2/16.
//  Copyright © 2016 Apple Developer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BlindCountVC : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UIButton *acceptButton;

- (IBAction)pushToSelectHospitalVC:(id)sender;

@end
