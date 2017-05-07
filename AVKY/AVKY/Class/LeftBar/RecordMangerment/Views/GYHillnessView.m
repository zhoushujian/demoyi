//
//  GYHillnessView.m
//  AVKY
//
//  Created by Marcello on 16/8/5.
//  Copyright © 2016年 杰. All rights reserved.
//

#import "GYHillnessView.h"
#import <Masonry.h>

@interface GYHillnessView ()

/**
 *  底部黑线View
 */
@property (nonatomic, strong) UIView *lineView;

/**
 *  疾病类型
 */
@property (nonatomic, strong) UILabel *illnessTybe;

/**
 *  选择Lable
 */
@property (nonatomic, strong) UILabel *chooseLable;

/**
 *  箭头图片
 */
@property (nonatomic, strong) UIImageView *arrowImage;

@property (nonatomic, strong) NSArray *stringArray;


@end

@implementation GYHillnessView

- (instancetype)init{
    
    if (self = [super init]) {
          [self setUPUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
          [self setUPUI];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    if (self = [super initWithCoder:aDecoder]) {
        [self setUPUI];
    }
    
    return self;
}

/**
 *  初始化UI
 */
- (void)setUPUI{
    
    self.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:self.lineView];
    
    [self addSubview:self.illnessTybe];
    
    [self addSubview:self.chooseLable];
    
    [self addSubview:self.arrowImage];
    
    //设置子控件
    
    self.arrowImage.image = [UIImage imageNamed:@"position-right"];
    
    
    //布局子控件
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.mas_equalTo(self.mas_bottom);
        make.left.mas_equalTo(self.mas_left).offset(10);
        make.size.mas_equalTo(CGSizeMake([UIScreen mainScreen].bounds.size.width, 1));
        
    }];
    
    [self.illnessTybe mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.mas_left).offset(10);
        make.bottom.mas_equalTo(self.lineView.mas_top).offset(-5);
        
    }];
    
    [self.arrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(self.mas_right).offset(-10);
         make.centerY.mas_equalTo(self.illnessTybe.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(15, 15));
    }];
    
    [self.chooseLable mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.mas_equalTo(self.arrowImage.mas_centerY);
        
        make.right.mas_equalTo(self.arrowImage.mas_left).offset(-5);

    }];
    
}

#pragma mark - set方法

/**
 *  设置疾病的类型
 *
 *  @param illnessString <#illnessString description#>
 */
- (void)setIllnessString:(NSString *)illnessString{
    
    _illnessString = illnessString;
    
    self.chooseLable.text = illnessString;
    
    NSLog(@"text = %@",self.chooseLable.text);
    
    
}


/**
 *  View的类型
 *
 *  @param typeString <#typeString description#>
 */
- (void)setTypeString:(NSString *)typeString{
    
    _typeString= typeString;
    
    self.illnessTybe.text = typeString;
}


#pragma mark - 懒加载

- (UIView *)lineView{
    
    if (!_lineView) {
        
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    
    return _lineView;
}

- (UILabel *)illnessTybe{
    
    if (!_illnessTybe) {
        
        _illnessTybe = [[UILabel alloc] init];
        _illnessTybe.numberOfLines = 0;
        _illnessTybe.text = @"疾病类型";
        
    }
    return _illnessTybe;
}

- (UILabel *)chooseLable{
    
    if (!_chooseLable) {
        _chooseLable = [[UILabel alloc] init];
        _chooseLable.text = @"请选择";
        _illnessString = _chooseLable.text ;
        _chooseLable.font = [UIFont systemFontOfSize:13];
        _chooseLable.textColor = [UIColor grayColor];
        _chooseLable.textAlignment = NSTextAlignmentRight;
    }
    return _chooseLable;
}

- (UIImageView *)arrowImage{
    
    if (!_arrowImage) {
        
        _arrowImage = [[UIImageView alloc] init];

    }
    
    return _arrowImage;
}




@end
