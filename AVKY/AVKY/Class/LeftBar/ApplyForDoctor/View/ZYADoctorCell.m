//
//  ZYADoctorCell.m
//  AVKY
//
//  Created by zheng on 16/8/9.
//  Copyright © 2016年 杰. All rights reserved.
//

#import "ZYADoctorCell.h"

#import <UIImageView+WebCache.h>
#define Height 20
#define reuseID @"cell"

@interface ZYADoctorCell ()

@property(nonatomic,strong)UILabel *nameLabel;

@property(nonatomic,strong)UILabel *sexLabel;

@property(nonatomic,strong)UILabel *hospNameLabel;

@property(nonatomic,strong)UILabel *countLabel;

@property(nonatomic,strong)UIImageView *iconView;

@end

@implementation ZYADoctorCell



+(instancetype)doctorCellWithTableView:(UITableView*)tableView{
    ZYADoctorCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (cell == nil) {
        cell = [[ZYADoctorCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseID];
    }
     cell.backgroundColor = [UIColor clearColor];
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //名字
        UILabel  *nameLabel = [[UILabel alloc] init];
        self.nameLabel = nameLabel;
        nameLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:nameLabel];
        //性别
        UILabel *sexLabel = [[UILabel alloc] init];
        self.sexLabel = sexLabel;
        self.sexLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:sexLabel];
        //医院名字
        UILabel *hospNameLabel = [[UILabel alloc] init];
        self.hospNameLabel = hospNameLabel;
        self.hospNameLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:hospNameLabel];
        //预约数
        UILabel *countLabel = [[UILabel alloc] init];
        self.countLabel = countLabel;
        self.countLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:countLabel];
        //头像
        UIImageView *iconView = [[UIImageView alloc] init];
        self.iconView = iconView;
        [self.contentView addSubview:iconView];
        
        [self setupUI];
    }
    return self;
}

-(void)setupUI {
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left);
        make.top.mas_equalTo(self.contentView.mas_top);
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
        make.width.mas_equalTo(80);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.iconView.mas_top);
        make.left.mas_equalTo(self.iconView.mas_right).offset(10);
        make.height.mas_equalTo(Height);
    }];
    
    [self.sexLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameLabel.mas_bottom);
        make.left.mas_equalTo(self.iconView.mas_right).offset(10);
        make.height.mas_equalTo(Height);
    }];
    
    [self.hospNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.sexLabel.mas_bottom);
        make.left.mas_equalTo(self.iconView.mas_right).offset(10);
//        make.size.mas_equalTo(CGSizeMake(300, height));
        make.height.mas_equalTo(Height);
    }];
    
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.hospNameLabel.mas_bottom);
        make.left.mas_equalTo(self.iconView.mas_right).offset(10);
        make.height.mas_equalTo(Height);
    }];
}

-(void)setDoctor:(ZYADoctor *)doctor {
    _doctor = doctor;
    self.nameLabel.text = [NSString stringWithFormat:@"医生名字:%@",self.doctor.doctor_name];
    if (self.doctor.doctor_gender) {
        self.sexLabel.text = @"性别:男";
    } else {
         self.sexLabel.text = @"性别:女";
    }
    self.hospNameLabel.text = [NSString stringWithFormat:@"医院名字:%@",self.doctor.doctor_hospital_name];
    self.countLabel.text = [NSString stringWithFormat:@"预约数:%@",self.doctor.operation_count];
    self.iconView.image = [UIImage imageNamed:@"doctor_defaultphoto_female"];
    

    NSURL *url = [NSURL URLWithString:self.doctor.doctor_portrait];
    [self.iconView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"doctor_defaultphoto_female"]];
    
}

#pragma mark -懒加载控件

-(UILabel*)nameLabel {
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = [UIColor grayColor];
    }
    return _nameLabel;
}

-(UILabel*)sexLabel {
    if (_sexLabel == nil) {
        _sexLabel = [[UILabel alloc] init];
        _sexLabel.textColor = [UIColor grayColor];
    }
    return _sexLabel;
}

-(UILabel*)hospNameLabel {
    if (_hospNameLabel == nil) {
        _hospNameLabel = [[UILabel alloc] init];
        _hospNameLabel.textColor = [UIColor grayColor];
    }
    return _hospNameLabel;
}

-(UILabel*)countLabel {
    if (_countLabel == nil) {
        _countLabel = [[UILabel alloc] init];
        _countLabel.textColor = [UIColor greenColor];
    }
    return _countLabel;
}

-(UIImageView*)iconView {
    if (_iconView == nil) {

        _iconView = [[UIImageView alloc] init];
    }
    return _iconView;
}

@end
