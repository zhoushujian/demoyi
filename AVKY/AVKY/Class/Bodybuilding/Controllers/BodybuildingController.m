//
//  BodybuildingController.m
//  AVKY
//
//  Created by 杰 on 16/8/3.
//  Copyright © 2016年 杰. All rights reserved.
//

#import "BodybuildingController.h"
#import "DYStepView.h"
#import "DYFunctionButton.h"
#import "DYChartView.h"
#import "DYTodayTargetSetController.h"
#import "DYTrainGuideController.h"
#import "DYHaveARestController.h"
#import "DYAflameTrainController.h"

#import "KYNavigationController.h"

#define margin 5
#define buttonHeight 30

@interface BodybuildingController () <UITextFieldDelegate>
/**
 *  步数信息的view
 */
@property (nonatomic, strong) DYStepView *stepView;
/**
 *  健身训练指引按钮
 */
@property (nonatomic, strong) DYFunctionButton *trainGuide;
/**
 *  休息一下按钮
 */
@property (nonatomic, strong) DYFunctionButton *haveARest;
/**
 *  燃脂训练
 */
@property (nonatomic, strong) DYFunctionButton *aflameTrain;
/**
 *  柱形图
 */
@property (nonatomic, strong) DYChartView *chartView;
/**
 *  每日目标设置控制器
 */
@property (nonatomic, weak) DYTodayTargetSetController *todayTargetSetController;

@end

@implementation BodybuildingController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"pic_hd_1"]];



}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self setupUI];
    
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.chartView = nil;

}

- (void)setupUI {

    //添加子控件
    
    self.chartView = [[DYChartView alloc] init];

    [self.view addSubview:self.stepView];
    [self.view addSubview:self.trainGuide];
    [self.view addSubview:self.haveARest];
    [self.view addSubview:self.aflameTrain];
    [self.view addSubview:self.chartView];
    
    //设置子控件
    [self.trainGuide setTitle:@"训练指导" forState:UIControlStateNormal];
    [self.haveARest setTitle:@"休息一下" forState:UIControlStateNormal];
    [self.aflameTrain setTitle:@"燃脂训练" forState:UIControlStateNormal];
    
    [self.trainGuide addTarget:self action:@selector(trainGuideClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.haveARest addTarget:self action:@selector(haveARestClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.aflameTrain addTarget:self action:@selector(aflameTrainClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //点击DYStepView的今日目标的时候调用此block
    __weak typeof(self) weakSelf = self;
    self.stepView.todayTargetClickBlock = ^{
        DYTodayTargetSetController *todayTargetSetController = [[DYTodayTargetSetController alloc] init];
        //点击DYTodayTargetSetController的确定的时候调用此block
        todayTargetSetController.todayTargetBlock = ^(NSString *stepCount) {
            weakSelf.stepView.targetCount = stepCount.integerValue;
            [weakSelf.navigationController popViewControllerAnimated:YES];
        };
        //push控制器
        [weakSelf.navigationController pushViewController:todayTargetSetController animated:YES];
    };
    
    //自动布局
    [self.stepView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_topLayoutGuide);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.mas_equalTo(220);
    }];
    
    [self.trainGuide mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.stepView.mas_bottom).offset(margin);
        make.left.equalTo(self.view).offset(margin);
        make.height.mas_equalTo(buttonHeight);
    }];
    
    [self.haveARest mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.stepView.mas_bottom).offset(margin);
        make.left.equalTo(self.trainGuide.mas_right).offset(margin);
        make.width.equalTo(self.trainGuide);
        make.height.mas_equalTo(buttonHeight);
    }];
    
    [self.aflameTrain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.stepView.mas_bottom).offset(margin);
        make.left.equalTo(self.haveARest.mas_right).offset(margin);
        make.right.equalTo(self.view).offset(-margin);
        make.width.equalTo(self.trainGuide);
        make.height.mas_equalTo(buttonHeight);
    }];
    
    [self.chartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.trainGuide.mas_bottom).offset(margin);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.mas_bottomLayoutGuide);
    }];
    
}

#pragma mark - 按钮的点击方法

- (void)trainGuideClick:(UIButton *)sender {

    DYTrainGuideController *trainGuideController = [[DYTrainGuideController alloc] init];
    [self.navigationController pushViewController:trainGuideController animated:YES];
}

- (void)haveARestClick:(UIButton *)sender {
    
        DYHaveARestController *haveARestController = [[DYHaveARestController alloc] init];
    
    KYNavigationController *nav = [[KYNavigationController alloc] initWithRootViewController:haveARestController];

//    [self.navigationController pushViewController:haveARestController animated:YES];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)aflameTrainClick:(UIButton *)sender {

    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"News" bundle:nil];
    DYAflameTrainController *aflameTrainController = [sb instantiateInitialViewController];
    [self.navigationController pushViewController:aflameTrainController animated:YES];
}

#pragma mark - 内存警告和销毁
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark - 懒加载
- (DYStepView *)stepView {
    if (_stepView == nil) {
        _stepView = [[DYStepView alloc] init];
    }
    return _stepView;
}

- (DYFunctionButton *)trainGuide {
    if (_trainGuide == nil) {
        _trainGuide = [[DYFunctionButton alloc] init];
    }
    return _trainGuide;
}

- (DYFunctionButton *)haveARest {
    if (_haveARest == nil) {
        _haveARest = [[DYFunctionButton alloc] init];
    }
    return _haveARest;
}

- (DYFunctionButton *)aflameTrain {
    if (_aflameTrain == nil) {
        _aflameTrain = [[DYFunctionButton alloc] init];
    }
    return _aflameTrain;
}

@end
