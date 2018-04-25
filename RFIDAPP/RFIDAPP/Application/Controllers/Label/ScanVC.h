//
//  ScanVC.h
//  RFIDAPP
//
//  Created by fenglh on 2018/4/25.
//  Copyright © 2018年 Apple Developer. All rights reserved.
//

#import "BMScanDefaultCotroller.h"

typedef void(^ScanCallback)(NSString *content);

@interface ScanVC : BMScanDefaultCotroller
@property (nonatomic, strong) ScanCallback scanCallback; ///< 扫描回调
@end
