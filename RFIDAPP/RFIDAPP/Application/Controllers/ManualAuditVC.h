//
//  ManualAuditVC.h
//  RFIDAPP
//
//  Created by Apple Developer on 4/4/18.
//  Copyright © 2018 Apple Developer. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <AVFoundation/AVFoundation.h>



@interface ManualAuditVC :UIViewController<UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>


@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UITextField *rfidTagIdText;

@property (strong, nonatomic) IBOutlet UIImageView *photoImage;
@property (strong, nonatomic) IBOutlet UIButton *scan;





- (IBAction)audit:(id)sender;

- (IBAction)scan:(id)sender;

- (IBAction)Responder:(id)sender;


@end
