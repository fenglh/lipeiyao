//
//  ManualAuditVC.m
//  RFIDAPP
//
//  Created by Apple Developer on 4/4/18.
//  Copyright © 2018 Apple Developer. All rights reserved.

/*
 步骤如下：
    1.导入 AVFoundation  框架，引入<AVFoundation / AVFoundation.h>
    2.设置一个用于显示扫描的view
    3.实例化AVFaptureSession  , AVCaptureVideoPreviewLayer
*/

#import "ManualAuditVC.h"
#import <AVFoundation/AVFoundation.h>

/*
 屏幕 高 宽 边界
 */
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_BOUNDS  [UIScreen mainScreen].bounds

#define TOP (SCREEN_HEIGHT-220)/2
#define LEFT (SCREEN_WIDTH-220)/2

#define kScanRect CGRectMake(LEFT, TOP, 220, 220)

@interface ManualAuditVC ()<AVCaptureMetadataOutputObjectsDelegate>
{
    UITextField *currentTextField;
    int num;
    BOOL upOrdown;
    NSTimer * timer;
    CAShapeLayer *cropLayer;
}
@property (strong,nonatomic) AVCaptureDevice * device;
@property (strong,nonatomic) AVCaptureDeviceInput * input;
@property (strong,nonatomic) AVCaptureMetadataOutput * output;
@property (strong,nonatomic) AVCaptureSession * session;
@property (strong,nonatomic) AVCaptureVideoPreviewLayer * preview;

@property (nonatomic, strong) UIImageView * line;
@end

@implementation ManualAuditVC


// 在ViewDidload 方法中初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    // 加载视图后执行任何附加设置.
    [self configView];
}

//配置视图
- (void)configView {
    
}
-(BOOL)prefersStatusBarHidden{
    return YES;

}

- (void)setCropRect:(CGRect)cropRect{
    cropLayer = [[CAShapeLayer alloc] init];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, nil, cropRect);
    CGPathAddRect(path, nil, self.view.bounds);
    
    [cropLayer setFillRule:kCAFillRuleEvenOdd];
    [cropLayer setPath:path];
    [cropLayer setFillColor:[UIColor blackColor].CGColor];
    [cropLayer setOpacity:0.6];
    
    
    [cropLayer setNeedsDisplay];
    
    [self.view.layer addSublayer:cropLayer];
//    [self.view bringSubviewToFront:self.localImage];
    
}

- (void)setupCamera
{
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device==nil) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"设备没有摄像头" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    // Device
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // Input
    _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    
    // Output
    _output = [[AVCaptureMetadataOutput alloc]init];
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    //设置扫描区域
    CGFloat top = TOP/SCREEN_HEIGHT;
    CGFloat left = LEFT/SCREEN_WIDTH;
    CGFloat width = 220/SCREEN_WIDTH;
    CGFloat height = 220/SCREEN_HEIGHT;
    ///top 与 left 互换  width 与 height 互换
    [_output setRectOfInterest:CGRectMake(top,left, height, width)];
    
    
    // Session
    _session = [[AVCaptureSession alloc]init];
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    if ([_session canAddInput:self.input])
    {
        [_session addInput:self.input];
    }
    
    if ([_session canAddOutput:self.output])
    {
        [_session addOutput:self.output];
    }
    
    // 条码类型 AVMetadataObjectTypeQRCode
    [_output setMetadataObjectTypes:[NSArray arrayWithObjects:AVMetadataObjectTypeQRCode, nil]];
    
    // Preview
    _preview =[AVCaptureVideoPreviewLayer layerWithSession:_session];
    _preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    _preview.frame =self.view.layer.bounds;
    [self.view.layer insertSublayer:_preview atIndex:0];
    
    // Start
    [_session startRunning];
}

//设置条码类型

#pragma mark AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    NSString *stringValue;
    
    if ([metadataObjects count] >0)
    {
        //停止扫描
        [_session stopRunning];
        [timer setFireDate:[NSDate distantFuture]];
        
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
        //显示扫描结果
        NSLog(@"扫描结果：%@",stringValue);
        
        NSArray *arry = metadataObject.corners;
        for (id temp in arry) {
            NSLog(@"%@",temp);
        }
        
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"扫描结果" message:stringValue preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (_session != nil && timer != nil) {
                [_session startRunning];
                [timer setFireDate:[NSDate date]];
            }
            
        }]];
        [self presentViewController:alert animated:YES completion:nil];
        
    } else {
        NSLog(@"无扫描信息");
        return;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // 处理可重新创建的任何资源.
}

- (void)initUI {
    


    self.rfidTagIdText.delegate = self;
    
    [commonUtils setFontSizeLabel:self.titleLabel];

    [commonUtils setFontSizeTextField:self.rfidTagIdText];
    [commonUtils setRoundedRectBorderImage:self.photoImage
        withBorderRadius:self.photoImage.frame.size.height/6];
    
    
    //    隐藏键盘
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
}




//    Pop ViewController
- (void)popViewController {
    [UIView transitionWithView:self.navigationController.view duration:1 options:UIViewAnimationOptionTransitionFlipFromLeft animations:nil completion:nil];
    [self.navigationController popViewControllerAnimated:NO];
}



@end
