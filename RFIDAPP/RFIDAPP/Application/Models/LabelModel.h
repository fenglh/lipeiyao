//
//  LabelModel.h
//  RFIDAPP
//
//  Created by fenglh on 2018/4/25.
//  Copyright © 2018年 Apple Developer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LabelModel : NSObject
@property (nonatomic, strong) NSString *labelUser; ///< 标签所属用户
@property (nonatomic, strong) NSString *labelId; ///< 标签ID
@property (nonatomic, strong) NSString *LabelDesc; ///< 标签描述
@end
