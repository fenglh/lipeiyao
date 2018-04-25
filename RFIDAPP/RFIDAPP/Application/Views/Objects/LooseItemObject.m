//
//  LooseItemObject.m
//  RFIDAPP
//
//  Created by Apple Developer on 4/5/16.
//  Copyright © 2016 Apple Developer. All rights reserved.
//

#import "LooseItemObject.h"

@implementation LooseItemObject

- (id)initWithLooseItem:(NSString *)number andDescription:(NSString *)description andQuantity:(NSString *)quantity {
    self = [super init];
    
    if (self) {
        self.itemNumber = number;
        self.itemDescription = description;
        self.quantity = quantity;
    }
    
    return self;
}

- (id)init {
    return [self initWithLooseItem:@"None" andDescription:@"None" andQuantity:@"None"];
}

@end
