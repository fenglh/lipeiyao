//
//  FeSet.h
//  RFIDAPP
//
//  Created by Apple Developer on 4/4/16.
//  Copyright © 2016 Apple Developer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FeSet : NSObject

@property (nonatomic, copy) NSString *rfidNumber;
@property (nonatomic, copy) NSString *feSet;
@property (nonatomic, copy) NSString *itemDescription;

- (id)initWithFeSet:(NSString *)rfidNumber andFeSet:(NSString *)feSet andItemDescription:(NSString *)itemDescription;

@end
