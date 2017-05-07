//
//  GYHLoginView.m
//  AVKY
//
//  Created by Marcello on 16/8/7.
//  Copyright © 2016年 杰. All rights reserved.
//

#import "GYHLoginView.h"


@interface GYHLoginView ()

/**
 *  头像
 */
@property (nonatomic, strong) UIImageView *headPointVeiw;

/**
 *  注册按钮
 */
@property (nonatomic, strong) UIButton *resignButtton;

/**
 *  登录按钮
 */
@property (nonatomic, strong) UIButton *loginButton;

@end

@implementation GYHLoginView


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
    
    if (self  = [super initWithCoder:aDecoder]) {
        [self setupUI];
    }
    
    return self;
}

/**
 *  初始化UI
 */
- (void)setupUI{
    
    self.backgroundColor =  [UIColor colorWithRed:87/255.0 green:199/255.0 blue:199/255.0 alpha:1];

    [self addSubview:self.headPointVeiw];
    
    [self addSubview:self.loginButton];
    
    [self addSubview:self.resignButtton];
    
    //设置UI
    self.headPointVeiw.image = [UIImage imageNamed:@"head.jpeg"];
    
    self.headPointVeiw.layer.cornerRadius = 30;
    
    self.headPointVeiw.layer.masksToBounds = YES;
//    "login" = "login";//登录
//    "register" = "register";//注册
    
    NSString *login = NSLocalizedString(@"login", nil);
    NSString *registe = NSLocalizedString(@"registe", nil);
    self.loginButton.titleLabel.text = login;
    [self.loginButton setTitle:login forState:UIControlStateNormal];
    [self.loginButton addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    
    self.resignButtton.titleLabel.text = registe;
    [self.resignButtton setTitle:registe forState:UIControlStateNormal];
    [self.resignButtton addTarget:self action:@selector(regist:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.headPointVeiw mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(self.mas_centerX);
        
        make.top.mas_equalTo(self.mas_top).offset(20);
        
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    
    [self.resignButtton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(self.headPointVeiw.mas_left).offset(-15);
        
        make.centerY.mas_equalTo(self.headPointVeiw.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(60, 30));
    }];
    
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.headPointVeiw.mas_right).offset(10);
        
        make.centerY.mas_equalTo(self.headPointVeiw.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(50, 30));
    }];
    
    
    
}


#pragma mark - 响应事件

/**
 *  登录
 *
 *  @param button <#button description#>
 */
- (void)login:(UIButton *)button{
    
//    NSLog(@"登录");
    
    if(self.goToLogin){
        self.goToLogin();
    }
}

/**
 *  注册
 *
 *  @param button <#button description#>
 */
- (void)regist:(UIButton *)button{
    
//    NSLog(@"注册");
    
    if (self.goToRegister) {
        
        self.goToRegister();
    }
}


#pragma mark - 懒加载


- (UIImageView *)headPointVeiw{
    
    if (!_headPointVeiw) {
        
        _headPointVeiw = [[UIImageView alloc] init];;
        _headPointVeiw.image = [UIImage imageNamed:@"doctor_defaultphoto_male"];
    }
    
    return _headPointVeiw;
}


- (UIButton *)resignButtton{
    
    if (!_resignButtton) {
        
        _resignButtton = [[UIButton alloc] init];
        _resignButtton.titleLabel.font = [UIFont systemFontOfSize:15];
        
    }
    return _resignButtton;
}


- (UIButton *)loginButton{
    
    if (!_loginButton) {
        
        _loginButton = [[UIButton alloc] init];
         _loginButton.titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _loginButton;
}

@end
