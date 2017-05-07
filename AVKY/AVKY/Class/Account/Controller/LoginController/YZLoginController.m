//
//  YZLoginController.m
//  AVKY
//
// 

#import "YZLoginController.h"
#import "YZRegisterController.h"
#import "YZRetrievePasswordController.h"
#import "OAuthViewController.h"
#import "YZVerificationCodeController.h"


@interface YZLoginController ()
/**
 *  账号
 */
@property (nonatomic, weak) UITextField *userPhoneID;
/**
 *  密码
 */
@property (nonatomic, weak) UITextField *password;
@end

@implementation YZLoginController


#pragma mark - viewDidLoad 方法
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"登录";
    
    //设置导航左边item
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(didClickCancelButton)];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    
    [self setupViewBackGround];
    //设置UI
    [self setupUI];
    
    //设置 提示效果
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
    [SVProgressHUD setBackgroundColor:globalColor];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    
    //添加键盘将要显示的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChanged:) name:UIKeyboardWillChangeFrameNotification object:nil];
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
    userPhoneID.placeholder = @"请输入您的手机号码";
    userPhoneID.borderStyle = UITextBorderStyleRoundedRect;
    userPhoneID.font = FONT(14);
    //设置数字键盘输入框
    userPhoneID.keyboardType = UIKeyboardTypePhonePad;
    userPhoneID.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    // 登录密码
    UITextField *password = [[UITextField alloc] init];
    [self.view addSubview:password];
    self.password = password;
    [UITextField setTextFieldLeftImage:password image:@"numberDetails"];
    password.placeholder = @"请输入您的密码";
    password.borderStyle = UITextBorderStyleRoundedRect;
    password.font = FONT(14);
    password.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    // 验证码登录
    UIButton *verificationCodeLogin = [[UIButton alloc] init];
    [verificationCodeLogin setTitle:@"通过短信验证码登录" forState:UIControlStateNormal];
    [verificationCodeLogin setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.view addSubview:verificationCodeLogin];
    verificationCodeLogin.titleLabel.font = FONT(14);
    //添加点击事件
    [verificationCodeLogin addTarget:self action:@selector(didClickVerificationCodeButton) forControlEvents:UIControlEventTouchUpInside];
    
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
    
    /************************ 2.布局子控件 ****************************/
    CGFloat topMargin;
    if (is4inch) {
        topMargin = 30;
    } else if(is47inch){
        topMargin = 40;
    } else if (is55inch){
        topMargin = 40;
    }
    
    
    [userPhoneID mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(200);
        make.left.mas_equalTo(self.view).offset(30);
        make.right.mas_equalTo(self.view).offset(-30);
    }];
    
    [password mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(userPhoneID.mas_bottom).offset(20);
        make.left.right.mas_equalTo(userPhoneID);
        //make.right.mas_equalTo(phoneTextField.mas_right);
    }];
    
    [verificationCodeLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(password.mas_bottom).offset(topMargin);
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
        make.top.mas_equalTo(loginButton.mas_bottom).offset(topMargin);
        make.right.mas_equalTo(lineView).offset(-30);
        make.height.mas_equalTo(20);
    }];
    
    [retrievePassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(loginButton.mas_bottom).offset(topMargin);
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


#pragma mark - 响应事件

-(void)didClickCancelButton {
    
    [UIView animateWithDuration:0.5 animations:^{
        [self.view endEditing:YES];
    } completion:^(BOOL finished) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

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
    
    //    NSLog(@"%@",notification);
    //获得键盘弹出后（缩回后）的frame
    CGRect endKeyboard = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    //用当前界面的总高度 - 键盘弹出后(缩回后)的y值，就可以得到要滚动的值了
    CGFloat offsetY = endKeyboard.origin.y - self.view.bounds.size.height;
    if (offsetY != 0) {
        offsetY += 135;
    }
    
    //取出键盘的动画时间
    CGFloat animaDuration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    //让界面往上面滚动
    [UIView animateWithDuration:animaDuration animations:^{
        
        //让整个View滚动
        self.view.transform = CGAffineTransformMakeTranslation(0, offsetY);
    }];
}

/**
 *  通过短信验证码快速登录
 */
-(void)didClickVerificationCodeButton {
    [self.view endEditing:YES];
    
    //创建目标控制器
    YZVerificationCodeController *verificationCodeController = [[YZVerificationCodeController alloc] init];
    [self.navigationController pushViewController:verificationCodeController animated:YES];
    
}


/**
 *  登录按钮
 */
-(void)didClickLoginButton {
    
    
    //1,获取到数据库账号和密码
    NSMutableArray *accountArr = [AVUserDefaultsTool objetForKey:localAccount];
    
    //2,遍历用户数组 匹配账号登录
    for (NSDictionary *dict in accountArr) {
        
        NSString *userID = dict[@"user"];
        NSString *password = dict[@"password"];
        
        if ([userID isEqualToString:self.userPhoneID.text] && [password isEqualToString:self.password.text]) {
            
            //保存和赋值当前登录loginID
            [UserAccount sharedUserAccount].loginID = userID;
            [AVUserDefaultsTool saveObject:userID forKey:currentLoginID];
            
            [SVProgressHUD setDefaultStyle:SVProgressHUDStyleLight];
            [SVProgressHUD showWithStatus:@"加载中.."];
            //通知controller登录 (登录成功)
            //延迟 提示效果
            __weak typeof(self) weakself = self;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
                [[NSNotificationCenter defaultCenter] postNotificationName:loginSuccessNotification object:nil userInfo:@{@"login":weakself}];
            });
            return;
        }
    }
    
    [SVProgressHUD showErrorWithStatus:@"账号密码错误"];
    delay(1.5);

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

@end
