//
//  YZInfoCell.m
//  AVKY
//
//  Created by EZ on 16/8/8.
//  Copyright © 2016年 杰. All rights reserved.
//

#import "YZInfoCell.h"
#import "YZInfo.h"

@interface YZInfoCell ()
/**
 *  信息类别
 */
@property (nonatomic, weak) UILabel *infoCategory;
/**
 *  信息内容
 */
@property (nonatomic, weak) UILabel *infoText;

//箭头
@property (nonatomic,strong) UIImageView *arrowView;

//自定义分割线
@property (nonatomic,weak) UIView *lineView;


@end

@implementation YZInfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    if ([super initWithCoder:aDecoder]) {
        [self setup];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame {
    if ([self initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

/**
 *  设置子控件 steparr
 */
-(void)setup {
    
    //1.title
    UILabel *infoCategory = [[UILabel alloc] init];
    [self.contentView addSubview:infoCategory];
    self.infoCategory = infoCategory;
    infoCategory.font = FONT(16);
    infoCategory.textColor = COLOR(75, 75, 75);
    
    //2.
    UILabel *infoText = [[UILabel alloc] init];
    [self.contentView addSubview:infoText];
    self.infoText = infoText;
    infoText.font = FONT(14);
    infoText.textColor = COLOR(135, 135, 135);
//    infoText.backgroundColor = [UIColor redColor];
    
    //分割线
    UIView *lineView = [[UIView alloc] init];
    [self.contentView addSubview:lineView];
    self.lineView = lineView;
    lineView.backgroundColor = COLOR(238, 238, 238);
    
    //约束子控件
    [infoCategory mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY);
        make.left.mas_equalTo(self).offset(10);
    }];

    [infoText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY);
        make.right.mas_equalTo(self.contentView).offset(-5);
    }];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1);
        make.bottom.mas_equalTo(self.mas_bottom);
        make.left.mas_equalTo(self).offset(10);
        make.right.mas_equalTo(self);
    }];
    
}

#pragma mark - 懒加载

-(void)setInfo:(YZInfo *)info {
    _info = info;
    self.infoCategory.text = info.infoCategory;
    self.infoText.text = info.infoText;
    self.accessoryView = self.arrowView;
}


//这个界面的cell accessoryView数据只有两种样式,所以用懒加载的方式,只需要创建一次对象可重复使用
-(UIImageView *)arrowView
{
    if (!_arrowView) {
        _arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pic_cell_green_accessory_img"]];
    }
    return _arrowView;
}

@end
