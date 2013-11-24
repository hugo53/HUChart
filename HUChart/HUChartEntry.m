//
//  HUChartEntry.m
//  HUChart
//
//  Created by hugo on 11/24/13.
//  Copyright (c) 2013 AugoLab. All rights reserved.
//

#import "HUChartEntry.h"

@implementation HUChartEntry
@synthesize name;
@synthesize value;

- (id)init
{
    self = [super init];
    if (self) {
        self.name = @"";
        value = [NSNumber numberWithFloat:-1.0];
    }
    return self;
}

-(id)initWithName:(NSString*) _name value:(NSNumber *) _value{
    self = [super init];
    if (self) {
        self.name = _name;
        self.value = _value;
    }
    return self;
}

@end
