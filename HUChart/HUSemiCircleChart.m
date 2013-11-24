//
//  HUSemiCircleChart.m
//  HUChart
//
//  Created by hugo on 11/19/13.
//  Copyright (c) 2013 AugoLab. All rights reserved.
//

#import "HUSemiCircleChart.h"
#import "HUChartEntry.h"

@implementation HUSemiCircleChart
@synthesize data;
@synthesize colors;
@synthesize title;
@synthesize showChartTitle;
@synthesize showPortionTextType;

-(id) init{
    self = [super init];
    self.title = @"";   //default title
    self.showChartTitle = YES;
    self.showPortionTextType = SHOW_PORTION_TEXT;
    return self;
}

-(id) initWithFrame:(CGRect) frame{
    self = [super initWithFrame:frame];
    self.title = @"";   //default title
    self.showChartTitle = YES;
    self.showPortionTextType = SHOW_PORTION_TEXT;
    return self;
}

/**
 *  Gen random colours array if user doesn't set colors property
 */
-(void) genColors{
    int amount = [self.data count];
    UIColor *color;
    float red, green, blue;

    for (int i = 0; i < amount; i++) {
        // Just gen color in range (0,0,0) to (192, 192, 192)
        // to prevent too bright color
        red = arc4random_uniform(192)/255.0;
        green = arc4random_uniform(192)/255.0;
        blue = arc4random_uniform(192)/255.0;

        color = [UIColor colorWithRed:(CGFloat)red
                                green:(CGFloat)green
                                 blue:(CGFloat)blue
                                alpha:1.0];

        // Lazy initialization
        if (!self.colors) {
            self.colors = [[NSMutableArray alloc]init];
        }
        [self.colors addObject:color];
    }
}

/**
 *  Override drawRect method to draw SemiCircleChart
 *
 *  @param rect frame to draw into
 */

-(void) drawRect:(CGRect)rect{
    [super drawRect:rect];

    // Check passed rect is suitable for drawing
    if (![self isDrawable:rect]) {
        return;
    }

    CGContextRef context = UIGraphicsGetCurrentContext();
    [[UIColor whiteColor]set];
    UIRectFill([self bounds]);

    // Draw
    float R = rect.size.width/2;
    float r = 2*R/5;
    CGPoint origin = CGPointMake(rect.origin.x + rect.size.width/2,
                                 rect.origin.y + 5*rect.size.height/6);

    // Draw large circle
    [self drawCircleInContext:context withRadian:r atOrigin:origin];

    // Draw small circle
    [self drawCircleInContext:context withRadian:r atOrigin:origin];

    // Draw portions
    float startAngle = 0.0;
    float endAngle = 0.0;
    NSMutableArray *percentages = [self getPortions];

    if (!self.colors) {
         // If colors property is not set, gen colors
        [self genColors];
    }

    // Draw portions
    for (int i = 0; i < [self.data count]; i++) {
        endAngle = [[percentages objectAtIndex:i] floatValue];

        // Draw each portion
        [self drawPortionInContext:context
                         withColor:[self.colors objectAtIndex:i]
                            origin:origin R:R r:r
                        startAngle:startAngle endAngle:endAngle];

        // Draw text or value of portion or nothing
        switch ([self showPortionTextType]) {
            case SHOW_PORTION_TEXT:
                [self drawPortionValue:[[self.data objectAtIndex:i] name]
                             inContext:context
                                origin:origin R:R r:r
                            startAngle:startAngle endAngle:endAngle];
                break;

            case SHOW_PORTION_VALUE:
                [self drawPortionValue:[(HUChartEntry*)
                                        [self.data objectAtIndex:i] value]
                             inContext:context
                                origin:origin R:R r:r
                            startAngle:startAngle endAngle:endAngle];
                break;
            case DONT_SHOW_PORTION:
                break;
            default:
                break;
        }

        startAngle = endAngle;
    }

    // Draw title if it is set
    if (self.showChartTitle) {
        UIFont *font = [UIFont boldSystemFontOfSize:r/4];
        [self drawText:self.title
              withFont:font withColor:[UIColor blackColor]
             inContext:context inRect:CGRectMake(R-r*sqrt(3)/2,
                                                 origin.y - r/2,
                                                 2*r*sqrt(3)/2,
                                                 3*r/2)];
    }
}


- (void)drawCircleInContext:(CGContextRef)context
                 withRadian:(float)r atOrigin:(CGPoint)origin {
    CGContextSaveGState(context);
    CGContextSetRGBStrokeColor(context, 0.0, 0.0, 0.0, 1.0);
    CGContextSetLineWidth(context, 0.0);
    CGContextAddArc(context, origin.x, origin.y, r, 0, M_PI, YES);
    CGContextClosePath(context);
    CGContextStrokePath(context);
    CGContextRestoreGState(context);
}

- (void)drawPortionInContext:(CGContextRef)context withColor:(UIColor*) color
                      origin:(CGPoint)origin R:(float)R r:(float)r
                  startAngle:(float)startAngle endAngle:(float)endAngle
{
    CGRect rect = CGContextGetClipBoundingBox(context);
    int unitStep = 512;

    if (rect.size.width >= 300) {
        unitStep = 1024;
    }else if(rect.size.width >= 500){
        unitStep = 2048;
    }

    float drawStep = M_PI/unitStep;

    CGContextSaveGState(context);
    CGContextSetStrokeColorWithColor(context, [color CGColor]);
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextSetLineWidth(context, 1.0);

    for (float drawingAngle = startAngle;
                        drawingAngle <= endAngle;
                                drawingAngle += drawStep) {

        CGContextMoveToPoint(context,
                             origin.x - r*cos(drawingAngle),
                             origin.y - r*sin(drawingAngle));
        CGContextAddLineToPoint(context,
                                R *(1- cos(drawingAngle)),
                                origin.y - R*sin(drawingAngle));
        CGContextClosePath(context);
        CGContextStrokePath(context);
    }

    CGContextRestoreGState(context);
}

- (void)drawText:(NSString *) text
        withFont:(UIFont *) font withColor:(UIColor *) color
       inContext:(CGContextRef)context inRect:(CGRect) textRect {

    if (text.length > 0) {
        CGContextSaveGState(context);
        [color setFill];     // Fill current context with color

        if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
            NSMutableParagraphStyle *textStyle = [[NSMutableParagraphStyle
                                                   defaultParagraphStyle] mutableCopy];
            textStyle.lineBreakMode = NSLineBreakByWordWrapping;
            textStyle.alignment = NSTextAlignmentCenter;
            NSDictionary *attributes = @{NSFontAttributeName:font,
                                         NSParagraphStyleAttributeName:textStyle};
            [text drawInRect:textRect withAttributes:attributes];
        }else{
            [text drawInRect:textRect
                    withFont:font
               lineBreakMode:NSLineBreakByWordWrapping
                   alignment:NSTextAlignmentCenter];
        }

        CGContextRestoreGState(context);
    }
}

- (void)drawPortionValue:(id) portionValue  inContext:(CGContextRef)context
                  origin:(CGPoint)origin R:(float)R r:(float)r
              startAngle:(float)startAngle endAngle:(float)endAngle {

    UIFont *font = [UIFont boldSystemFontOfSize:r/4];

    NSString *portionValueText;
    if ([portionValue isKindOfClass:[NSNumber class]]) {
        portionValueText = [portionValue stringValue];
    }else if ([portionValue isKindOfClass:[NSString class]]) {
        portionValueText = (NSString *)portionValue;
    }

    CGSize portionValueTextSize;
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
        portionValueTextSize = [portionValueText sizeWithAttributes:
                                                    @{NSFontAttributeName: font}];
    }else{
        portionValueTextSize = [portionValueText sizeWithFont:font];
    }

    float midAngle = (startAngle + endAngle)/2;

    CGPoint midPoint = CGPointMake((CGFloat) R *(1- 4*cos(midAngle)/5),
                                   (CGFloat)(origin.y - 4*R*sin(midAngle)/5));

    CGRect portionValueTextRect = CGRectMake(
                                             midPoint.x - portionValueTextSize.width/2.0,
                                             midPoint.y - portionValueTextSize.height/2.0,
                                             portionValueTextSize.width,
                                             portionValueTextSize.height
                                             );

    [self drawText:portionValueText
          withFont:font withColor:[UIColor whiteColor]
         inContext:context inRect:portionValueTextRect];

}

- (BOOL)isDrawable:(CGRect)rect {
    if (rect.size.height < rect.size.width/2.0) {
        [[UIColor yellowColor]set];
        UIRectFill([self bounds]);
        UIFont *font = [UIFont boldSystemFontOfSize:MIN(rect.size.width/25.0, 12)];
        [self drawText: @"Cannot draw because rect height is too small."
                        @"\nPlease sure that rect height >= rect width/2"
              withFont:font withColor:[UIColor blackColor]
             inContext:UIGraphicsGetCurrentContext()
                inRect:CGRectMake(rect.origin.x,
                                  rect.origin.y + rect.size.height/3,
                                  rect.size.width,
                                  rect.size.height)];

        return NO;
    }
    return YES;
}

- (NSMutableArray *)getPortions {
    NSMutableArray *percentages = [[NSMutableArray alloc]
                                            initWithCapacity:[self.data count]];

    float total = 0.0;
    for (HUChartEntry *entry in self.data) {
        total += [[entry value] floatValue];
    }

    float temp_total = 0.0;
    for(HUChartEntry *entry in self.data){
        temp_total += [[entry value] floatValue];
        // Convert from 100-based to PI-based
        float percentage = (temp_total/total) * M_PI;
        [percentages addObject:[NSNumber numberWithFloat:percentage]];
    }
    return percentages;
}

@end
