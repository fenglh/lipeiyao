//
//  CommonUtils.m
//


#import "CommonUtils.h"
#import <CommonCrypto/CommonDigest.h>

@implementation CommonUtils

+ (instancetype)shared {
    static id instance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
}
//User
- (void)setUserDefaultDic:(NSString *)key withDic:(NSMutableDictionary *)dic {
    NSString *newKey = @"";
    for(NSString *dicKey in [dic allKeys]) {
        newKey = [[key stringByAppendingString:@"_"] stringByAppendingString:dicKey];
        [self setUserDefault:newKey withFormat:[dic objectForKey:dicKey]];
    }
}

- (void)setUserDefault:(NSString *)key withFormat:(id)val {
    if([val isKindOfClass:[NSString class]] && [val isEqualToString:@""])
        val = @"0";
    if ([val isKindOfClass:[NSNull class]])
        val = @"0";
    [[NSUserDefaults standardUserDefaults] setObject:val forKey:key];
}

- (id)getUserDefault:(NSString *)key {
    id val = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    if([val isKindOfClass:[NSString class]] && (val == nil || val == NULL || [val isEqualToString:@"0"])) val = nil;
    return val;
}

- (NSMutableDictionary *)getUserDefaultDicByKey:(NSString *)key {
    NSMutableDictionary *dicAll = (NSMutableDictionary *)[[NSUserDefaults standardUserDefaults] dictionaryRepresentation];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    for(NSString *dicKey in [dicAll allKeys]) {
        if([dicKey rangeOfString:[key stringByAppendingString:@"_"]].location != NSNotFound) {
            [dic setObject:[dicAll objectForKey:dicKey] forKey:[dicKey substringFromIndex:[[key stringByAppendingString:@"_"] length]]];
        }
    }
    return dic;
}

- (void)removeUserDefault:(NSString *)key {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
}


//Check
- (BOOL) isFormEmpty:(NSMutableArray *)array {
    BOOL isEmpty = NO;
    for(NSString *str in array) {
        if([str isEqualToString:@""] || [str isEqualToString:@"0"]) {
            isEmpty = YES;
            break;
        }
    }
    return isEmpty;
}

//Alert
- (void)showAlert:(NSString *)title withMessage:(NSString *)message withViewController:(UIViewController *)vc{
    
    UIAlertController *alert = [UIAlertController
                                alertControllerWithTitle:title
                                message:message
                                preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:nil];
    [alert addAction:ok];
    
    [vc presentViewController:alert animated:YES completion:nil];
}

- (void)showVAlertSimple:(NSString *)title body:(NSString *)body duration:(float)duration {
    _dicAlertContent = [[NSMutableDictionary alloc] init];
    [_dicAlertContent setObject:title forKey:@"title"];
    [_dicAlertContent setObject:body forKey:@"body"];
    [_dicAlertContent setObject:[NSString stringWithFormat:@"%f", duration] forKey:@"duration"];
    
    [self performSelector:@selector(vAlertSimpleThread) onThread:[NSThread mainThread] withObject:nil waitUntilDone:NO];
}
-(void)vAlertSimpleThread{
    appController.vAlert = [[DoAlertView alloc] init];
    appController.vAlert = [[DoAlertView alloc] init];
    appController.vAlert.nAnimationType = 2;  // there are 5 type of animation
    appController.vAlert.dRound = 7.0;
    appController.vAlert.bDestructive = NO;
    
    
    [appController.vAlert doAlert:[_dicAlertContent objectForKey:@"title"] body:[_dicAlertContent objectForKey:@"body"] duration:[[_dicAlertContent objectForKey:@"duration"] floatValue] done:^(DoAlertView *alertView) {}];
}

//ActivityIndicator

- (void)showActivityIndicator:(UIView *)inView {
    //    [[ActivityIndicator currentIndicator] show];
    if (activityIndicator) {
        [self hideActivityIndicator];
    }
    activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [activityIndicator setHidden:NO];
    activityIndicator.center = inView.center;
    activityIndicator.color = appController.appTextColor;
    [activityIndicator startAnimating];
    [activityIndicator.layer setZPosition:999];
    [inView addSubview:activityIndicator];
    //    [inView setUserInteractionEnabled:NO];
}
- (void)showActivityIndicatorColored:(UIView *)inView {
    if (activityIndicator) {
        [self hideActivityIndicator];
    }
    activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [activityIndicator setHidden:NO];
    activityIndicator.center = inView.center;
    activityIndicator.color = appController.appMainColor;
    [activityIndicator startAnimating];
    [activityIndicator.layer setZPosition:999];
    [inView addSubview:activityIndicator];
    //    [inView setUserInteractionEnabled:NO];
}

- (void)showActivityIndicatorThird:(UIView *)inView {
    //    [[ActivityIndicator currentIndicator] show];
    if (activityIndicator) {
        [self hideActivityIndicator];
    }
    activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [activityIndicator setHidden:NO];
    activityIndicator.center = inView.center;
    activityIndicator.color = appController.appThirdColor;
    [activityIndicator startAnimating];
    [activityIndicator.layer setZPosition:999];
    [inView addSubview:activityIndicator];
    //    [inView setUserInteractionEnabled:NO];
}

- (void)hideActivityIndicator {
    //    [[ActivityIndicator currentIndicator] hide];
    //    [activityIndicator.superview setUserInteractionEnabled:YES];
    [activityIndicator setHidden:YES];
    [activityIndicator removeFromSuperview];
    activityIndicator = nil;
}



//Gradient Background
-(void) setGradient:(UIView *)view startColor:(UIColor *)startColor endColor:(UIColor *)endColor {
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = view.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)startColor.CGColor, (id)endColor.CGColor, nil];
    gradient.startPoint = CGPointMake(0.0, 0.5);
    gradient.endPoint = CGPointMake(1.0, 0.5);
    [view.layer insertSublayer:gradient atIndex:0];
}

//    UIButton
- (void) setRoundedRectBorderButton:(UIButton *)button withBorderRadius:(float)radius{
    button.clipsToBounds = YES;
    button.layer.cornerRadius = radius;
}

- (void) setFontSizeButton:(UIButton *)button {
    int fontSize = button.frame.size.height/2.5;
    [button.titleLabel setFont:[UIFont systemFontOfSize:fontSize]];
}

- (void) setAttributedFontSizeButton:(UIButton *)button {
    int fontSize = button.frame.size.height/2;
    NSMutableAttributedString *attributedString = [[button attributedTitleForState:UIControlStateNormal] mutableCopy];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:fontSize] range:NSMakeRange(0, attributedString.length)];
    [button setAttributedTitle:attributedString forState:UIControlStateNormal];
    [button setFrame:CGRectMake(button.frame.origin.x, button.frame.origin.y, [attributedString size].width, [attributedString size].height)];
}

//    UILabel
- (void) setFontSizeLabel:(UILabel *)label {
    int fontSize = label.frame.size.height/2;
    [label setFont:[UIFont systemFontOfSize:fontSize]];
}

- (void) setRoundedRectBorderLabel:(UILabel *)label withBorderRadius:(float)radius {
    label.clipsToBounds = YES;
    label.layer.cornerRadius = radius;
}

//    UITextField
- (void) setFontSizeTextField:(UITextField *)textField {
    int fontSize = textField.frame.size.height/2;
    [textField setFont:[UIFont systemFontOfSize:fontSize]];
}

- (void) setPaddingTextField:(UITextField *)textField {
    CGFloat paddingSize = textField.frame.size.height/3;
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, paddingSize, 0)];
    textField.leftView = paddingView;
    textField.leftViewMode = UITextFieldViewModeAlways;
}

//    UIImage
- (void) setRoundedRectBorderImage:(UIImageView *)imageView withBorderRadius:(float)radius {
    imageView.clipsToBounds = YES;
    imageView.layer.cornerRadius = radius;
}

#pragma mark - Common Httl Request Methods
- (id) httpJsonRequest:(NSString *) urlStr withJSON:(NSMutableDictionary *)params {
//    NSURL *url = [NSURL URLWithString:urlStr];
//    
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
//    NSString *body = [[SBJsonWriter new] stringWithObject:params];
//    NSData *requestData = [body dataUsingEncoding:NSASCIIStringEncoding];
//    
//    [request setHTTPMethod:@"POST"];
//    [request setValue:@"application/json; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
//    [request setHTTPBody: requestData];
//    
//    
//    
//    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
//    NSString *jsonResult = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//    
//    return [[SBJsonParser new] objectWithString:jsonResult];
//    [self getJsonResponse:urlStr withJSON:params success:^(NSString *response) {
//        self.response = response;
//    }failure:^(NSError *error) {
//        self.response = nil;
//    }];


    NSString *response = [self getJsonResponse:urlStr withJSON:params];
   
    return [[SBJsonParser new] objectWithString:response];
}

- (nullable NSString *)getJsonResponse:(NSString *)urlStr withJSON:(NSMutableDictionary *)params {
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    __block NSString *responseStr = nil;
    
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    NSString *body = [[SBJsonWriter new] stringWithObject:params];
    NSData *requestData = [body dataUsingEncoding:NSASCIIStringEncoding];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody: requestData];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (error == nil) {
            NSString *jsonResult = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            
            NSLog(@"%@", jsonResult);
            
            responseStr = jsonResult;
        }
        
        dispatch_semaphore_signal(semaphore);
    }] resume];


    dispatch_semaphore_wait(semaphore, dispatch_time(DISPATCH_TIME_NOW, (int64_t)(60000 * NSEC_PER_MSEC)));
    
    return responseStr;
}
@end
