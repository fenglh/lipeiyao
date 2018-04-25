//
//  ScanView.m
//  RFIDAPP
//
//  Created by sweet on 18/4/23.
//  Copyright © 2018年 Apple Developer. All rights reserved.
//

#import "ScanView.h"

@implementation ScanView

- (void)

// Device
_device = [AVCaptureDevicedefaultDeviceWithMediaType:AVMediaTypeVideo];

// Input
_input = [AVCaptureDeviceInputdeviceInputWithDevice:self.deviceerror:nil];

// Output
_output = [[AVCaptureMetadataOutputalloc]init];
[_outputsetMetadataObjectsDelegate:selfqueue:dispatch_get_main_queue()];

// Session
_session = [[AVCaptureSessionalloc]init];
[_sessionsetSessionPreset:AVCaptureSessionPresetHigh];

@end
