//
//  AVKYMovieCell.m
//  AVKY
//
//  Created by 杰 on 16/8/7.
//  Copyright © 2016年 杰. All rights reserved.
//

#import "AVKYMovieCell.h"
#import <UIImageView+WebCache.h>
#import <UIButton+WebCache.h>
@implementation AVKYMovieCell

+(instancetype)tableViewCell:(UITableView *)tableView{
    AVKYMovieCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[AVKYMovieCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    return cell;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle =  UITableViewCellSelectionStyleNone;
        
        [self setUI];
        
    }
    return self;
}
#pragma mark - 设置UI
-(void)setUI{
    
    [self.contentView addSubview:self.HeadImage];
    [self.contentView addSubview:self.nameLb];
    [self.contentView addSubview:self.cityBtn];
    [self.contentView addSubview:self.watchNum];
    [self.contentView addSubview:self.personImage];
    [self.contentView addSubview:self.titleLb];
    
    
    [self.HeadImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).offset(5);
        make.top.mas_equalTo(self.contentView).offset(8);
        make.width.height.equalTo(@40);
    }];
    [self.nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.HeadImage.mas_right).offset(5);
        make.top.mas_equalTo(self.contentView).offset(8);
        make.height.equalTo(self.HeadImage.mas_height).multipliedBy(0.5);
        
    }];
    [self.cityBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLb);
        make.width.mas_equalTo(150);
        make.height.equalTo(self.nameLb);
        make.top.mas_equalTo(self.nameLb.mas_bottom);
    }];
    
    [self.watchNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView).offset(-5);
        make.bottom.mas_equalTo(self.cityBtn);
        make.height.mas_equalTo(self.cityBtn);
    }];
    [self.personImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.HeadImage.mas_bottom).offset(5);
        make.bottom.mas_equalTo(self.titleLb.mas_top);
    }];
    
    [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView);
        make.bottom.mas_equalTo(self.contentView);
        make.height.mas_equalTo(0);
        //        make.size.mas_equalTo(CGSizeZero);
        //        make.right.mas_equalTo(self.watchNum);
        //        make.height.mas_equalTo(30);
    }];
    
    
    
    
}



#pragma mark -设置数据
-(void)setModel:(MovieModel *)model{
    _model = model;
    [self setData:model];
}
-(void)setData:(MovieModel *)model{
    

    
    [self.HeadImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://img.meelive.cn/%@",model.creator.portrait]] placeholderImage:[UIImage imageNamed:@"user_default"]];
    
    
    self.nameLb.text = model.creator.nick;
    
    if ([model.city isEqualToString:@""]) {
        [self.cityBtn setTitle:@"来自于逗逼星球" forState:UIControlStateNormal];
        
    }else{
        [self.cityBtn setTitle:[NSString stringWithFormat:@" %@",model.city] forState:UIControlStateNormal];
    }
    
    
    /**
     *  设置在线观看人数的富文本属性
     */
    NSString *online_usersStr = [NSString stringWithFormat:@"%d 在观看",model.online_users];
    NSMutableAttributedString *nums = [[NSMutableAttributedString alloc]initWithString:online_usersStr];
    
    [nums beginEditing];
    
    [nums addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20.0] range:NSMakeRange(0, nums.length-4)];
    [nums addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"AppleGothic" size:20] range:NSMakeRange(0, nums.length-4)];
    
    [nums addAttribute:NSForegroundColorAttributeName value:[UIColor purpleColor] range:NSMakeRange(0, nums.length-4)];
    self.watchNum.attributedText = nums;
    
    [self.personImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://img.meelive.cn/%@",model.creator.portrait]] placeholderImage:[UIImage imageNamed:@"tree"]];
    
    
    
    
    self.titleLb.text = model.name;
    
    
    //判断titleLb有没有值，如果有值就#更新titleLb的#frame值#按时打算#
    dispatch_async(dispatch_get_main_queue(), ^{
        if (![model.name isEqualToString:@""]) {
            
            
            [self.titleLb mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(30);
                make.width.mas_equalTo(self.contentView.mas_width);
            }];
            
            
        }
    });
    
    
}



#pragma mark -自动布局
-(void)layoutSubviews{
    [super layoutSubviews];
    
}
#pragma mark - 控件懒加载
-(UIImageView *)HeadImage{ //头像
    if (!_HeadImage) {
        _HeadImage = [[UIImageView alloc]init];
        _HeadImage.layer.cornerRadius = 20;
        _HeadImage.layer.borderWidth = 4;
        _HeadImage.layer.borderColor = [UIColor blackColor].CGColor;
        _HeadImage.clipsToBounds = YES;
    }
    return _HeadImage;
}
-(UILabel *)nameLb{ //主播姓名
    if (!_nameLb) {
        _nameLb = [[UILabel alloc]init];
        _nameLb.font = [UIFont systemFontOfSize:12];
        _nameLb.textColor = [UIColor blackColor];
        _nameLb.textAlignment = NSTextAlignmentLeft;
    }
    return _nameLb;
}
-(UIButton *)cityBtn{ //城市
    if (!_cityBtn) {
        _cityBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cityBtn setImage:[UIImage imageNamed:@"address"] forState:UIControlStateNormal];
        [_cityBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _cityBtn.titleLabel.font = [UIFont systemFontOfSize:10];
        _cityBtn.userInteractionEnabled = NO;
        //文字左对齐
        _cityBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        
    }
    return _cityBtn;
}
-(UILabel *)watchNum{ //观看人数
    if (!_watchNum) {
        _watchNum = [[UILabel alloc]init];
        _watchNum.font = [UIFont systemFontOfSize:12];
        _watchNum.textAlignment = NSTextAlignmentRight;
        _watchNum.textColor = [UIColor grayColor];
    }
    return _watchNum;
}
-(UIImageView *)personImage{ //封面
    if (!_personImage) {
        _personImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"tree"]];
    }
    return _personImage;
}
-(UILabel *)titleLb{ //下标题
    if (!_titleLb) {
        _titleLb = [[UILabel alloc]initWithFrame:CGRectZero];
        _titleLb.font = [UIFont systemFontOfSize:14];
        _titleLb.textAlignment = NSTextAlignmentLeft;
        _titleLb.textColor = [UIColor purpleColor];
    }
    return _titleLb;
}
@end
