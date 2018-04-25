//
//  ScanView.h
//  RFIDAPP
//
//  Created by sweet on 18/4/23.
//  Copyright © 2018年 Apple Developer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScanView : NSObject

@property (strong,nonatomic)AVCaptureDevice * device;
@property (strong,nonatomic)AVCaptureDeviceInput * input;
@property (strong,nonatomic)AVCaptureMetadataOutput * output;
@property (strong,nonatomic)AVCaptureSession * session;
@property (strong,nonatomic)AVCaptureVideoPreviewLayer * preview;

@end
