//
//  FeSet.m
//  RFIDAPP
//
//  Created by Apple Developer on 4/4/16.
//  Copyright © 2016 Apple Developer. All rights reserved.
//

#import "FeSet.h"

@implementation FeSet

- (id)initWithFeSet:(NSString *)rfidNumber andFeSet:(NSString *)feSet andItemDescription:(NSString *)itemDescription {
    self = [super init];
    
    if (self) {
        self.rfidNumber = rfidNumber;
        self.feSet = feSet;
        self.itemDescription = itemDescription;
    }
    
    return self;
}

- (id)init {
    return [self initWithFeSet:@"None" andFeSet:@"None" andItemDescription:@"None"];
}


@end
