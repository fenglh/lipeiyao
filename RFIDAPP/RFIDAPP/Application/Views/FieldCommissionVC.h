//
//  FieldCommissionVC.h
//  RFIDAPP
//
//  Created by Apple Developer on 4/4/16.
//  Copyright © 2016 Apple Developer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FieldCommissionVC : UIViewController<UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *hospitalNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *takePhotoLabel;

@property (strong, nonatomic) IBOutlet UITextField *assetIdText;
@property (strong, nonatomic) IBOutlet UITextField *assetDescriptionText;
@property (strong, nonatomic) IBOutlet UITextField *itemNumberText;

@property (strong, nonatomic) IBOutlet UIImageView *photoImage;


@property (strong, nonatomic) IBOutlet UIButton *scanRFIDTagButton;

- (IBAction)scanRFIDTag:(id)sender;
- (IBAction)takePhoto:(id)sender;
- (IBAction)complete:(id)sender;
- (IBAction)completeUpload:(id)sender;
- (IBAction)clear:(id)sender;
- (IBAction)cancel:(id)sender;

@end
