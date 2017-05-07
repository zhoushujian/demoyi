//
//  DYTrainGuideController.m
//  AVKY
//
//  Created by Yangdongwu on 16/8/4.
//  Copyright © 2016年 杰. All rights reserved.
//

#import "DYTrainGuideController.h"
#import "PNChart.h"

@interface DYTrainGuideController () <UITextFieldDelegate>
@property (nonatomic, strong) PNLineChart * lineChart;
@property (nonatomic, strong) NSMutableArray *txArr;
@property (nonatomic, strong) NSMutableArray *arr;
@end

@implementation DYTrainGuideController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavigationBar];
    [self setChart];
    
    // 显示tabbar遮盖的内容
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = YES;
    

    
}

-(void)setChart{
    
    UIView * topview = [[UIView alloc]init];
    //For Line Chart
    self.lineChart = [[PNLineChart alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200.0)];
    
    [self.lineChart setXLabels:@[@"周1",@"周2",@"周3",@"周4",@"周5",@"周六",@"周天"]];
    
    NSMutableArray * data01Array = [NSMutableArray array];
    self.txArr =[NSMutableArray array];

    for (int i = 0; i < 7; ++i) {
        CGRect rect = CGRectMake(60, 200.0, 40    , 30);
        UITextField * tx1 = [[UITextField alloc]init];
        tx1.delegate = self;
        tx1.tag = i;
        tx1.backgroundColor = globalColor;
        tx1.frame = CGRectOffset(rect, (screenW - 60) /7* i, 0);
        [topview addSubview:tx1];
        [self.txArr addObject:tx1];
        tx1.text = [NSString stringWithFormat:@"%@",self.arr[i]];
        [data01Array addObject:tx1.text];
    }
    
    PNLineChartData *data01 = [PNLineChartData new];
    data01.color = PNFreshGreen;
    data01.itemCount = self.lineChart.xLabels.count;
    data01.getData = ^(NSUInteger index) {
        CGFloat yValue = [data01Array[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    // Line Chart No.2
    
    NSArray * data02Array = @[@20.1, @180.1, @26.4, @202.2, @126.2, @282.2, @136.2];
    PNLineChartData *data02 = [PNLineChartData new];
    data02.color = PNTwitterColor;
    data02.itemCount = self.lineChart.xLabels.count;
    data02.getData = ^(NSUInteger index) {
        CGFloat yValue = [data02Array[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    //    lineChart.showSmoothLines = YES;
    self.lineChart.chartData = @[data01, data02];
    [self.lineChart strokeChart];
    
    [topview addSubview:self.lineChart];
    UIView * bottomview = [[UIView alloc]init];
    [self.view addSubview:topview];
    [self.view addSubview:bottomview];
    
    [topview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).mas_offset(screenH*0.1);
        make.left.equalTo(self.view).mas_offset(10);
        make.right.equalTo(self.view).mas_offset(-10);
        make.height.mas_equalTo(screenH*0.5);
    }];
    
    [bottomview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topview.mas_bottom);
        make.left.equalTo(self.view).mas_offset(10);
        make.right.equalTo(self.view).mas_offset(-10);
        make.height.mas_equalTo(screenH*0.5);
    }];

}


- (void)setNavigationBar {
    self.navigationItem.title = @"本周运动计划";
}

#pragma mark - 内存警告
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.arr replaceObjectAtIndex:textField.tag withObject:textField.text];
    [self textFieldDidEndEditing:textField];
    [self setChart];
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField{

    [self.arr replaceObjectAtIndex:textField.tag withObject:textField.text];
    [self setChart];
}

-(NSMutableArray *)arr{
    if (_arr == nil) {
        _arr = [NSMutableArray arrayWithArray:@[@60.1, @160.1, @126.4, @262.2, @186.2, @212.2, @286.2]];
    }
    return _arr;
}
@end
