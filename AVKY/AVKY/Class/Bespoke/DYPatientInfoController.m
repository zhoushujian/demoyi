//
//  DYSickCallController.m
//  AVKY
//
//  Created by Yangdongwu on 16/8/8.
//  Copyright © 2016年 杰. All rights reserved.
//

#import "DYPatientInfoController.h"
#import "DYSickCallController.h"
#import "DYDoctorDetailController.h"
#import "HMPictureMoveController.h"

#define sickViewHeight 472
#define yuYueButtonHeight 40
#define margin 10
//#define addPhotoHeight 400

@interface DYPatientInfoController ()
/**
 *  scrollView,实现主页面可以滚动
 */
@property (nonatomic, strong) UIScrollView *scrollView;
/**
 *  预约view
 */
@property (nonatomic, strong) UIView *sickCallView;
/**
 *  添加图片的view
 */
@property (nonatomic, strong) UIView *addPhotoView;
/**
 *  预约按钮
 */
@property (nonatomic, strong) UIButton *sickCallButton;
/**
 *  pictureViewController的view
 */
@property (nonatomic, strong) UIView *pictureView;
/**
 *  用来存储返回的高度的
 */
@property (nonatomic, assign) CGFloat height;
/**
 *  添加一个覆盖view用来,挡住下面图片添加按钮漏在外面的问题
 */
@property (nonatomic, strong) UIView *coverView;

@end

@implementation DYPatientInfoController

- (void)viewDidLoad {

    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"预约";
    
    [self setupUI];
    //待优化
    self.height = (screenW - 20 * (3 + 1)) / 3 + 40;
    
    
}


- (void)setupUI {

    [self.view addSubview:self.scrollView];
    
    //================== 加载storyboard的控制器view =================//
    UIStoryboard *paintInfo = [UIStoryboard storyboardWithName:@"DYPaintInfo" bundle:[NSBundle mainBundle]];
    
    DYSickCallController *sickCallController = paintInfo.instantiateInitialViewController;
    
    [self addChildViewController:sickCallController];
    
    [self.scrollView addSubview:sickCallController.view];
    
    self.sickCallView = sickCallController.view;
    
    //================== 加载添加图片的view =================//
    
    [self.scrollView addSubview:self.addPhotoView];
    
    HMPictureMoveController *pictureViewController = [[HMPictureMoveController alloc] init];
    
    pictureViewController.completeBlock = ^ (CGFloat height) {
        
        self.height = height;
        
        self.addPhotoView.frame = CGRectMake(0, sickViewHeight, screenW, height);
        
        self.scrollView.contentSize = CGSizeMake(0, sickViewHeight + self.height + yuYueButtonHeight + 2 * margin);
        
        self.pictureView.frame = self.addPhotoView.bounds;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.scrollView setContentOffset:CGPointMake(0, self.scrollView.contentSize.height - self.scrollView.bounds.size.height) animated:YES];
        });
        
    };
    
    [self addChildViewController:pictureViewController];
    
    [self.addPhotoView addSubview:pictureViewController.view];
    
    self.addPhotoView.frame = CGRectMake(0, sickViewHeight, screenW, 100);

    self.pictureView = pictureViewController.view;
    
    //================== 添加一个遮挡层 =================//
    [self.view addSubview:self.coverView];
    
    [self.coverView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view).offset(0);
        make.height.mas_equalTo(yuYueButtonHeight + 2 * margin);
    }];
    
    //================== 添加一个按钮 =================//
    [self.view addSubview:self.sickCallButton];
    
    //自动布局
    [self.sickCallButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(margin);
        make.right.equalTo(self.view).offset(-margin);
        make.bottom.equalTo(self.view).offset(-margin);
        make.height.mas_equalTo(yuYueButtonHeight);
    }];


   
    
    
    
    
}


- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.scrollView.frame = self.view.bounds;
    self.sickCallView.frame = CGRectMake(0, 0, screenW, sickViewHeight);
    self.pictureView.frame = self.addPhotoView.bounds;
    self.scrollView.contentSize = CGSizeMake(0, sickViewHeight + self.height + yuYueButtonHeight + 2 * margin);
    
}

#pragma mark - 点击事件
- (void)sickCallButtonClick:(UIButton *)sickCallButton {
    
    [SVProgressHUD showWithStatus:@"正在预约中..."];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [SVProgressHUD showSuccessWithStatus:@"预约成功"];
        
        delay(2);
        
        self.patientInfoBlock();
        
        [self.navigationController popViewControllerAnimated:YES];
        
    });
    
}

#pragma mark - 懒加载
- (UIScrollView *)scrollView {
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        
    }
    return _scrollView;
}

- (UIView *)addPhotoView {
    if (_addPhotoView == nil) {
        _addPhotoView = [[UIView alloc] init];
    }
    return _addPhotoView;
}

- (UIButton *)sickCallButton {
    if (_sickCallButton == nil) {
        _sickCallButton = [[UIButton alloc] init];
        [_sickCallButton setBackgroundImage:[UIImage imageNamed:@"buttonBackground2"] forState:UIControlStateNormal];
        [_sickCallButton setTitle:@"预约" forState:UIControlStateNormal];
        [_sickCallButton addTarget:self action:@selector(sickCallButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sickCallButton;
}

- (UIView *)coverView {
    if (_coverView == nil) {
        _coverView = [[UIView alloc] init];
        _coverView.backgroundColor = [UIColor whiteColor];
    }
    return _coverView;
}

@end
