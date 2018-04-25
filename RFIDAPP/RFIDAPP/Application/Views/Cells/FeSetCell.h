//
//  FeSetCell.h
//  RFIDAPP
//
//  Created by Apple Developer on 4/4/16.
//  Copyright © 2016 Apple Developer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeSetCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *rfidNumberLabel;
@property (strong, nonatomic) IBOutlet UILabel *feSetLabel;
@property (strong, nonatomic) IBOutlet UILabel *descriptionLabel;
@end
