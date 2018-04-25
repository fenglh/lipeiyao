//
//  Audit.m
//  RFIDAPP
//
//  Created by Apple Developer on 4/2/16.
//  Copyright © 2016 Apple Developer. All rights reserved.
//

#import "Audit.h"

@implementation Audit

- (id)initWithAudit:(NSString *)hospitalName andStartedDate:(NSString *)startedDate {
    self = [super init];
    if (self) {
        self.hospitalName = hospitalName;
        self.startedDate = startedDate;
    }
    
    return self;
}

- (id)init {
    return [self initWithAudit:@"None" andStartedDate:@"None"];
}

@end
