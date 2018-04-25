//  AppController.h
//  Created by BE

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AppController : NSObject

@property (nonatomic, strong) NSMutableDictionary *currentUser;

+ (AppController *)sharedInstance;

@property (nonatomic, strong) DoAlertView *vAlert;

@property (nonatomic, strong) UIColor *appMainColor, *appTextColor, *appThirdColor;
@end