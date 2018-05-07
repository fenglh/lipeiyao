//
//  LabelTableViewCell.h
//  RFIDAPP
//
//  Created by lipeiyao on 2018/4/25.
//  Copyright © 2018年 Apple Developer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LabelTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labelId;
@property (weak, nonatomic) IBOutlet UILabel *labelUser;
@property (weak, nonatomic) IBOutlet UILabel *labelDesc;

@property (weak, nonatomic) IBOutlet UILabel *libraryNameLabel; ///< 图书馆名称
@property (weak, nonatomic) IBOutlet UILabel *borrowedNumbersLabel; ///< 已借阅数量
@property (weak, nonatomic) IBOutlet UILabel *recommendedBooksLabel; ///< 推荐的书籍
@property (weak, nonatomic) IBOutlet UILabel *appointmentedBooksLabel; ///< 预约的书籍
@property (weak, nonatomic) IBOutlet UILabel *statusLabel; ///< 标签的状态,0关，1开

@end
