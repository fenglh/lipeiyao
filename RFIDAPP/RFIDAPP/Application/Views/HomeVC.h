//
//  HomeVC.h
//  RFIDAPP
//
//  Created by Apple Developer on 4/2/16.
//  Copyright © 2016 Apple Developer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeVC : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

@property (strong, nonatomic) IBOutlet UITableView *openAuditTable;

@property (strong, nonatomic) IBOutlet UIButton *createNewAuditButton;

- (IBAction)pushBlindVC:(id)sender;

@end
