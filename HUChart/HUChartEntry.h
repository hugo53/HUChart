//
//  HUChartEntry.h
//  HUChart
//
//  Created by hugo on 11/24/13.
//  Copyright (c) 2013 AugoLab. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HUChartEntry : NSObject
@property NSString *name;
@property NSNumber *value;

-(id)initWithName:(NSString*) _name value:(NSNumber *) _value;
@end
