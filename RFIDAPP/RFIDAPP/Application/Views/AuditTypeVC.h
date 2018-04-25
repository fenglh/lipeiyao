//
//  AuditTypeVC.h
//  RFIDAPP
//
//  Created by Apple Developer on 4/2/16.
//  Copyright © 2016 Apple Developer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AuditTypeVC : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *hospitalNameLabel;
@property (strong, nonatomic) IBOutlet UIButton *completeAuditButton;

- (IBAction)pushToChoosenAuditVC:(id)sender;
- (IBAction)pushToLooseItemsAuditVC:(id)sender;
- (IBAction)pushToFieldCommissionVC:(id)sender;



@end
