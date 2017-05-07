//
//  YZVerificationCodeController.m
//  AVKY
//
//  Created by EZ on 16/8/4.
//  Copyright © 2016年 杰. All rights reserved.
//

#import "YZLoginController.h"
#import "YZRegisterController.h"
#import "YZRetrievePasswordController.h"
#import "OAuthViewController.h"
#import "YZVerificationCodeController.h"


@interface YZVerificationCodeController ()
/**
 *  账号
 */
@property (nonatomic, weak) UITextField *userPhoneID;

//电话号码验证成功提示符
@property (nonatomic, weak) UIImageView *verifyPhone;

/**
 *  密码
 */
@property (nonatomic, weak) UITextField *password;
/**
 *  验证码button
 */
@property (nonatomic, weak) UIButton *verificationCodeButton;

/**
 *  验证码输入框
 */
@property (nonatomic, weak) UITextField *verificationCodeTextField;

/**
 *  定时器
 */
@property (nonatomic, strong) NSTimer *timer;
/**
 *  定时器时间
 */
@property (nonatomic, assign) NSInteger timerInterval;
@end

@implementation YZVerificationCodeController


#pragma mark - viewDidLoad 方法
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"短信快速登录";
    [self setupViewBackGround];
    //设置UI
    [self setupUI];
    
    //设置导航左边item
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(didClickAccountButton)];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    //设置 提示效果
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
    
    //添加键盘将要显示的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChanged:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

#pragma mark - 点击事件

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //退出键盘
    [self.view endEditing:YES];
}

/**
 *  键盘将要显示
 *
 *  @param notification 通知
 */
-(void)keyboardWillChanged:(NSNotification *)notification {
    
    //获得键盘弹出后（缩回后）的frame
    CGRect endKeyboard = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    //用当前界面的总高度 - 键盘弹出后(缩回后)的y值，就可以得到要滚动的值了
    CGFloat offsetY = endKeyboard.origin.y - self.view.bounds.size.height;
    if (offsetY != 0) {
        offsetY += 135;
    }
    
    //取出键盘的动画时间
    CGFloat animaDuration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    self.view.transform = CGAffineTransformMakeTranslation(0, offsetY);
    
    //让界面往上面滚动
    __weak typeof(self) weakself = self;
    [UIView animateWithDuration:animaDuration animations:^{
        //让整个View滚动
        weakself.view.transform = CGAffineTransformMakeTranslation(0, offsetY);
    }];
}


#pragma mark - 设置UI

/**
 *  设置当前控制器的背景图片
 */
-(void)setupViewBackGround {
    UIImageView *backgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pic_hd"]];
    backgroundImage.frame = self.view.bounds;
    [self.view addSubview:backgroundImage];
}
/**
 *  设置UI
 */
-(void)setupUI {
    //1.添加子控件
    // 登录账户
    UITextField *userPhoneID = [[UITextField alloc] init];
    [self.view addSubview:userPhoneID];
    self.userPhoneID = userPhoneID;
    [UITextField setTextFieldLeftImage:userPhoneID image:@"numberDetails"];
    //监听编辑完成的状态
    [userPhoneID addTarget:self action:@selector(endediting:) forControlEvents:UIControlEventEditingDidEnd];
    //开始监听编辑的状态
    [userPhoneID addTarget:self action:@selector(changedediting:) forControlEvents:UIControlEventEditingChanged];
    userPhoneID.placeholder = @"请输入您的手机号码";
    userPhoneID.borderStyle = UITextBorderStyleRoundedRect;
    //快速清除功能
    userPhoneID.clearButtonMode = UITextFieldViewModeWhileEditing;
    userPhoneID.font = FONT(14);
    //设置数字键盘输入框
    userPhoneID.keyboardType = UIKeyboardTypePhonePad;
    
    // 验证码框
    UITextField *verificationCodeTextField = [[UITextField alloc] init];
    [self.view addSubview:verificationCodeTextField];
    self.verificationCodeTextField = verificationCodeTextField;
    [UITextField setTextFieldLeftImage:verificationCodeTextField image:@"numberDetails"];
    verificationCodeTextField.placeholder = @"请输入您的验证码";
    verificationCodeTextField.borderStyle = UITextBorderStyleRoundedRect;
    verificationCodeTextField.font = FONT(14);
    verificationCodeTextField.keyboardType = UIKeyboardTypeNumberPad;
    verificationCodeTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    // 获取验证码
    UIButton *verificationCodeButton = [[UIButton alloc] init];
    [self.view addSubview:verificationCodeButton];
    self.verificationCodeButton = verificationCodeButton;
    [verificationCodeButton setBackgroundImage:[UIImage imageNamed:@"buttonBackground"] forState:UIControlStateNormal];
    verificationCodeButton.titleLabel.font = FONT(14);
    //添加点击事件
    [verificationCodeButton addTarget:self action:@selector(verificationCodeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [verificationCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [verificationCodeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    verificationCodeButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    // 账号登录
    UIButton *verificationCodeLogin = [[UIButton alloc] init];
    [verificationCodeLogin setTitle:@"通过账号密码登录" forState:UIControlStateNormal];
    [verificationCodeLogin setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.view addSubview:verificationCodeLogin];
    verificationCodeLogin.titleLabel.font = FONT(14);
    //添加点击事件
    [verificationCodeLogin addTarget:self action:@selector(didClickAccountButton) forControlEvents:UIControlEventTouchUpInside];
    
    // 登录
    UIButton *loginButton = [[UIButton alloc]init];
    [self.view addSubview:loginButton];
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginButton setBackgroundImage:[UIImage imageNamed:@"buttonBackground"] forState:UIControlStateNormal];
    //文字居中
    loginButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    //添加点击事件
    [loginButton addTarget:self action:@selector(didClickLoginButton) forControlEvents:UIControlEventTouchUpInside];
    
    //注册账号
    UIButton *registerUser = [[UIButton alloc] init];
    [registerUser setTitle:@"注册账号" forState:UIControlStateNormal];
    [registerUser setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.view addSubview:registerUser];
    registerUser.titleLabel.font = FONT(14);
    [registerUser addTarget:self action:@selector(didClickRegisterButton) forControlEvents:UIControlEventTouchUpInside];
    
    //找回密码
    UIButton *retrievePassword = [[UIButton alloc] init];
    [retrievePassword setTitle:@"找回密码" forState:UIControlStateNormal];
    [retrievePassword setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [retrievePassword addTarget:self action:@selector(didClickRetrievePasswordButton) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:retrievePassword];
    retrievePassword.titleLabel.font = FONT(14);
    
    //分割线
    UIView *lineView = [[UIView alloc] init];
    [self.view addSubview:lineView];
    lineView.backgroundColor = randomColor;
    
    //sdk_weibo_logo
    //第三方登录
    UIButton *QQbtn = [[UIButton alloc] init];
    [self.view addSubview:QQbtn];
    [QQbtn setImage:[UIImage imageNamed:@"icon_qq"] forState:UIControlStateNormal];
    [QQbtn addTarget:self action:@selector(didClickQQbutton) forControlEvents:UIControlEventTouchUpInside];
    
    //微信
    UIButton *weixinBtn = [[UIButton alloc] init];
    [self.view addSubview:weixinBtn];
    [weixinBtn setImage:[UIImage imageNamed:@"weixin"] forState:UIControlStateNormal];
    [weixinBtn addTarget:self action:@selector(didClickWeixinbutton) forControlEvents:UIControlEventTouchUpInside];
    
    //微博
    UIButton *weiboBtn = [[UIButton alloc] init];
    [self.view addSubview:weiboBtn];
    [weiboBtn setImage:[UIImage imageNamed:@"icon"] forState:UIControlStateNormal];
    [weiboBtn addTarget:self action:@selector(didClickWeibobutton) forControlEvents:UIControlEventTouchUpInside];
    
    //验证手机号码
    UIImageView *verifyPhone = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_right"]];
    [self.view addSubview:verifyPhone];
    verifyPhone.hidden = YES;
    self.verifyPhone = verifyPhone;
    
    
    /************************ 2.布局子控件 ****************************/
    CGFloat topMargin;
    if (is4inch) {
        topMargin = 30;
    } else if(is47inch){
        topMargin = 40;
    } else if(is55inch){
        topMargin = 40;
    }
    
    CGFloat margin = 30;
    [userPhoneID mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(200);
        make.left.mas_equalTo(self.view).offset(margin);
        make.right.mas_equalTo(self.view).offset(-margin);
    }];
    
    //电话验证提示
    [verifyPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(userPhoneID).offset(5);
        make.left.mas_equalTo(userPhoneID.mas_right).offset(5);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    [verificationCodeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(margin);
        make.top.mas_equalTo(userPhoneID.mas_bottom).offset(topMargin);
        make.right.mas_equalTo(self.view).offset(-170);
    }];
    
    [verificationCodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view).offset(-margin);
        make.top.mas_equalTo(userPhoneID.mas_bottom).offset(topMargin);
        make.width.mas_equalTo(90);
        make.height.mas_equalTo(30);
    }];
    
    [verificationCodeLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(verificationCodeTextField.mas_bottom).offset(topMargin);
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
    
    [loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(verificationCodeLogin.mas_bottom).offset(topMargin);
        make.left.right.mas_equalTo(userPhoneID);
        //        make.right.mas_equalTo(phoneTextField.mas_right);
    }];
    
    //分割线
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(loginButton.mas_bottom).offset(30);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(1);
    }];
    
    [registerUser mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(loginButton.mas_bottom).offset(35);
        make.right.mas_equalTo(lineView).offset(-30);
        make.height.mas_equalTo(20);
    }];
    
    [retrievePassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(loginButton.mas_bottom).offset(35);
        make.left.mas_equalTo(lineView).offset(30);
        make.height.mas_equalTo(20);
    }];
    
    //第三方登录子控件
    [weixinBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lineView.mas_bottom).offset(topMargin);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    [QQbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weixinBtn);
        make.right.mas_equalTo(weixinBtn.mas_left).offset(-30);
        make.size.mas_equalTo(weixinBtn);
    }];
    [weiboBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weixinBtn);
        make.left.mas_equalTo(weixinBtn.mas_right).offset(30);
        make.size.mas_equalTo(weixinBtn);
    }];
    
}


#pragma mark - 设置定时器
/**
 *  添加定时器
 */
- (void)addTimer {
    
    // 创建定时器
    self.timer = [HMWeakTimerTargetObj scheduledTimerWithTimeInterval:1 target:self selector:@selector(changeCountDown) userInfo:nil repeats:YES];
    // 添加到运行循环
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

/**
 *  移除定时器
 */
- (void)removeTimer {
    [self.timer invalidate];
    self.timer = nil;
}

/**
 *  定时器任务
 */
-(void)changeCountDown {
    //改变倒计时的内容
    NSString *countDown = [NSString stringWithFormat:@"%zd秒",self.timerInterval--];
    [self.verificationCodeButton setTitle:countDown forState:UIControlStateNormal];
    //倒计时为0时 就移除定时器,
    if (self.timerInterval == 0) {
        [self removeTimer];
        [self.verificationCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    }
}

#pragma mark - 短信发送

/**
 *  获取验证码
 */
-(void)getCode {
    /*================= 获取验证码 =================*/
    
    /**
     *  @from                    v1.1.1
     *  @brief                   获取验证码(Get verification code)
     *
     *  @param method            获取验证码的方法(The method of getting verificationCode)
     *  @param phoneNumber       电话号码(The phone number)
     *  @param zone              区域号，不要加"+"号(Area code)
     *  @param customIdentifier  自定义短信模板标识 该标识需从官网http://www.mob.com上申请，审核通过后获得。(Custom model of SMS.  The identifier can get it  from http://www.mob.com  when the application had approved)
     *  @param result            请求结果回调(Results of the request)
     */
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:self.userPhoneID.text zone:@"86" customIdentifier:nil result:^ (NSError *error) {
        
        // block回调
        if (error) {
            NSLog(@"验证码获取失败! %@", error);
        } else {
            NSLog(@"验证码获取成功");
        }
    }];
}

#pragma mark - 点击事件

/**
 *  通过账号密码登录
 */
-(void)didClickAccountButton {
  
    [UIView animateWithDuration:0.5 animations:^{
        [self.view endEditing:YES];
    } completion:^(BOOL finished) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
}

/**
 *  验证码请求button
 */
-(void)verificationCodeButtonClick {
    
    if (self.timerInterval != 0) {
        [SVProgressHUD showErrorWithStatus:@"已经发送!请耐心等耐!"];
        delay(1.5);
        return;
    }
    
    //1.判断是否正确的电话号码
    if (self.verifyPhone.hidden == YES) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的电话号码"];
        delay(1);
        return;
    }
    
    //先获取当前数据库的账号列表
    NSMutableArray *accountArr = [AVUserDefaultsTool objetForKey:localAccount];
    //遍历判断是否已是用户
    for (NSDictionary *dict in accountArr) {
        
        //判断当前手机 是不是账号
        
//        [UIButton buttonWithType:<#(UIButtonType)#>]
        
        if ([self.userPhoneID.text isEqualToString:dict[@"user"]]) {
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"已经是注册过的账号!" preferredStyle:UIAlertControllerStyleAlert];
            __weak typeof(self) weakself = self;
            UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                [weakself.navigationController popViewControllerAnimated:YES];
            }];
            
            [self.view endEditing:YES];
            [alertController addAction:confirmAction];
            [self presentViewController:alertController animated:YES completion:nil];
            return;
        }
    }
    NSLog(@"111");
    [SVProgressHUD showSuccessWithStatus:@"发送成功"];
    delay(1);
    //2.开启定时器
    [self addTimer];
    // 开启倒计时,60秒
    self.timerInterval = 60;
    [self changeCountDown];
    
    //3.获取验证码
    [self getCode];
}

/**
 *  监听textfield编辑完成
 */
-(void)endediting:(UITextField *)textField  {
    
    //验证手机号是否合法
    NSString *pattern = @"^((1[358]\\d)|(7[678])|(4[57]))\\d{8}$";
    NSString *phone = self.userPhoneID.text;
    NSString *result = [phone firstStringByRegularWithPattern:pattern];
    if (result == nil) {
        [self.userPhoneID setTextColor:[UIColor redColor]];
    }else {
        
        self.verifyPhone.hidden = NO;
    }
    
}
/**
 *  监听 textfield 编辑状态
 *
 *  @param textField textfield对象
 */
-(void)changedediting:(UITextField *)textField {
    
    NSString *pattern = @"^((1[358]\\d)|(7[678])|(4[57]))\\d{8}$";
    if ([self.userPhoneID.text firstStringByRegularWithPattern:pattern] != nil) {
        self.verifyPhone.hidden = NO;
    }else {
        
        [self.userPhoneID setTextColor:[UIColor grayColor]];
        self.verifyPhone.hidden = YES;
    }
    
}

/**
 *  登录按钮
 */
-(void)didClickLoginButton {

    // 提交验证码 验证
    [SMSSDK commitVerificationCode:self.verificationCodeTextField.text phoneNumber:self.userPhoneID.text zone:@"86" result:^ (NSError *error) {
        
        if (error) {
            [SVProgressHUD showErrorWithStatus:@"验证码不正确"];
            self.verificationCodeTextField.textColor = [UIColor redColor];
            delay(1);
        } else {
            //1.保存数据,密码默认123456

            NSMutableArray *arrMT = [[NSMutableArray alloc] init];
            NSArray *accountArr = [AVUserDefaultsTool objetForKey:localAccount];
            [arrMT addObjectsFromArray:accountArr];
            
            NSDictionary *userID = @{@"user":self.userPhoneID.text,@"password":@"123456"};
            [arrMT addObject:userID];
            [AVUserDefaultsTool saveObject:arrMT forKey:localAccount];
            
            //保存和赋值当前登录loginID
            [UserAccount sharedUserAccount].loginID = self.userPhoneID.text;
            [AVUserDefaultsTool saveObject:self.userPhoneID.text forKey:currentLoginID];
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"初始密码: 123456" message:@"请到个人设置里面修改登录密码" preferredStyle:UIAlertControllerStyleAlert];
            
            __weak typeof(self) weakself = self;
            UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [SVProgressHUD setDefaultStyle:SVProgressHUDStyleLight];
                [SVProgressHUD showWithStatus:@"加载中.."];
                
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    //通知controller登录 (登录成功)
                    [[NSNotificationCenter defaultCenter] postNotificationName:loginSuccessNotification object:nil userInfo:@{@"login":weakself}];
                    
                });
            }];
            [alertController addAction:confirmAction];
            [self presentViewController:alertController animated:YES completion:nil];
            
        }
    }];
}
/**
 *  注册账号
 */
-(void)didClickRegisterButton {
    [self.view endEditing:YES];
    //创建目标控制器
    YZRegisterController *registerController = [[YZRegisterController alloc] init];
    //push
    [self.navigationController pushViewController:registerController animated:YES];
}

/**
 *  跳转找回密码控制器
 */
-(void)didClickRetrievePasswordButton {
    [self.view endEditing:YES];
    //创建目标控制器
    YZRetrievePasswordController *retrievePasswordController = [[YZRetrievePasswordController alloc] init];
    [self.navigationController pushViewController:retrievePasswordController animated:YES];
}

/**
 *  QQ登录
 */
-(void)didClickQQbutton {
    
}

/**
 *  微博登录
 */
-(void)didClickWeibobutton {

    //创建目标控制器
    OAuthViewController *OAuthController = [[OAuthViewController alloc] init];
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:OAuthController];
    
    [self presentViewController:navigationController animated:YES completion:nil];
}

/**
 *  微信登录
 */
-(void)didClickWeixinbutton {
    
}

#pragma mark - 快速登录框 UIAlertController

-(void)fastLoginAction {
    
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    //移除定时器
    [self removeTimer];
    NSLog(@"验证码控制器登录销毁了");
}

@end
