# HUChart
HUChart is a simple chart library to draw semi-circle chart for some cases which has a LITTLE SPACE to make a full circle chart.

![SemiCircle Chart Example](https://dl.dropboxusercontent.com/s/u5siul88u80lev8/semiCircleChart_example.png)

![SemiCircle Chart Iphone](https://dl.dropboxusercontent.com/s/885h1mzpqh05k1z/semiCircleChartIphoneV6.jpg)

## Features
- Semi-circle chart (half pie chart) as an UIView Component. Easy to custom a suitable semi-circle chart without any struggle.
- Support iOS 6.1+
- Support ARC

## Usage
The code below shows you how to use this SemiCircleChart. You can customize data, color, chart title and the way text is displayed. 

```objective-c
    // Step 1: Create HUSemiCircleChart object with its desire frame
    CGRect frame = CGRectMake(25, 30, 250, 300);
    HUSemiCircleChart *semiCircleChart = [[HUSemiCircleChart alloc]
                                                            initWithFrame:frame];

    // Step 2: Setup data
    NSMutableArray *data = [NSMutableArray arrayWithObjects:
                                    [[HUChartEntry alloc]initWithName:@"Chrome" value:@54.1],
                                    [[HUChartEntry alloc]initWithName:@"Firefox" value:@27.2],
                                    [[HUChartEntry alloc]initWithName:@"IE" value:@11.7],
                                    [[HUChartEntry alloc]initWithName:@"Safari" value:@3.8],
                                    [[HUChartEntry alloc]initWithName:@"Others" value:@3.2],
                                    nil];
    [semiCircleChart setData:data];

    // Step 3: Setup color (Optional)
    // colors maybe not setup, will be generated automatically
    UIColor * color1 = [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:1.0];
    UIColor * color2 = [UIColor colorWithRed:0.0 green:1.0 blue:0.0 alpha:1.0];
    UIColor * color3 = [UIColor colorWithRed:0.0 green:0.5 blue:0.0 alpha:1.0];
    UIColor * color4 = [UIColor colorWithRed:1.0 green:0.0 blue:1.0 alpha:1.0];
    UIColor * color5 = [UIColor colorWithRed:0.0 green:0.0 blue:1.0 alpha:1.0];

    NSMutableArray *colors = [NSMutableArray arrayWithObjects:  color1, color2,
                                                                color3, color4,
                                                                color5, nil];
    [semiCircleChart setColors:colors];
    
    // Step 4: Setup Chart Title
    [semiCircleChart setTitle:@"Browser Shared"];

    // Step 5: Determine whether chart element text is shown or not.
    //          SHOW_PORTION_TEXT to show element's name
    //			SHOW_PORTION_VALUE to show element's value
    //			DONT_SHOW_PORTION	to show element without any text
    semiCircleChart.showPortionTextType = SHOW_PORTION_TEXT;
```

## Installation
<!---
Two ways:
- Use CocoaPods

```ruby
pod 'HUChart'
```
-->

- Drop \& Drag HUChart folder into your project. It's easy!

    Pod: pull request is in waiting list. 

## Contribution
- This work is happened thanks to an idea from [Dao-Thai Nguyen](https://www.facebook.com/profile.php?id=1566842679).

- Don't be hesitate to send a pull request. 

## License
HUChart is released under the MIT License, see [LICENSE](https://github.com/hugo53/HUChart/blob/master/LICENSE).
