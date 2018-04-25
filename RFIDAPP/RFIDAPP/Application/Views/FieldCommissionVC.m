//
//  FieldCommissionVC.m
//  RFIDAPP
//
//  Created by Apple Developer on 4/4/16.
//  Copyright © 2016 Apple Developer. All rights reserved.
//

#import "FieldCommissionVC.h"

@interface FieldCommissionVC () {
    UITextField *currentTextField;
}

@end

@implementation FieldCommissionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // 加载视图后执行任何附加设置.
    [self initUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    //处理可重新创建的任何资源.
}

- (void)initUI {
    self.assetIdText.delegate = self;
    self.assetDescriptionText.delegate = self;
    self.itemNumberText.delegate = self;
    
    [commonUtils setFontSizeLabel:self.titleLabel];
    [commonUtils setFontSizeLabel:self.hospitalNameLabel];
    [commonUtils setFontSizeLabel:self.takePhotoLabel];
    
    [commonUtils setFontSizeTextField:self.assetIdText];
    [commonUtils setFontSizeTextField:self.assetDescriptionText];
    [commonUtils setFontSizeTextField:self.itemNumberText];
    
    [commonUtils setFontSizeButton:self.scanRFIDTagButton];
    
    [commonUtils setRoundedRectBorderImage:self.photoImage withBorderRadius:self.photoImage.frame.size.height/6];
    
//    Hide Keybord
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
}

- (IBAction)scanRFIDTag:(id)sender {
}

- (IBAction)takePhoto:(id)sender {
    //    Set Error Message for Camera
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [commonUtils showAlert:@"Warring" withMessage:@"Device has no camera" withViewController:self];
//        UIAlertController *alert = [UIAlertController
//                                    alertControllerWithTitle:@"Warring"
//                                    message:@"Device has no camera"
//                                    preferredStyle:UIAlertControllerStyleAlert];
//        
//        [self presentViewController:alert animated:YES completion:nil];
        
        return;
    }
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = NO;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

- (IBAction)complete:(id)sender {
    [self popViewController];
}

- (IBAction)completeUpload:(id)sender {
    [self popViewController];
}

- (IBAction)clear:(id)sender {
    [self.assetIdText setText:nil];
    [self.assetDescriptionText setText:nil];
    [self.itemNumberText setText:nil];
    
    [self.photoImage setImage:nil];
}

- (IBAction)cancel:(id)sender {
    [self popViewController];
}

- (void)popViewController {
    [UIView transitionWithView:self.navigationController.view duration:1 options:UIViewAnimationOptionTransitionFlipFromLeft animations:nil completion:nil];
    [self.navigationController popViewControllerAnimated:NO];
}

#pragma mark - TextField Delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    currentTextField = textField;
}

//    Hide Keyboard
- (void) dismissKeyboard {
    [currentTextField resignFirstResponder];
}

#pragma mark - ImagePicker Delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    //    UIImage *chosenImage = info[UIImagePickerControllerEditedImage]; //allowsEditing = YES
    UIImage *chosenImage = [info objectForKey:UIImagePickerControllerOriginalImage]; //allowsEditing = NO
    
    self.photoImage.image = chosenImage;
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker  {
    [picker dismissViewControllerAnimated:YES completion:NULL];
}
@end
