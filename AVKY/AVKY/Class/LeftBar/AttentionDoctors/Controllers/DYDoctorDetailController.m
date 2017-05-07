//
//  DYDoctorDetailController.m
//  AVKY
//
//  Created by Yangdongwu on 16/8/5.
//  Copyright © 2016年 杰. All rights reserved.
//

#import "DYDoctorDetailController.h"
#import "DYDoctorMessageView.h"
#import "DYDoctorButtonsView.h"
#import "DYDoctor.h"
#import "YZNetworkTool+Attention.h"
#import <SobotKit/SobotKit.h>

@interface DYDoctorDetailController ()

/**
 *  医生信息view
 */
@property (nonatomic, strong) DYDoctorMessageView *doctorMessageView;
/**
 *  按钮的view
 */
@property (nonatomic, strong) DYDoctorButtonsView *buttonView;
/**
 *  收藏按钮
 */
@property (nonatomic, strong) UIButton *rightButton;
/**
 *  文字数组
 */
//@property (nonatomic, strong) NSDictionary *textDictionary;

@end

@implementation DYDoctorDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置UI
    [self setupUI];
    //设置NavBar
    [self setupNavigationBar];
 
}



#pragma mark - 设置UI
- (void)setupNavigationBar {
    self.navigationItem.title = @"医生详情";
    [self.rightButton addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)setupUI {
    self.view.backgroundColor = [UIColor whiteColor];
    
    //添加子控件
    [self.view addSubview:self.doctorMessageView];
    [self.view addSubview:self.buttonView];
    
    
    //设置子控件
    /**
     *  将值传给子零件
     */
    self.doctorMessageView.doctor = self.doctor;
    self.buttonView.pushFrom = self.pushFrom;
    
    __weak typeof(self) weakSelf = self;
    self.buttonView.patientBlock = ^ (UIViewController *controller) {
        [weakSelf.navigationController pushViewController:controller animated:YES];
    };
    
    self.buttonView.consultDoctorBlock = ^ {
    
        NSString *sysNumber = @"eb2a558fe4304db7a67014084422639c";
        
        ZCLibInitInfo *initInfo = [ZCLibInitInfo new];
        
        initInfo.enterpriseId = sysNumber;
        
        //用户id，用于标识用户，建议填写
        
        initInfo.userId=@"Your userId";
        
        initInfo.phone=@"Your phone";
        
        initInfo.nickName=@"Your nickName";
        
        initInfo.email=@"Your user email";
        
        ZCKitInfo *uiInfo=[ZCKitInfo new];
        
        uiInfo.info=initInfo;
        
        [ZCSobot startZCChatView:uiInfo with:weakSelf
                       pageBlock:^(ZCUIChatController *object, ZCPageBlockType type) {
                           //点击返回
                           
                           object.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:weakSelf action:@selector(cancelConsult)];
                           
                           if(type==ZCPageBlockGoBack){
                               NSLog(@"点击了关闭按钮");
                               
                               NSLog(@"object = %d, self = %d",object.navigationController.navigationBar.hidden,weakSelf.navigationController.navigationBar.hidden);
                               
                               object.navigationController.navigationBar.hidden = NO;
                               
                               weakSelf.navigationController.navigationBar.hidden = NO;
                               
                               
                           }
                           //页面UI初始化完成，可以获取UIView，自定义UI
                           if(type==ZCPageBlockLoadFinish){
                           }
                       } messageLinkClick:nil];
        
    };
    
    
    self.buttonView.backgroundColor = [UIColor whiteColor];
    
    //自动布局子控件
    [self.doctorMessageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_topLayoutGuide);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(115);
    }];
    
    
    [self.buttonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.doctorMessageView.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
    }];
}

#pragma mark - 点击事件

- (void)cancelConsult {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)rightButtonClick {
    
    
    NSString *url = @"";
    NSDictionary *parameters = [[NSDictionary alloc] init];
    
    if (self.rightButton.selected) {
        //关注医生接口
        url = @"http://iosapi.itcast.cn/doctor/addDoctor.json.php";
        parameters = @{@"user_id":@1000089,@"doctor_id":@300000315};
        [SVProgressHUD showWithStatus:@"正在关注..."];

    }
    else {
        //取消关注
        url = @"http://iosapi.itcast.cn/doctor/deleteDoctor.json.php";
        parameters = @{@"user_id":@1000089,@"doctor_id":@300000315};
        [SVProgressHUD showWithStatus:@"取消关注..."];
        
    }
    
    [[YZNetworkTool sharedManager] requestDoctorListWithUrl:url parameters:parameters callBack:^(id responseBody) {
        
        if ([responseBody isKindOfClass:[NSError class]]) {
            [SVProgressHUD showErrorWithStatus:@"您的网络不给力"];
            delay(0.5);
            return;
        }
        self.rightButton.selected = !self.rightButton.selected;
        [SVProgressHUD showSuccessWithStatus:@"完成操作"];
        delay(1.0);
        
    }];
    
}

#pragma mark - 内存警告
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - 懒加载
- (DYDoctorMessageView *)doctorMessageView {
    if (_doctorMessageView == nil) {
        _doctorMessageView = [[DYDoctorMessageView alloc] init];
    }
    return _doctorMessageView;
}

- (UIButton *)rightButton {
    if (_rightButton == nil) {
        _rightButton = [[UIButton alloc] init];
        [_rightButton setImage:[UIImage imageNamed:@"collection_off"] forState:UIControlStateNormal];
        [_rightButton setImage:[UIImage imageNamed:@"collection_on"] forState:UIControlStateSelected];
        _rightButton.frame = CGRectMake(0, 0, 30, 30);
    }
    return _rightButton;
}

- (DYDoctorButtonsView *)buttonView {
    if (_buttonView == nil) {
        _buttonView = [[DYDoctorButtonsView alloc] init];
    }
    return _buttonView;
}

//- (NSDictionary *)textDictionary {
//    if (_textDictionary == nil) {
//        _textDictionary = [[NSDictionary alloc] init];
//    }
//    return _textDictionary;
//}

@end
