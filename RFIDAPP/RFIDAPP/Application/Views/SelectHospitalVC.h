//
//  SelectHospitalVC.h
//  RFIDAPP
//
//  Created by Apple Developer on 4/2/16.
//  Copyright © 2016 Apple Developer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectHospitalVC : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UIView *mainContainerView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

@property (strong, nonatomic) IBOutlet UITableView *hospitalTable;
@end
