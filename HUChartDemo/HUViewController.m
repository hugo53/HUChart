//
//  HUViewController.m
//  HUChart
//
//  Created by hugo on 11/19/13.
//  Copyright (c) 2013 AugoLab. All rights reserved.
//

#import "HUViewController.h"
#import "HUSemiCircleChart.h"
#import "HUChartEntry.h"

@interface HUViewController ()

@end

@implementation HUViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    CGRect frame = CGRectMake(25, 30, 250, 300);
    HUSemiCircleChart *semiCircleChart = [[HUSemiCircleChart alloc]
                                                            initWithFrame:frame];

    // Setup data
    // Data from http://www.w3schools.com/browsers/browsers_stats.asp
    // Browser Statistics, October, 2013
    NSMutableArray *data = [NSMutableArray arrayWithObjects:
                                    [[HUChartEntry alloc]initWithName:@"Chrome" value:@54.1],
                                    [[HUChartEntry alloc]initWithName:@"Firefox" value:@27.2],
                                    [[HUChartEntry alloc]initWithName:@"IE" value:@11.7],
                                    [[HUChartEntry alloc]initWithName:@"Safari" value:@3.8],
                                    [[HUChartEntry alloc]initWithName:@"Others" value:@3.2],
                                    nil];

    //colors maybe not setup, will be generated automatically
    UIColor * color1 = [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:1.0];
    UIColor * color2 = [UIColor colorWithRed:0.0 green:1.0 blue:0.0 alpha:1.0];
    UIColor * color3 = [UIColor colorWithRed:0.0 green:0.5 blue:0.0 alpha:1.0];
    UIColor * color4 = [UIColor colorWithRed:1.0 green:0.0 blue:1.0 alpha:1.0];
    UIColor * color5 = [UIColor colorWithRed:0.0 green:0.0 blue:1.0 alpha:1.0];

    NSMutableArray *colors = [NSMutableArray arrayWithObjects:  color1, color2,
                                                                color3, color4,
                                                                color5, nil];
    [semiCircleChart setColors:colors];
    [semiCircleChart setData:data];
    [semiCircleChart setTitle:@"Browser Shared"];
    semiCircleChart.showPortionTextType = SHOW_PORTION_TEXT;
//    semiCircleChart.showPortionTextType = SHOW_PORTION_VALUE;
//    semiCircleChart.showPortionTextType = DONT_SHOW_PORTION;

    [self.view addSubview:semiCircleChart];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
