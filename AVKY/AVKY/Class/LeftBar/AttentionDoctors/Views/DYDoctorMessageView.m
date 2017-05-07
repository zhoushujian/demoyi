//
//  DYDoctorMessageView.m
//  AVKY
//
//  Created by Yangdongwu on 16/8/5.
//  Copyright © 2016年 杰. All rights reserved.
//

#import "DYDoctorMessageView.h"
#import "DYAttentionDoctorCellButton.h"
#import <UIImageView+WebCache.h>
#import "DYDoctor.h"

#define margin 10
#define buttonMargin 30
#define buttonHeight 20
#define iconViewHeight 60

@interface DYDoctorMessageView ()

/**
 *  头像
 */
@property (nonatomic, strong) UIImageView *iconView;
/**
 *  医生名字
 */
@property (nonatomic, strong) UILabel *doctorNameLabel;
/**
 *  医生类型
 */
@property (nonatomic, strong) UILabel *doctorTypeLabel;
/**
 *  医院
 */
@property (nonatomic, strong) UILabel *hospitalLabel;
/**
 *  加号按钮
 */
@property (nonatomic, strong) DYAttentionDoctorCellButton *operationButton;
/**
 *  鲜花按钮
 */
@property (nonatomic, strong) DYAttentionDoctorCellButton *flowerButton;
/**
 *  星星按钮
 */
@property (nonatomic, strong) DYAttentionDoctorCellButton *bannerButton;
/**
 *  预约数
 */
@property (nonatomic, assign) NSInteger operationCount;
/**
 *  鲜花数
 */
@property (nonatomic, assign) NSInteger flowerCount;
/**
 *  锦旗数
 */
@property (nonatomic, assign) NSInteger bannerCount;
/**
 *  匹配度按钮
 */
@property (nonatomic, strong) UIButton *accuracyButton;

@end

@implementation DYDoctorMessageView

#pragma mark - setter方法
- (void)setOperationCount:(NSInteger)operationCount {
    _operationCount = operationCount;
    [self.operationButton setTitle:[NSString stringWithFormat:@"预约数:%zd",operationCount] forState:UIControlStateNormal];
}

- (void)setFlowerCount:(NSInteger)flowerCount {
    _flowerCount = flowerCount;
    [self.flowerButton setTitle:[NSString stringWithFormat:@"鲜花数:%zd",flowerCount] forState:UIControlStateNormal];
}

- (void)setBannerCount:(NSInteger)bannerCount {
    _bannerCount = bannerCount;
    [self.bannerButton setTitle:[NSString stringWithFormat:@"锦旗数:%zd",bannerCount] forState:UIControlStateNormal];
}


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    
    [self setupUI];
    
}

- (void)setupUI {
    
    //添加子控件
    [self addSubview:self.iconView];
    [self addSubview:self.doctorNameLabel];
    [self addSubview:self.doctorTypeLabel];
    [self addSubview:self.hospitalLabel];
    [self addSubview:self.operationButton];
    [self addSubview:self.flowerButton];
    [self addSubview:self.bannerButton];
    [self addSubview:self.accuracyButton];

    
    //设置子控件
    self.iconView.image = [UIImage imageNamed:@"doctor_defaultphoto_female"];
    self.iconView.layer.cornerRadius = iconViewHeight/2.0;
    self.iconView.layer.masksToBounds = YES;
    
    self.doctorNameLabel.text = @"未命名";
    self.doctorNameLabel.font = FONT(20);
    self.doctorTypeLabel.text = @"医生类型";
    self.doctorTypeLabel.font = FONT(14);
    self.hospitalLabel.text = @"名称医院";
    self.hospitalLabel.font = FONT(14);
    self.hospitalLabel.textColor =  [UIColor grayColor];
    self.hospitalLabel.numberOfLines = 0;
    
    [self.operationButton setTitle:[NSString stringWithFormat:@"预约数:%zd",1] forState:UIControlStateNormal];
    [self.operationButton setImage:[UIImage imageNamed:@"add_40x40"] forState:UIControlStateNormal];
    [self.operationButton setImage:[UIImage imageNamed:@"point"] forState:UIControlStateSelected];
    [self.operationButton addTarget:self action:@selector(operationButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.flowerButton setTitle:[NSString stringWithFormat:@"鲜花数:%zd",1] forState:UIControlStateNormal];
    [self.flowerButton setImage:[UIImage imageNamed:@"flower"] forState:UIControlStateNormal];
    [self.flowerButton setImage:[UIImage imageNamed:@"icon_qq"] forState:UIControlStateSelected];
    [self.flowerButton addTarget:self action:@selector(flowerButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.bannerButton setTitle:[NSString stringWithFormat:@"锦旗数:%zd",1] forState:UIControlStateNormal];
    [self.bannerButton setImage:[UIImage imageNamed:@"jinqi"] forState:UIControlStateNormal];
    [self.bannerButton setImage:[UIImage imageNamed:@"flags"] forState:UIControlStateSelected];
    [self.bannerButton addTarget:self action:@selector(bannerButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    

    
    //自动布局子控件
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(margin);
        make.left.equalTo(self).offset(buttonMargin);
        make.size.mas_equalTo(iconViewHeight);
    }];
    
    [self.doctorNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(margin);
        make.left.equalTo(self.iconView.mas_right).offset(margin);
    }];
    
    [self.doctorTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.doctorNameLabel);
        make.left.equalTo(self.doctorNameLabel.mas_right).offset(margin);
    }];
    
    [self.hospitalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.doctorNameLabel.mas_bottom).offset(margin);
        make.left.equalTo(self.iconView.mas_right).offset(margin);
        make.right.equalTo(self.accuracyButton.mas_left).offset(-margin);
    }];
    
    
    [self.operationButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconView.mas_bottom).offset(margin);
        make.left.equalTo(self).offset(buttonMargin);
        make.height.mas_equalTo(buttonHeight);
    }];
    
    [self.flowerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconView.mas_bottom).offset(margin);
        make.left.equalTo(self.operationButton.mas_right).offset(margin);
        make.size.equalTo(self.operationButton);
    }];
    
    [self.bannerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconView.mas_bottom).offset(margin);
        make.left.equalTo(self.flowerButton.mas_right).offset(margin);
        make.right.equalTo(self).offset(-margin);
        make.size.equalTo(self.operationButton);
    }];
    
    [self.accuracyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(margin);
        make.right.equalTo(self).offset(-margin);
        make.bottom.equalTo(self.iconView);
        make.width.mas_equalTo(self.accuracyButton.mas_height).multipliedBy(1);
    }];
    
}

#pragma mark - 接口模型的setter方法
- (void)setDoctor:(DYDoctor *)doctor {
    _doctor = doctor;
    //设置数据
    //根据不同性别设置不同的占位图片
    NSString *placeHolderImageName = self.doctor.doctor_gender ? @"doctor_defaultphoto_male" : @"doctor_defaultphoto_female";
    UIImage *placeHolderImage = [UIImage imageNamed:placeHolderImageName];
    NSURL *url = [NSURL URLWithString:self.doctor.doctor_portrait];
    [self.iconView sd_setImageWithURL:url placeholderImage:placeHolderImage];
    
    self.doctorNameLabel.text = self.doctor.doctor_name;
    self.doctorTypeLabel.text = self.doctor.doctor_title_name;
    self.hospitalLabel.text = self.doctor.hospital_name;
    
    self.operationCount = self.doctor.operation_count.integerValue;
    self.flowerCount = self.doctor.flower.integerValue;
    self.bannerCount = self.doctor.banner.integerValue;
    
    [self.accuracyButton setTitle:self.doctor.accuracy forState:UIControlStateNormal];
    
}


#pragma mark - 点击事件
- (void)operationButtonClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        self.operationCount++;
    }
    else {
        self.operationCount--;
    }
}

- (void)flowerButtonClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        self.flowerCount++;
    }
    else {
        self.flowerCount--;
    }
}

- (void)bannerButtonClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        self.bannerCount++;
    }
    else {
        self.bannerCount--;
    }
}

#pragma mark - 懒加载
- (UIImageView *)iconView {
    if (_iconView == nil) {
        _iconView = [[UIImageView alloc] init];
    }
    return _iconView;
}

- (UILabel *)doctorNameLabel {
    if (_doctorNameLabel == nil) {
        _doctorNameLabel = [[UILabel alloc] init];
    }
    return _doctorNameLabel;
}

- (UILabel *)doctorTypeLabel {
    if (_doctorTypeLabel == nil) {
        _doctorTypeLabel = [[UILabel alloc] init];
    }
    return _doctorTypeLabel;
}

- (UILabel *)hospitalLabel {
    if (_hospitalLabel == nil) {
        _hospitalLabel = [[UILabel alloc] init];
    }
    return _hospitalLabel;
}

- (DYAttentionDoctorCellButton *)operationButton {
    if (_operationButton == nil) {
        _operationButton = [[DYAttentionDoctorCellButton alloc] init];
    }
    return _operationButton;
}

- (DYAttentionDoctorCellButton *)flowerButton {
    if (_flowerButton == nil) {
        _flowerButton = [[DYAttentionDoctorCellButton alloc] init];
    }
    return _flowerButton;
}

- (DYAttentionDoctorCellButton *)bannerButton {
    if (_bannerButton == nil) {
        _bannerButton = [[DYAttentionDoctorCellButton alloc] init];
    }
    return _bannerButton;
}

- (UIButton *)accuracyButton {
    if (_accuracyButton == nil) {
        _accuracyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_accuracyButton setBackgroundImage:[UIImage imageNamed:@"pipeidu"] forState:UIControlStateNormal];
        [_accuracyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _accuracyButton.titleLabel.font = FONT(20);
        [_accuracyButton setTitle:@"快医" forState:UIControlStateNormal];
    }
    return _accuracyButton;
}

@end
