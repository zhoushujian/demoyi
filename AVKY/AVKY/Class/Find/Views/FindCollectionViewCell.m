//
//  FindCollectionViewCell.m
//  AVKY
//
//  Created by 杰 on 16/8/7.
//  Copyright © 2016年 杰. All rights reserved.
//

#import "FindCollectionViewCell.h"

#import <UIButton+WebCache.h>
@interface FindCollectionViewCell ()

@property (strong, nonatomic) UIButton *Image;

@property (strong, nonatomic) UILabel *title;

@property(nonatomic,strong)UILabel *priceLb;
@property(nonatomic,strong)UILabel *payPriceLb;

@end

@implementation FindCollectionViewCell


-(void)setModel:(MAModel *)Model{
    _Model = Model;

    [self.Image sd_setImageWithURL:[NSURL URLWithString:Model.danPinImg] forState:UIControlStateNormal];
    self.title.text = Model.name;
    
    
    
    
    
    /**
     *  设置在线观看人数的富文本属性NSStrikethroughStyleAttributeName
     */
    int num = Model.price/100;
    
    NSString *online_usersStr = [NSString stringWithFormat:@"￥%d.00",num];
    NSMutableAttributedString *nums = [[NSMutableAttributedString alloc]initWithString:online_usersStr];
    
    [nums beginEditing];
    
    [nums addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16.0] range:NSMakeRange(0, nums.length)];
    
    [nums addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, nums.length)];

   
    self.priceLb.attributedText = nums;
    
    
    int num1 =Model.payPrice/100;
    NSString *online_usersStrOne = [NSString stringWithFormat:@"￥%d.00",num1];
    NSMutableAttributedString *numsOne = [[NSMutableAttributedString alloc]initWithString:online_usersStrOne];
    
    [numsOne beginEditing];
    
     [numsOne addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlineStyleNone) range:NSMakeRange(0, numsOne.length)];
     [numsOne addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0,numsOne.length)];
    
  
    [numsOne addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:213/255.0 green:209/255.0 blue:201/255.0 alpha:1] range:NSMakeRange(0, nums.length)];
    
    
    self.payPriceLb.attributedText = numsOne;

    
    
    
 
    
    
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self setUI];
    }
    return self;
}

-(void)setUI{
    
    [self.contentView addSubview:self.Image];
    [self.contentView addSubview:self.title];
    [self.contentView addSubview:self.priceLb];
    [self.contentView  addSubview:self.payPriceLb];
    
    [self.priceLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(40);
        make.left.mas_equalTo(self.contentView);
        make.bottom.mas_equalTo(self.contentView);

    }];
    [self.payPriceLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(self.priceLb);
        make.left.mas_equalTo(self.priceLb.mas_right);
        make.bottom.mas_equalTo(self.priceLb);
        make.width.mas_equalTo(self.priceLb);
        make.right.mas_equalTo(self.contentView).offset(-0.5);
        
    }];
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(40);
        make.left.mas_equalTo(self.contentView);
        make.bottom.mas_equalTo(self.priceLb.mas_top);
        make.right.mas_equalTo(self.contentView).offset(-0.5);
    }];
    
    [self.Image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(self.contentView).offset(0);
        make.bottom.mas_equalTo(self.title.mas_top);
        make.right.mas_equalTo(self.contentView).offset(-0.5);
    }];
}

-(UIButton *)Image{
    if (!_Image) {
        _Image = [[UIButton alloc]init];
        _Image.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _Image;
}

-(UILabel *)title{

    if (!_title) {
        _title = [[UILabel alloc]init];
        _title.backgroundColor = [UIColor whiteColor];
        _title.textAlignment = NSTextAlignmentCenter;
        _title.font = [UIFont systemFontOfSize:16];
    }
    return _title;
}
-(UILabel *)priceLb{
    if (!_priceLb) {
        _priceLb = [[UILabel alloc]init];
        _priceLb.backgroundColor = [UIColor whiteColor];
        _priceLb.textAlignment = NSTextAlignmentCenter;
    }
    return _priceLb;
}
-(UILabel *)payPriceLb{
    if (!_payPriceLb) {
        _payPriceLb = [[UILabel alloc]init];
        _payPriceLb.backgroundColor = [UIColor whiteColor];
        _payPriceLb.textAlignment = NSTextAlignmentLeft;
    }
    return _payPriceLb;
}

@end

