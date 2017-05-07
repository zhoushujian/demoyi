//
//  DYAttentionDoctorListCell.m
//  AVKY
//
//  Created by Yangdongwu on 16/8/5.
//  Copyright © 2016年 杰. All rights reserved.
//

#import "DYAttentionDoctorListCell.h"
#import "DYAttentionDoctorCellButton.h"
#import <UIImageView+WebCache.h>

#define margin 5
#define buttonMargin 30
#define buttonHeight 15
#define iconViewHeight 60
#define billViewHeight 40

@interface DYAttentionDoctorListCell ()
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
 *  单据图
 */
@property (nonatomic, strong) UIImageView *billView;
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



@end

@implementation DYAttentionDoctorListCell

#pragma mark - setter方法
- (void)setOperationCount:(NSInteger)operationCount {
    _operationCount = operationCount;
    [self.operationButton setTitle:[NSString stringWithFormat:@"%zd",operationCount] forState:UIControlStateNormal];
}

- (void)setFlowerCount:(NSInteger)flowerCount {
    _flowerCount = flowerCount;
    [self.flowerButton setTitle:[NSString stringWithFormat:@"%zd",flowerCount] forState:UIControlStateNormal];
}

- (void)setBannerCount:(NSInteger)bannerCount {
    _bannerCount = bannerCount;
    [self.bannerButton setTitle:[NSString stringWithFormat:@"%zd",bannerCount] forState:UIControlStateNormal];
}

#pragma mark - 初始化cell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    
    //设置cell的accessoryView类型为箭头类型
//    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    UIImageView *accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"position-right"]];
    self.accessoryView = accessoryView;
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = globalColor;
    self.selectedBackgroundView = bgView;
    //添加子控件
    [self.contentView addSubview:self.iconView];
    [self.contentView addSubview:self.doctorNameLabel];
    [self.contentView addSubview:self.doctorTypeLabel];
    [self.contentView addSubview:self.hospitalLabel];
    [self.contentView addSubview:self.operationButton];
    [self.contentView addSubview:self.flowerButton];
    [self.contentView addSubview:self.bannerButton];
    [self.contentView addSubview:self.billView];
    
    //设置子控件
    self.iconView.image = [UIImage imageNamed:@"doctor_defaultphoto_female"];
    self.doctorNameLabel.text = @"小黑";
    self.doctorNameLabel.font = FONT(14);
    self.doctorTypeLabel.text = @"心理医生";
    self.doctorTypeLabel.font = FONT(14);
    self.hospitalLabel.text = @"深圳黑马第四医院";
    self.hospitalLabel.font = FONT(14);
    
    [self.operationButton setImage:[UIImage imageNamed:@"knife"] forState:UIControlStateNormal];
    [self.operationButton setImage:[UIImage imageNamed:@"5"] forState:UIControlStateSelected];
    [self.operationButton addTarget:self action:@selector(operationButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.flowerButton setImage:[UIImage imageNamed:@"flower"] forState:UIControlStateNormal];
    [self.flowerButton setImage:[UIImage imageNamed:@"icon_qq"] forState:UIControlStateSelected];
    [self.flowerButton addTarget:self action:@selector(flowerButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.bannerButton setImage:[UIImage imageNamed:@"jinqi"] forState:UIControlStateNormal];
    [self.bannerButton setImage:[UIImage imageNamed:@"flags"] forState:UIControlStateSelected];
    [self.bannerButton addTarget:self action:@selector(bannerButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.billView.image = [UIImage imageNamed:@"doctorApplied"];
    
    //自动布局子控件
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(margin);
        make.left.equalTo(self.contentView).offset(margin);
        make.size.mas_equalTo(iconViewHeight);
    }];
    
    [self.doctorNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(margin);
        make.left.equalTo(self.iconView.mas_right).offset(margin);
    }];
    
    [self.doctorTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(margin);
        make.left.equalTo(self.doctorNameLabel.mas_right).offset(margin);
    }];
    
    [self.hospitalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.doctorNameLabel.mas_bottom).offset(margin);
        make.left.equalTo(self.iconView.mas_right).offset(margin);
        make.right.equalTo(self.billView.mas_left).offset(-margin);
    }];
    
    [self.billView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-margin);
        make.size.mas_equalTo(CGSizeMake(billViewHeight, billViewHeight));
    }];
    
    [self.operationButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.iconView);
        make.left.equalTo(self.iconView.mas_right).offset(buttonMargin);
        make.height.mas_equalTo(buttonHeight);
    }];
    
    [self.flowerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.iconView);
        make.left.equalTo(self.operationButton.mas_right).offset(margin);
        make.size.equalTo(self.operationButton);
    }];
    
    [self.bannerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.iconView);
        make.left.equalTo(self.flowerButton.mas_right).offset(margin);
        make.right.equalTo(self.billView.mas_left).offset(-buttonMargin);
        make.size.equalTo(self.operationButton);
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

- (UIImageView *)billView {
    if (_billView == nil) {
        _billView = [[UIImageView alloc] init];
    }
    return _billView;
}


@end
