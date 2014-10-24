//
//  HUSemiCircleChart.h
//  HUChart
//
//  Created by hugo on 11/19/13.
//  Copyright (c) 2013 AugoLab. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DLog(...)
#endif

typedef enum showTextType
{
    DONT_SHOW_PORTION,
    SHOW_PORTION_VALUE,
    SHOW_PORTION_TEXT
} ShowTextType;

@interface HUSemiCircleChart : UIView

@property (nonatomic) NSMutableArray *data;             // Data for presenting chart, contain HUChartEntry
@property (nonatomic) NSMutableArray *colors;           // Colour for each element, contain UIColor
@property (nonatomic) NSString *title;                  // Chart title
@property (nonatomic) ShowTextType showPortionTextType; // Show text/value/nothing for each portion. Default=SHOW_PORTION_TEXT
@property (assign) BOOL showChartTitle;                 // Show chart title (Default:YES)
@property (nonatomic) NSString *fontName;               // Name of the font you would like to use (Optional)

@end
