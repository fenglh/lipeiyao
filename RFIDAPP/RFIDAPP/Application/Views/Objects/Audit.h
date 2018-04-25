//
//  Audit.h
//  RFIDAPP
//
//  Created by Apple Developer on 4/2/16.
//  Copyright © 2016 Apple Developer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Audit : NSObject

@property (nonatomic, copy) NSString *hospitalName;
@property (nonatomic, copy) NSString *startedDate;

- (id)initWithAudit:(NSString *)hospitalName andStartedDate:(NSString *)startedDate;

@end
