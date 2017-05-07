//
//  YZRegisterController.m
//  AVKY
//
//  Created by EZ on 16/8/4.
//  Copyright © 2016年 杰. All rights reserved.
// 15113339265

#import "YZRegisterController.h"



@interface YZRegisterController ()
//电话框
@property (nonatomic, weak) UITextField *phoneTextField;
//验证码框
@property (nonatomic, weak) UITextField *verificationCodeTextField;
//输入密码框
@property (nonatomic, weak) UITextField *psdTextField;
//验证码 Button
@property (nonatomic, weak) UIButton *verificationCodeButton;
//电话号码验证成功提示符
@property (nonatomic, weak) UIImageView *verifyPhone;
//密码验证成功提示符
@property (nonatomic, weak) UIImageView *verifyPassword;
//协议button
@property (nonatomic, weak) UIButton *circleButton;


//下一步(注册按钮)
@property (nonatomic, weak) UIButton *nextButton;


/**
 *  定时器
 */
@property (nonatomic, strong) NSTimer *timer;
/**
 *  定时器时间
 */
@property (nonatomic, assign) NSInteger timerInterval;


@end

@implementation YZRegisterController

#pragma mark - viewDidLoad 方法
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    self.view.backgroundColor = [UIColor whiteColor];
    
    //设置导航左边item
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(didClickLeftButtonItem)];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    //设置 提示效果
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
    
    [self setupViewBackGround];
    //设置UI
    [self setupUI];
    
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
- (void)setupUI {
    
    //1.添加子控件
    // 手机框
    UITextField *phoneTextField = [[UITextField alloc] init];
    [self.view addSubview:phoneTextField];
    self.phoneTextField = phoneTextField;
    [UITextField setTextFieldLeftImage:phoneTextField image:@"numberDetails"];
    phoneTextField.placeholder = @"请输入您的手机号码";
    phoneTextField.borderStyle = UITextBorderStyleRoundedRect;
    phoneTextField.font = FONT(14);
    //监听编辑完成的状态
    [phoneTextField addTarget:self action:@selector(endediting:) forControlEvents:UIControlEventEditingDidEnd];
    //开始监听编辑的状态
    [phoneTextField addTarget:self action:@selector(changedediting:) forControlEvents:UIControlEventEditingChanged];
    //设置数字键盘输入框
    phoneTextField.keyboardType = UIKeyboardTypePhonePad;
    phoneTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
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
    
    // 密码框
    UITextField *psdTextField = [[UITextField alloc] init];
    [self.view addSubview:psdTextField];
    self.psdTextField = psdTextField;
    [UITextField setTextFieldLeftImage:psdTextField image:@"numberDetails"];
    psdTextField.placeholder = @"请输入密码";
    psdTextField.borderStyle = UITextBorderStyleRoundedRect;
    psdTextField.font = FONT(14);
    //监听编辑完成的状态
    [psdTextField addTarget:self action:@selector(endediting:) forControlEvents:UIControlEventEditingDidEnd];
    //开始监听编辑的状态
    [psdTextField addTarget:self action:@selector(changedediting:) forControlEvents:UIControlEventEditingChanged];
    //设置键盘外观
    psdTextField.keyboardAppearance = UIKeyboardAppearanceAlert;
    psdTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    
    //illness_rb_img_nor.png
    //协议圆圈
    UIButton *circleButton = [[UIButton alloc] init];
    [self.view addSubview:circleButton];
    self.circleButton = circleButton;
    [circleButton setImage:[UIImage imageNamed:@"illness_rb_img_nor.png"] forState:UIControlStateNormal];
    [circleButton setImage:[UIImage imageNamed:@"illness_rb_img_sel.png"] forState:UIControlStateSelected];
    //添加点击事件
    [circleButton addTarget:self action:@selector(changedCircleButtonState) forControlEvents:UIControlEventTouchUpInside];
    
    //协议label
    UILabel *label = [[UILabel alloc] init];
    [self.view addSubview:label];
    label.text = @"本人已同意并阅读";
    label.font = FONT(14);
    
    //用户协议button
    UIButton *agreementButton = [[UIButton alloc] init];
    [agreementButton setTitle:@"用户协议" forState:UIControlStateNormal];
    [agreementButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.view addSubview:agreementButton];
    agreementButton.titleLabel.font = FONT(14);
    
    //下一步
    UIButton *nextButton = [[UIButton alloc]init];
    [self.view addSubview:nextButton];
    self.nextButton = nextButton;
    [nextButton setTitle:@"下一步" forState:UIControlStateNormal];
    [nextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [nextButton setBackgroundImage:[UIImage imageNamed:@"buttonBackground"] forState:UIControlStateNormal];
    //文字居中
    nextButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    //添加点击事件
    [nextButton addTarget:self action:@selector(didClickNextButton) forControlEvents:UIControlEventTouchUpInside];
    
    //验证手机号码
    UIImageView *verifyPhone = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_right"]];
    [self.view addSubview:verifyPhone];
    verifyPhone.hidden = YES;
    self.verifyPhone = verifyPhone;
    
    
    //验证密码合法性
    UIImageView *verifyPassword = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_right"]];
    [self.view addSubview:verifyPassword];
    verifyPassword.hidden = YES;
    self.verifyPassword = verifyPassword;
    
    //2.布局子控制器
    //左右间距
    //上下间距
    CGFloat topMargin = 20;
    CGFloat leftMargin;
    CGFloat margin;
    if (is4inch) {
        margin = 30;
        leftMargin = 50;
    } else if(is47inch) {
        margin = 40;
        leftMargin = 75;
    } else if (is55inch) {
        margin = 40;
        leftMargin = 75;
    }
    
    [phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(margin);
        make.right.mas_equalTo(self.view).offset(-margin);
        make.top.mas_equalTo(self.view.mas_top).offset(200);
    }];
    
    //电话验证提示
    [verifyPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(phoneTextField).offset(5);
        make.left.mas_equalTo(phoneTextField.mas_right).offset(5);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    [verificationCodeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(margin);
        make.top.mas_equalTo(phoneTextField.mas_bottom).offset(topMargin);
        make.right.mas_equalTo(self.view).offset(-170);
    }];
    
    [verificationCodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view).offset(-margin);
        make.top.mas_equalTo(phoneTextField.mas_bottom).offset(topMargin);
        make.width.mas_equalTo(90);
        make.height.mas_equalTo(30);
    }];
    
    [psdTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(margin);
        make.right.mas_equalTo(self.view).offset(-margin);
        make.top.mas_equalTo(verificationCodeTextField.mas_bottom).offset(topMargin);
    }];
    
    //密码验证成功提示
    [verifyPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(psdTextField).offset(5);
        make.left.mas_equalTo(psdTextField.mas_right).offset(5);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    [circleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(23, 23));
        make.left.mas_equalTo(self.view).offset(leftMargin);
        make.top.mas_equalTo(psdTextField.mas_bottom).offset(37);
    }];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(psdTextField.mas_bottom).offset(40);
        make.left.mas_equalTo(circleButton.mas_right).offset(15);
    }];
    
    [agreementButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(psdTextField.mas_bottom).offset(39);
        make.right.mas_equalTo(self.view).offset(-leftMargin);
        make.height.mas_equalTo(20);
    }];
    
    [nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label.mas_bottom).offset(40);
        make.left.mas_equalTo(self.view).offset(margin);
        make.right.mas_equalTo(self.view).offset(-margin);
        make.height.mas_equalTo(30);
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
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:self.phoneTextField.text zone:@"86" customIdentifier:nil result:^ (NSError *error) {
        
        // block回调
        if (error) {
            NSLog(@"验证码获取失败! %@", error);
        } else {
            NSLog(@"验证码获取成功");
        }
    }];
}

#pragma mark - 点击事件

-(void)didClickLeftButtonItem {
    [UIView animateWithDuration:0.25 animations:^{
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
        offsetY += 170;
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
 *  监听textfield编辑完成
 */
-(void)endediting:(UITextField *)textField  {
 
    //判断是否电话框
    if ([textField isEqual:self.phoneTextField]){
       
        //验证手机号是否合法
        NSString *pattern = @"^((1[358]\\d)|(7[678])|(4[57]))\\d{8}$";
        NSString *phone = self.phoneTextField.text;
        NSString *result = [phone firstStringByRegularWithPattern:pattern];
        if (result == nil) {
            [self.phoneTextField setTextColor:[UIColor redColor]];
        }else {
            
            self.verifyPhone.hidden = NO;
        }
    }
    //判断是否密码框
    else if ([textField isEqual:self.psdTextField]) {
        
        //验证密码是否合法
        NSString *pattern = @"^[a-zA-Z0-9]{6,20}+$";
        NSString *result = [self.psdTextField.text firstStringByRegularWithPattern:pattern];
        if (result == nil) {
            [self.psdTextField setTextColor:[UIColor redColor]];
        }else {
            
            self.verifyPassword.hidden = NO;
        }
    }
}
/**
 *  监听 textfield 编辑状态
 *
 *  @param textField textfield对象
 */
-(void)changedediting:(UITextField *)textField {
    
    //判断是否电话框
    if ([textField isEqual:self.phoneTextField]){
        NSString *pattern = @"^((1[358]\\d)|(7[678])|(4[57]))\\d{8}$";
        if ([self.phoneTextField.text firstStringByRegularWithPattern:pattern] != nil) {
            self.verifyPhone.hidden = NO;
        }else {
            
            [self.phoneTextField setTextColor:[UIColor grayColor]];
            self.verifyPhone.hidden = YES;
        }
    }
    //判断是否密码框
    else if ([textField isEqual:self.psdTextField]) {
        
        NSString *pattern = @"^[a-zA-Z0-9]{6,20}+$";
        if ([self.psdTextField.text firstStringByRegularWithPattern:pattern] != nil) {
            self.verifyPassword.hidden = NO;
        }else {
            
            [self.psdTextField setTextColor:[UIColor grayColor]];
            self.verifyPassword.hidden = YES;
        }
    }
}

/**
 *  改变button状态
 */
-(void)changedCircleButtonState {
    self.circleButton.selected = !self.circleButton.selected;
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
 *  下一步 (注册)
 */
-(void)didClickNextButton {
    //1.判断是否同意协议
    if (self.circleButton.selected == NO) {
        [SVProgressHUD showErrorWithStatus:@"请同意用户协议"];
        delay(1);
        return;
    }
    
    //2.判断密码
    if (self.verifyPassword.hidden == YES) {
        [SVProgressHUD showErrorWithStatus:@"请输入密码"];
        delay(1);
        return;
    }
        //3.判断验证码是否成功
    /**
     * @from               v1.1.1
     * @brief              提交验证码(Commit the verification code)
     *
     * @param code         验证码(Verification code)
     * @param phoneNumber  电话号码(The phone number)
     * @param zone         区域号，不要加"+"号(Area code)
     * @param result       请求结果回调(Results of the request)
     */
    [SMSSDK commitVerificationCode:self.verificationCodeTextField.text phoneNumber:self.phoneTextField.text zone:@"86" result:^ (NSError *error) {

        if (error) {
            [SVProgressHUD showErrorWithStatus:@"验证码不正确"];
            self.verificationCodeTextField.textColor = [UIColor redColor];
            delay(1);
        } else {
            //验证成功
            [SVProgressHUD showSuccessWithStatus:@"发送成功"];
            delay(1);
    
            //4.保存数据到偏好设置
            
            NSMutableArray *accountInfo = [[NSMutableArray alloc] init];
            NSDictionary *accountDict = @{@"user":self.phoneTextField.text, @"password":self.psdTextField.text};
            [accountInfo addObject:accountDict];
            [AVUserDefaultsTool saveObject:accountInfo forKey:localAccount];
            
            //5,sismiss当前页面
 
            [self.view endEditing:YES];
            [self.navigationController popViewControllerAnimated:YES];

        }
    }];
    
}

#pragma mark - dealloc方法
-(void)dealloc {
    //移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    //移除定时器
    [self removeTimer];
}

@end
