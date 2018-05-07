//
//  LabelModel.h
//  RFIDAPP
//
//  Created by lipeiyao on 2018/4/25.
//  Copyright © 2018年 Apple Developer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LabelModel : NSObject
@property (nonatomic, strong) NSString *labelUser; ///< 标签所属用户
@property (nonatomic, strong) NSString *labelId; ///< 标签ID
@property (nonatomic, strong) NSString *LabelDesc; ///< 标签描述

@property (nonatomic, strong) NSString *libraryName; ///< 图书馆名称
@property (nonatomic, assign) NSInteger borrowedNumbers; ///< 已借阅数量
@property (nonatomic, strong) NSString *recommendedBooks; ///< 推荐的书籍
@property (nonatomic, strong) NSString *appointmentedBooks; ///< 预约的书籍
@property (nonatomic, assign) NSInteger status; ///< 标签的状态,0关，1开
@end
