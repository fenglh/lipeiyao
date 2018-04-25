//
//  AppController.m


#import "AppController.h"

static AppController *_appController;

@implementation AppController

+ (AppController *)sharedInstance {
    static dispatch_once_t predicate;
    if (_appController == nil) {
        dispatch_once(&predicate, ^{
            _appController = [[AppController alloc] init];
        });
    }
    return _appController;
}

- (id)init {
    self = [super init];
    if (self) {
//        _appMainColor = RGBA(16, 58, 96, 1.0f);
//        _appTextColor = RGBA(41, 43, 48, 1.0f);
//        _appThirdColor = RGBA(61, 155, 196, 1.0f);
//        
//        _vAlert = [[DoAlertView alloc] init];
//        _vAlert.nAnimationType = 2;  // there are 5 type of animation
//        _vAlert.dRound = 7.0;
//        _vAlert.bDestructive = NO;  // for destructive mode
//        
//        _currentUser = [[NSMutableDictionary alloc] init];
    }
    return self;
}


#pragma mark - Set Base Data
- (void)initBaseData {
    
}

@end
