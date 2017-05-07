//
//  GYHIdentifiView.m
//  AVKY
//
//  Created by Marcello on 16/8/4.
//  Copyright © 2016年 杰. All rights reserved.
//

#import "GYHIdentifiView.h"
#import <Masonry.h>

@interface GYHIdentifiView ()

/**
 *  头像
 */
@property (nonatomic, strong) UIImageView *AvatarView;

/**
 *  名称
 */
@property (nonatomic, strong) UILabel *nameLable;

/**
 *  基本信息
 */
@property (nonatomic, strong) UILabel *informationLable;

@end

@implementation GYHIdentifiView


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
    
    [self addSubview:self.AvatarView];
    
    [self addSubview:self.nameLable];
    
    [self addSubview:self.informationLable];
    
    //设置子UI
    //"name" = "Duguqiubai";//昵称
    //"PersonMessage" = "Your basic information";//您的基本信息
    NSString *name = NSLocalizedString(@"name", nil);
    NSString *PersonMessage = NSLocalizedString(@"PersonMessage", nil);
    self.nameLable.text = name;
    
    self.informationLable.text = PersonMessage;
    
    UIImage *image = [[UserAccount sharedUserAccount] getDocumentImage];
    
    if (image == nil) {
        
        self.AvatarView.image = [UIImage imageNamed:@"head.jpeg"];
    }else{
        
        self.AvatarView.image =image;
    }
    

    self.AvatarView.layer.cornerRadius = 25;
    
    self.AvatarView.layer.masksToBounds = YES;
    
    //布局子UI
    
    [self.AvatarView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(25);
        
        make.top.equalTo(self).offset(25);
        
        make.size.mas_equalTo(CGSizeMake(50, 50));
        
    }];
    
    [self.nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.AvatarView.mas_right).offset(20);
        make.top.mas_equalTo(self.AvatarView.mas_top);
        
    }];
    
    [self.informationLable mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.AvatarView.mas_right).offset(20);
        
        make.bottom.mas_equalTo(self.AvatarView.mas_bottom);
        
    }];
    
    
//    //当前用户昵称改变的通知
//#define userNameNotification @"userNameNotification"
//    //当前用户图像改变的通知
//#define userIconNotification @"userIconNotification"
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changAvatarView) name:userIconNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeuserNamed) name:userNameNotification object:nil];
    
    NSString *string = [AVUserDefaultsTool objetForKey:userName_Key];
    
    if (string == nil) {
         string = @"请设置你的昵称";
    }
    
    self.nameLable.text = string;
    
    
}

/**
 *  改变头像
 */
- (void)changAvatarView{
    
    UIImage *image = [[UserAccount sharedUserAccount] getDocumentImage];
    
    if (image == nil) {
        
        self.AvatarView.image = [UIImage imageNamed:@"head.jpeg"];
    }else{
        
        self.AvatarView.image =image;
    }
    
}
/**
 *  更改用户名
 */
- (void)changeuserNamed{
    
    NSString *string = [AVUserDefaultsTool objetForKey:userName_Key];
    
    self.nameLable.text = string;
    
}

#pragma mark - 懒加载

- (UIImageView *)AvatarView{
    
    if (!_AvatarView) {
        _AvatarView = [[UIImageView alloc] init];
    }
    return _AvatarView;
}

- (UILabel *)nameLable{
    
    if (!_nameLable) {
        
        _nameLable = [[UILabel alloc] init];
        _nameLable.numberOfLines = 0;
        _nameLable.textColor = [UIColor whiteColor];
    }
    return _nameLable;
}


- (UILabel *)informationLable{
    
    if (!_informationLable) {
        _informationLable = [[UILabel alloc] init];
        _informationLable.numberOfLines = 0;
        _informationLable.textColor = [UIColor whiteColor];
    }
    return _informationLable;
}




@end
