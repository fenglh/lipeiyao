//
//  ScanVC.m
//  RFIDAPP
//
//  Created by lipeiyao on 2018/4/25.
//  Copyright © 2018年 Apple Developer. All rights reserved.
//

#import "ScanVC.h"

@interface ScanVC ()

@end

@implementation ScanVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"扫描标签";
}



#pragma mark - 扫描回调


/**
 扫描到内容时回调
 */
- (void)scanCaptureWithValueString:(NSString *)valueString NS_REQUIRES_SUPER {
    [super scanCaptureWithValueString:valueString];
    self.scanCallback?self.scanCallback(valueString) : nil;
    dispatch_async(dispatch_get_main_queue(), ^{
        [BMShowHUD showMessage:@"扫描成功"];
        [self.navigationController popViewControllerAnimated:YES];
    });
}

- (CGFloat)areaXHeight {
    return 300;
}


- (CGFloat)areaWidth {
    return 300;
}

@end
