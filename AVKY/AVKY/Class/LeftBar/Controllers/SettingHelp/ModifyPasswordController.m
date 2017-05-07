//
//  ModifyPasswordController.m
//  AVKY
//
//  Created by 杰 on 16/8/8.
//  Copyright © 2016年 杰. All rights reserved.
//

#import "ModifyPasswordController.h"

@interface ModifyPasswordController ()<UITextFieldDelegate>

/**
 *  原密码
 */
@property (nonatomic, strong) UITextField *oldPassord;

/**
 *  新密码
 */
@property (nonatomic, strong) UITextField *NewPassord;

/**
 *  再次新密码
 */
@property (nonatomic, strong) UITextField *passWord;


/**
 *  完成按钮
 */
@property (nonatomic, strong) UIButton *finshButton;

/**
 *  密码提示label
 */
@property (nonatomic, weak) UILabel *promptLabel;


@end

@implementation ModifyPasswordController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置UI
    [self setUPUI];

    
}

/**
 *  设置UI
 */
- (void)setUPUI{
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"pic_hd_1"]] ;
    
    UIImageView *image1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"attention"]];
    
    UIImageView *image2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"attention"]];
    
    UIImageView *image3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"attention"]];
    
    [self.view addSubview:self.oldPassord];
    
    [self.view addSubview:self.NewPassord];
    
    [self.view addSubview:self.passWord];
    
    [self.view addSubview:self.finshButton];
    
    
    [self.view addSubview:image1];
    [self.view addSubview:image2];
    [self.view addSubview:image3];
    
    //提示密码不对label
    UILabel *promptLabel = [[UILabel alloc] init];
    [self.view addSubview:promptLabel];
    self.promptLabel = promptLabel;
    promptLabel.text = @"两次密码输入不一样!";
    promptLabel.textColor = [UIColor redColor];
    promptLabel.font = FONT(14);
    promptLabel.textAlignment = NSTextAlignmentCenter;
    
    
    
    
    [self.finshButton setTitle:@"完成" forState:UIControlStateNormal];
    
    [self.finshButton addTarget:self action:@selector(didClickFinshButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.oldPassord mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.view.mas_top).offset(114);
        
        make.centerX.mas_equalTo(self.view.mas_centerX);
        
        make.size.mas_equalTo(CGSizeMake(200, 30));
    }];
    
    [self.NewPassord mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.oldPassord.mas_bottom).offset(20);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        
        make.size.mas_equalTo(CGSizeMake(200, 30));
        
    }];
    
    [self.passWord mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.top.mas_equalTo(self.NewPassord.mas_bottom).offset(20);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(200, 30));
    }];
    
    [self.finshButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.top.mas_equalTo(self.passWord.mas_bottom).offset(50);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(150, 30));
    }];
    
    
    [image1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(self.oldPassord.mas_left).offset(-20);
        make.centerY.mas_equalTo(self.NewPassord.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    [image2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(self.oldPassord.mas_left).offset(-20);
        make.centerY.mas_equalTo(self.oldPassord.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    [image3 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(self.oldPassord.mas_left).offset(-20);
        make.centerY.mas_equalTo(self.passWord.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
   
    
}


#pragma  mark - 点击事件


- (void)didClickFinshButton:(UIButton *)button{
    
    //1. 三个输入框都有值
    if (self.passWord.text == nil || self.oldPassord.text == nil || self.NewPassord.text == nil) {
        [SVProgressHUD showErrorWithStatus:@"请输入完!"];
        delay(1.5);
        return;
    }
    
    //2.匹配原密码是否正确
    //2.1 获取到数据库账号和密码
    NSArray *accountArr = [AVUserDefaultsTool objetForKey:localAccount];
    NSMutableArray *arrMt = [NSMutableArray array];
    [arrMt addObjectsFromArray:accountArr];
    //2.2 遍历用户数组 匹配账号登录
    for (NSDictionary *dict in accountArr) {
        
        NSString *userID = dict[@"user"];
        NSString *password = dict[@"password"];
        
        if ([userID isEqualToString:[AVUserDefaultsTool objetForKey:currentLoginID]] && [password isEqualToString:self.oldPassord.text]) {
            NSDictionary *infoText = @{@"user":userID,@"password":self.passWord.text};
            //2.3 判断新密码是否输入一致
            if ([self.NewPassord.text isEqualToString:self.passWord.text]) {
                //2.4 先从数组删除原有的数据,在添加新数据
                [arrMt removeObject:dict];
                [arrMt addObject:infoText];
                [AVUserDefaultsTool saveObject:arrMt forKey:localAccount];
                [SVProgressHUD showSuccessWithStatus:@"修改成功"];
                self.oldPassord.text = nil;
                self.NewPassord.text = nil;
                self.passWord.text = nil;
                delay(2);
                return;
            }
        }
    }
    [SVProgressHUD showErrorWithStatus:@"两次密码不成功"];
    delay(2);
}
#pragma mark - 懒加载

- (UITextField *)passWord{
    
    if (!_passWord ) {
        
        _passWord = [[UITextField alloc] init];
        _passWord.placeholder = @"请重新再输入原密码";
        _passWord.borderStyle = UITextBorderStyleRoundedRect;
        _passWord.backgroundColor = [UIColor whiteColor];
          _passWord.delegate = self;
    }
    
    return _passWord;
}


- (UITextField *)oldPassord{
    
    if (!_oldPassord) {
        _oldPassord = [[UITextField alloc] init];
        _oldPassord.borderStyle = UITextBorderStyleRoundedRect;
        _oldPassord.placeholder = @"请输入原密码";
         _oldPassord.backgroundColor = [UIColor whiteColor];
        
    }
    
    return _oldPassord;
}


- (UITextField *)NewPassord{
    
    if (!_NewPassord) {
        
        _NewPassord = [[UITextField alloc] init];
        _NewPassord.placeholder = @"请输入新登录密码";
        _NewPassord.borderStyle = UITextBorderStyleRoundedRect;
         _NewPassord.backgroundColor = [UIColor whiteColor];
        _NewPassord.delegate = self;
    }
    return _NewPassord;
}

- (UIButton *)finshButton{
    
    if (_finshButton ==nil) {
        _finshButton = [[UIButton alloc] init];
        _finshButton.backgroundColor = globalColor;
        //_NewPassord.delegate = self;
    }
    
    return _finshButton;
}

@end
