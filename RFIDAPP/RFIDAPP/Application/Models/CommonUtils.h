//  CommonUtils.h
//  Created by BE

#import <Foundation/Foundation.h>

@interface CommonUtils : NSObject<NSURLSessionTaskDelegate, NSURLSessionDataDelegate>{
    UIActivityIndicatorView *activityIndicator;
}

@property (nonatomic, strong) NSMutableDictionary *dicAlertContent;

@property (nonatomic, strong) NSString *urlStr;
@property (nonatomic, strong) NSString *response;

+ (instancetype)shared;
//User
- (void)setUserDefaultDic:(NSString *)key withDic:(NSMutableDictionary *)dic;
- (void)setUserDefault:(NSString *)key withFormat:(id)val;
- (id)getUserDefault:(NSString *)key;
- (NSMutableDictionary *)getUserDefaultDicByKey:(NSString *)key;
- (void)removeUserDefault:(NSString *)key;

//Check
- (BOOL) isFormEmpty:(NSMutableArray *)array;

//ActivityIndicator
- (void)showActivityIndicator:(UIView *)inView;
- (void)showActivityIndicatorColored:(UIView *)inView;
- (void)showActivityIndicatorThird:(UIView *)inView;
- (void)hideActivityIndicator;

//Alert
- (void)showAlert:(NSString *)title withMessage:(NSString *)message withViewController:(UIViewController *)vc;
- (void)showVAlertSimple:(NSString *)title body:(NSString *)body duration:(float)duration;
-(void)vAlertSimpleThread;

//Gradient Background
- (void) setGradient:(UIView *)view startColor:(UIColor *) startColor endColor:(UIColor *) endColor;

//    Button
- (void) setRoundedRectBorderButton:(UIButton *)button withBorderRadius:(float)radius;
- (void) setFontSizeButton:(UIButton *) button;
- (void) setAttributedFontSizeButton:(UIButton *) button;

//    UILabel
- (void) setFontSizeLabel:(UILabel *) label;
- (void) setRoundedRectBorderLabel:(UILabel *)label withBorderRadius:(float)radius;

//    UITextField
- (void) setFontSizeTextField:(UITextField *) textField;
- (void) setPaddingTextField:(UITextField *) textField;

//    UIImage
- (void) setRoundedRectBorderImage:(UIImageView *)imageView withBorderRadius:(float)radius;

//Httl Request Methods
- (id) httpJsonRequest:(NSString *) urlStr withJSON:(NSMutableDictionary *)params;


@end