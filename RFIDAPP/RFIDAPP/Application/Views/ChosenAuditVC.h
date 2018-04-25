//
//  ChosenAuditVC.h
//  RFIDAPP
//
//  Created by Apple Developer on 4/3/16.
//  Copyright © 2016 Apple Developer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChosenAuditVC : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UIButton *addNoteButton;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *hospitalNameLabel;


@property (strong, nonatomic) IBOutlet UITableView *feSetTable;

- (IBAction)pushToManualAuditVC:(id)sender;
- (IBAction)completeUpload:(id)sender;
- (IBAction)complete:(id)sender;
- (IBAction)cancel:(id)sender;
@end
