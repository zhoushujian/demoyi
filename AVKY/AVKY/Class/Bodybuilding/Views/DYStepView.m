//
//  DYStepView.m
//  AVKY
//
//  Created by Yangdongwu on 16/8/4.
//  Copyright © 2016年 杰. All rights reserved.
//

#import "DYStepView.h"
#import "DYStepTitleLabel.h"
#import "DYStepCountLabel.h"
#import <CoreMotion/CoreMotion.h>
#import "HMWeakTimerTargetObj.h"

#define margin 5
#define titleHeight 30
#define countHeight 40

@interface DYStepView ()

/**
 *  大卡
 */
@property (nonatomic, strong) DYStepTitleLabel *daKa;
/**
 *  活跃时间
 */
@property (nonatomic, strong) DYStepTitleLabel *activeTime;
/**
 *  公里
 */
@property (nonatomic, strong) DYStepTitleLabel *km;

/**
 *  大卡数值
 */
@property (nonatomic, strong) DYStepCountLabel *daKaCount;
/**
 *  活跃时间数值
 */
@property (nonatomic, strong) DYStepCountLabel *activeTimeCount;
/**
 *  公里数值
 */
@property (nonatomic, strong) DYStepCountLabel *kmCount;
/**
 *  今日步数
 */
@property (nonatomic, strong) DYStepTitleLabel *todayStep;
/**
 *  今日步数数值
 */
@property (nonatomic, strong) DYStepCountLabel *todayStepCount;
/**
 *  目标
 */
@property (nonatomic, strong) UIButton *todayTarget;
/**
 *  等级
 */
@property (nonatomic, strong) DYStepTitleLabel *level;
/**
 *  计步器
 */
@property (strong, nonatomic) CMPedometer *pedometer;
/**
 *  用来计时的Number
 */
@property (nonatomic, assign) NSInteger timerNumber;


@end

@implementation DYStepView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    
    self.backgroundColor = [UIColor clearColor];
    self.completeFlag = NO;
    //设置UI
    [self setupUI];
    
    //添加一个定时器
    [self addATimer];
    
    //计步信息更新
    //[self pedometerMessage];
    
}

- (void)change {

    self.timerNumber++;
    
}


- (void)addATimer {

    NSTimer *timer = [HMWeakTimerTargetObj scheduledTimerWithTimeInterval:1 target:self selector:@selector(change) userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
}


#pragma mark - timerNumber的setter方法
- (void)setTimerNumber:(NSInteger)timerNumber {
    _timerNumber = timerNumber;
    
    if (timerNumber * 3 >= self.targetCount && self.completeFlag == NO) {
        [SVProgressHUD showSuccessWithStatus:@"今日任务已经完成"];
        delay(1.0);
        self.completeFlag = YES;
    }
    
    self.daKaCount.text = [NSString stringWithFormat:@"%zd卡",timerNumber*7];
    self.kmCount.text = [NSString stringWithFormat:@"%zd米",timerNumber * 6];
    self.todayStepCount.text = [NSString stringWithFormat:@"%zd步",timerNumber * 3];
    self.activeTimeCount.text = [NSString stringWithFormat:@"%zd:%zd:%zd",timerNumber / 360, timerNumber % 360 / 60, timerNumber % 60];
}


- (void)pedometerMessage {
    
    [self.pedometer startPedometerUpdatesFromDate:[NSDate date] withHandler:^(CMPedometerData * _Nullable pedometerData, NSError * _Nullable error) {
        // 判断是否可用
        if ([CMPedometer isStepCountingAvailable] == YES) {

            self.todayStepCount.text = [NSString stringWithFormat:@"%d",pedometerData.numberOfSteps.intValue];
        }
        
        if ([CMPedometer isDistanceAvailable] == YES) {

            self.kmCount.text = [NSString stringWithFormat:@".0%f",pedometerData.distance.floatValue];
        }
    }];
}

/**
 *  设置UI
 */
- (void)setupUI {
    
    //添加子控件
    
    [self addSubview:self.daKa];
    [self addSubview:self.activeTime];
    [self addSubview:self.km];
    [self addSubview:self.daKaCount];
    [self addSubview:self.activeTimeCount];
    [self addSubview:self.kmCount];
    [self addSubview:self.todayStep];
    [self addSubview:self.todayStepCount];
    [self addSubview:self.todayTarget];
    [self addSubview:self.level];

    
    //设置子控件
    
    self.daKa.text = @"消耗大卡";
    self.activeTime.text = @"活跃时间";
    self.km.text = @"今日米数";
    
    self.daKaCount.text = @"0卡";
    self.activeTimeCount.text = @"0:0:0";
    self.kmCount.text = @"0米";
    
    self.todayStep.text = @"今日步数";
    self.todayStepCount.text = @"0步";
    
    self.targetCount = 1000;
    [self.todayTarget setTitle:[NSString stringWithFormat:@"目标%zd步",self.targetCount] forState:UIControlStateNormal];
    [self.todayTarget setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    self.todayTarget.titleLabel.font = FONT(14);
    
    self.level.text = [NSString stringWithFormat:@"等级:%@",@"死壮"];
    
    [self.todayTarget addTarget:self action:@selector(todayTargetClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //自动布局
    [self.daKa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(margin);
        make.left.equalTo(self).offset(margin);
        make.height.mas_equalTo(titleHeight);
    }];
    
    [self.activeTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(margin);
        make.left.equalTo(self.daKa.mas_right).offset(margin);
        make.width.equalTo(self.daKa);
        make.height.mas_equalTo(titleHeight);
    }];
    
    [self.km mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(margin);
        make.left.equalTo(self.activeTime.mas_right).offset(margin);
        make.right.equalTo(self).offset(-margin);
        make.width.equalTo(self.activeTime);
        make.height.mas_equalTo(titleHeight);
    }];
    
    [self.daKaCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.daKa.mas_bottom).offset(margin);
        make.left.equalTo(self).offset(margin);
        make.height.mas_equalTo(countHeight);
    }];
    
    [self.activeTimeCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.daKa.mas_bottom).offset(margin);
        make.left.equalTo(self.daKaCount.mas_right).offset(margin);
        make.width.equalTo(self.daKaCount);
        make.height.mas_equalTo(countHeight);
    }];
    
    [self.kmCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.daKa.mas_bottom).offset(margin);
        make.left.equalTo(self.activeTimeCount.mas_right).offset(margin);
        make.right.equalTo(self).offset(-margin);
        make.width.equalTo(self.activeTimeCount);
        make.height.mas_equalTo(countHeight);
    }];
    
    [self.todayStep mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.daKaCount.mas_bottom).offset(2*margin);
        make.left.right.equalTo(self);
        make.height.mas_equalTo(titleHeight);
    }];
    
    [self.todayStepCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.todayStep.mas_bottom);
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.height.mas_equalTo(countHeight);
    }];
    
    [self.todayTarget mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.todayStepCount.mas_bottom);
        make.centerX.equalTo(self.mas_centerX);
    }];
    
    [self.level mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.todayTarget.mas_bottom);
        make.centerX.equalTo(self.mas_centerX);
    }];
    
    
}

#pragma mark - 点击事件

- (void)todayTargetClick:(UIButton *)sender {
    //block跳转到BodybuildingController的setupUI方法
    self.todayTargetClickBlock();
}

#pragma mark - setter方法
- (void)setTargetCount:(NSInteger)targetCount {
    _targetCount = targetCount;
    [self.todayTarget setTitle:[NSString stringWithFormat:@"目标%zd步",targetCount] forState:UIControlStateNormal];
}

#pragma mark - 懒加载
- (DYStepTitleLabel *)daKa {
    if (_daKa == nil) {
        _daKa = [[DYStepTitleLabel alloc] init];
    }
    return _daKa;
}

- (DYStepTitleLabel *)activeTime {
    if (_activeTime == nil) {
        _activeTime = [[DYStepTitleLabel alloc] init];
    }
    return _activeTime;
}

- (DYStepTitleLabel *)km {
    if (_km == nil) {
        _km = [[DYStepTitleLabel alloc] init];
    }
    return _km;
}

- (DYStepCountLabel *)daKaCount {
    if (_daKaCount == nil) {
        _daKaCount = [[DYStepCountLabel alloc] init];
    }
    return _daKaCount;
}

- (DYStepCountLabel *)activeTimeCount {
    if (_activeTimeCount == nil) {
        _activeTimeCount = [[DYStepCountLabel alloc] init];
    }
    return _activeTimeCount;
}

- (DYStepCountLabel *)kmCount {
    if (_kmCount == nil) {
        _kmCount = [[DYStepCountLabel alloc] init];
    }
    return _kmCount;
}

- (DYStepTitleLabel *)todayStep {
    if (_todayStep == nil) {
        _todayStep = [[DYStepTitleLabel alloc] init];
    }
    return _todayStep;
}

- (DYStepCountLabel *)todayStepCount {
    if (_todayStepCount == nil) {
        _todayStepCount = [[DYStepCountLabel alloc] init];
    }
    return _todayStepCount;
}

- (UIButton *)todayTarget {
    if (_todayTarget == nil) {
        _todayTarget = [[UIButton alloc] init];
    }
    return _todayTarget;
}

- (DYStepTitleLabel *)level {
    if (_level == nil) {
        _level = [[DYStepTitleLabel alloc] init];
    }
    return _level;
}
@end
