//
//  DiagnosisController.m
//  AVKY
//
//  Created by 杰 on 16/8/3.
//  Copyright © 2016年 杰. All rights reserved.
//

#import "DiagnosisController.h"
#import <Masonry/Masonry.h>
#import "CityWeatherView.h" //城市天气时间
#import "LoopView.h"  //轮播器
#import "DoctorsView.h" //名医通
#import "LoopText.h"
#import "TLCityPickerController.h"
#import "WelfareViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "Reachability.h"
#import "CYXLayoutViewController.h"
/**
 *  名医通6个按钮对应的controller
 */
#import "DoctorsView.h"
#import "ZYbaseController.h"

//判断当前版本是不是iPhone5/iPhone5S
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

@interface DiagnosisController ()<famosDocButtonDelegete,CityWeatherDelegate,TLCityPickerDelegate,CLLocationManagerDelegate,UITabBarControllerDelegate>

@property(nonatomic,strong)CityWeatherView *cityWeatherView;
/**
 *  轮播器
 */
@property(nonatomic,strong)LoopView *loopView;
/**
 *  名医一点通九宫格
 */
@property(nonatomic,strong)DoctorsView *doctView;
/**
 *  跑马灯栏
 */
@property(nonatomic,strong)LoopText *loopText;

@property (nonatomic, strong) NSMutableArray *controllers;

///  定位单例
@property (nonatomic, strong) CLLocationManager *locationManager;
///  当前城市
@property (nonatomic, strong) NSString *currentCity;

//获取当前网络状态类
@property (nonatomic, strong) Reachability *conn;
@property (nonatomic, strong)  CLGeocoder *geocoder;

@property(nonatomic,strong)UIView *bgView;

//获取当前网络状态
-(NSString *)stringFromStatus:(NetworkStatus)status;

@end

@implementation DiagnosisController



- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    self.doctView.delegate = self;
    self.cityWeatherView.delegate = self;
    [self setUI];
    [self setNet];
    
    __weak typeof(self) weakSelf =  self;
    self.loopView.myBlock = ^{
        
        
        [weakSelf.navigationController pushViewController:[[CYXLayoutViewController alloc]init] animated:YES];
    };
}

/**
 *  实现按钮点击的代理事件
 */
-(void)viewWillAppear:(BOOL)animated{
    
    
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    bgView.clipsToBounds = YES;
    self.bgView  = bgView;
    [self.view addSubview:bgView];
    [[UIApplication sharedApplication] setStatusBarHidden:TRUE];
    //国际化
    NSString *loopText = NSLocalizedString(@"loopText", nil);
    UILabel *runLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 150, 25)];
    runLabel.text = loopText;
    runLabel.textColor = [UIColor orangeColor];
    [bgView addSubview:runLabel];
    [runLabel sizeToFit];
    
    CGRect frame = runLabel.frame;
    frame.origin.x = bgView.frame.size.width;
    runLabel.frame = frame;
    [UIView beginAnimations:nil context:NULL];
    //动画时间（参数需要按需调整）
    [UIView setAnimationDuration:frame.size.width/20.0f];
    //无限重复
    [UIView setAnimationRepeatCount:CGFLOAT_MAX];
    //匀速执行
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    //返回效果
    [UIView setAnimationRepeatAutoreverses:NO];
    frame.origin.x = -frame.size.width;
    runLabel.frame = frame;
    
    [UIView commitAnimations];


}
-(void)buttonClickWith:(NSInteger)index{
//    "tumour" = "tumour";//肿瘤
//    "Hematology" = "Hematology";//血液科
//    "Cardiovascular" = "Cardiovascular";//心血管
//    "NerveSection" = "NerveSection";//神经科
//    "Orthopaedics" = "Orthopaedics";//骨科
//    "Commonweal" = "Commonweal";//公益活动
    NSString *tumour = NSLocalizedString(@"tumour", nil);//肿瘤
    NSString *Hematology = NSLocalizedString(@"Hematology", nil);//血液科
    NSString *Cardiovascular = NSLocalizedString(@"Cardiovascular", nil);//心血管
    NSString *NerveSection = NSLocalizedString(@"NerveSection", nil);//神经科
    NSString *Orthopaedics = NSLocalizedString(@"Orthopaedics", nil);//骨科
    NSString *Commonweal = NSLocalizedString(@"Commonweal", nil);//公益活动
    
    NSArray * titleArr = @[tumour,Hematology,Cardiovascular,NerveSection,Orthopaedics,Commonweal];
    ZYbaseController *bvc = [[ZYbaseController alloc]init];
    
    bvc.title = titleArr[index];
    //"Return" = "Return";//返回
    NSString *Return = NSLocalizedString(@"Return", nil);
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:Return style:UIBarButtonItemStyleDone target:nil action:nil];
    
    if (index == 5) {
        WelfareViewController *welfare = [[WelfareViewController alloc]init];
        welfare.title = Commonweal;
        //这里跳转公益活动页面
        [self.navigationController pushViewController:welfare animated:YES];
        
    }else{
    
        [self.navigationController pushViewController:bvc animated:YES];
    }
    
    
}


///  点击城市按钮跳转到城市列表界面
///
///  @param button 城市按钮
#pragma mark -点击城市按钮跳转到城市列表界面
-(void)pushToCityControllerWith:(UIButton *)button block:(void (^)(NSString *, NSString *, NSString *, NSString *))weatherblock{
    TLCityPickerController *cityPickerVC = [[TLCityPickerController alloc] init];
    
    cityPickerVC.weatherBlock = weatherblock;
    
    [cityPickerVC setDelegate:self];
    
    cityPickerVC.locationCityID = self.currentCity;
   
    cityPickerVC.hotCitys = @[@"100010000", @"200010000", @"300210000", @"600010000", @"300110000"];
    
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:cityPickerVC] animated:YES completion:nil];
}


#pragma mark - 设置UI
-(void)setUI{
  
    [self.view addSubview:self.cityWeatherView];
    [self.view addSubview:self.loopView];
    [self.view addSubview:self.doctView];
    [self.view addSubview:self.loopText];
    
}


-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    CGFloat InteractiveViewHeight = [UIScreen mainScreen].bounds.size.height - 64 - 49;
    
    
    //布局城市天气View
    [self.cityWeatherView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_topLayoutGuide);
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(InteractiveViewHeight/2*0.25);
    }];
    
    //轮播器
    [self.loopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.cityWeatherView.mas_bottom);
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(InteractiveViewHeight/2*0.75);
    }];
    //跑马灯--名医一点通
    [self.loopText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view);
        make.width.mas_equalTo(self.view).multipliedBy(0.4);
        make.height.mas_equalTo(30);
        make.top.mas_equalTo(self.loopView.mas_bottom);
    }];
    //跑马灯
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.loopView.mas_bottom).offset(5);
        make.width.mas_equalTo(self.view).multipliedBy(0.58);
        make.height.mas_equalTo(20);
        
        
    }];
    
    //九宫格名医一点通
    [self.doctView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.loopText.mas_bottom);
        make.left.right.mas_equalTo(self.view);
//        make.bottom.mas_equalTo(self.mas_bottomLayoutGuide);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-44);
    }];
    

}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
        //在这里设置启动动画p跑马灯，就不会再TabBarController切换控制器死掉
        [UIView commitAnimations];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TLCityPickerDelegate
- (void) cityPickerController:(TLCityPickerController *)cityPickerViewController didSelectCity:(TLCityModel *)city
{
    [self.cityWeatherView.locationBtn setTitle:city.cityName forState:UIControlStateNormal];
    [cityPickerViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void) cityPickerControllerDidCancel:(TLCityPickerController *)cityPickerViewController
{
    [cityPickerViewController dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark -控件懒加载
-(CityWeatherView *)cityWeatherView{
    if (!_cityWeatherView) {
        _cityWeatherView = [[CityWeatherView alloc]initWithFrame:CGRectZero];
    }
    return _cityWeatherView;
}

-(LoopView *)loopView{
    if (!_loopView) {
        _loopView = [[LoopView alloc]initWithFrame:CGRectZero];
        
    }
    return _loopView;
}

-(DoctorsView *)doctView{
    if (!_doctView) {
        _doctView = [[DoctorsView alloc]initWithFrame:CGRectZero];
    }
    return _doctView;
}

-(LoopText *)loopText{
    if (!_loopText) {
        _loopText = [[LoopText alloc]initWithFrame:CGRectZero];
    }
    return _loopText;
}

- (CLLocationManager *)locationManager {
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc]init];
        _locationManager.delegate = self;
        //        _locationManager.allowsBackgroundLocationUpdates = YES;
    }
    return _locationManager;
}

-(void)setNet{
    Reachability *reach = [Reachability reachabilityForInternetConnection];
    NetworkStatus status = [reach currentReachabilityStatus];
    [SVProgressHUD show];
    [SVProgressHUD showSuccessWithStatus:[self stringFromStatus:status]];

    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];

    delay(1.5);

}

#pragma mark -返回网络状态
-(NSString *)stringFromStatus:(NetworkStatus)status{
    
    NSString *string;
    switch (status) {
        case NotReachable:
            string = @"当前处于无网络状态!";
            break;
        case ReachableViaWiFi:
            string = @"当前处于WIFI状态下!";
            break;
        case ReachableViaWWAN:
            string = @"当前处于蜂窝移动网络!";
            break;
        default:
            string = @"有钱人!";
            break;
    }
    return  string;
}

-(UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
    }
    return _bgView;
}




@end
