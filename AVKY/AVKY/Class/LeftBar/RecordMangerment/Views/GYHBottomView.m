//
//  GYHBottomView.m
//  AVKY
//
//  Created by Marcello on 16/8/4.
//  Copyright © 2016年 杰. All rights reserved.
//

#import "GYHBottomView.h"
#import <Masonry.h>

@interface GYHBottomView ()

@property (nonatomic, strong) UIButton *button;

@end

@implementation GYHBottomView


- (instancetype)init{
    
    if (self = [super init]) {
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    if (self = [super initWithCoder:aDecoder]) {
        [self setupUI];
        
    }
    return self;
}


- (void)setupUI{
    
    [self addSubview:self.button];
    
    //设置UI
    
    [self.button setTitle:@"   添加病历" forState:UIControlStateNormal];
    
    [self.button setTitleColor:[UIColor colorWithRed:87/255.0 green:199/255.0 blue:199/255.0 alpha:1] forState:UIControlStateNormal];
    
    [self.button setImage:[UIImage imageNamed:@"add_40x40"] forState:UIControlStateNormal];
    self.button.enabled = NO;
    //布局UI
    
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(self.mas_centerX);
        make.centerY.mas_equalTo(self.mas_centerY);

    }];
}

- (UIButton *)button{
    
    if (!_button) {
        
        _button = [[UIButton alloc] init];
        
    }
    return _button;
}


@end
