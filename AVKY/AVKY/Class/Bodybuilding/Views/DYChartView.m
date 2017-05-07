//
//  DYChartView.m
//  AVKY
//
//  Created by Yangdongwu on 16/8/4.
//  Copyright © 2016年 杰. All rights reserved.
//

#import "DYChartView.h"
#import <PNChart.h>

@interface DYChartView ()

@end


@implementation DYChartView

- (void)layoutSubviews {
    [super layoutSubviews];
    
     [self setupUI];

}
- (void)setupUI {
    
    //For BarC hart
    PNBarChart * barChart = [[PNBarChart alloc] initWithFrame:CGRectMake(0, 0, screenW, self.bounds.size.height)];
    [barChart setYValues:@[@10,  @63, @15, @29, @83, @19, @54 ]];
    [barChart setXLabels:@[@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",@"周日"]];
    [barChart strokeChart];
    [self addSubview:barChart];
    
}



@end
