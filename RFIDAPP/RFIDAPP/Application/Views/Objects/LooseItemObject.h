//
//  LooseItemObject.h
//  RFIDAPP
//
//  Created by Apple Developer on 4/5/16.
//  Copyright © 2016 Apple Developer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LooseItemObject : NSObject

@property (nonatomic, copy) NSString *itemNumber;
@property (nonatomic, copy) NSString *itemDescription;
@property (nonatomic, copy) NSString *quantity;

- (id)initWithLooseItem:(NSString *)number andDescription:(NSString *)description andQuantity:(NSString *)quantity;

@end
