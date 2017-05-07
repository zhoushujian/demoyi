//
//  KYTabarController.m
//  AVKY
//
//  Created by 杰 on 16/8/3.
//  Copyright © 2016年 杰. All rights reserved.


#import "KYTabarController.h"
#import "BodybuildingController.h"
#import "DiagnosisController.h"
#import "FindViewController.h"
#import "KYNavigationController.h"
#import <CoreLocation/CoreLocation.h>
#import "CityWeatherView.h"

@interface KYTabarController ()<CLLocationManagerDelegate>
///  定位单例
@property (nonatomic, strong) CLLocationManager *locationManager;
///  当前城市
@property (nonatomic, strong) NSString *currentCity;

@end

@implementation KYTabarController

- (void)viewDidLoad {
    [super viewDidLoad];
//    if ([CLLocationManager locationServicesEnabled] == NO) {
//        
//        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"定位" message:@"请在设置中开启定位服务" preferredStyle:UIAlertControllerStyleAlert];
//        [self presentViewController:alertController animated:YES completion:nil];
//        return;
//    }
//    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
//    if (kCLAuthorizationStatusNotDetermined == status) {
//        ///  请求定位授权
//        [self.locationManager requestWhenInUseAuthorization];
//    }
//  
//    ///  开启定位
//    [self.locationManager startUpdatingLocation];
   
//    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blueColor], nil] forState:UIControlStateNormal];
    
   // [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionarydictionaryWithObjectsAndKeys:[UIColor whiteColor], UITextAttributeTextColor, nil] forState:UIControlStateNormal];
    
    //设置遮罩属性
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setBackgroundColor:globalColor];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    

    
}

-(instancetype)init{
    if (self = [super init]) {
       
        [self setController];
    
    }
    return self;
    
}

//#pragma mark - CLLocationManagerDelegate {
//- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
//    [self.locationManager stopUpdatingLocation];
//    CLLocation *currentLocation = [locations lastObject];
//    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
//    
//    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
//        if (placemarks.count > 0) {
//            CLPlacemark *placeMark = placemarks[0];
//            self.currentCity = [[NSString alloc]init];
//            self.currentCity = placeMark.locality;
//            if (!_currentCity) {
//                self.currentCity = @"无法定位到当前城市";
//            }else if (_currentCity) {
//                CityWeatherView *cityWeatherView = [[CityWeatherView alloc]init];
//                cityWeatherView.locationBtn.titleLabel.text = self.currentCity;
//            }
//        
//        }
//    }];
//}


-(void)setController {
    
    NSString *home  = NSLocalizedString(@"home", nil);
//    NSString *home = nil;
    NSString *find = NSLocalizedString(@"find", nil);
    NSString *Sports = NSLocalizedString(@"Sports", nil);
    //就诊
    DiagnosisController *DiagnosisVC = [[DiagnosisController alloc]init];

    [self addChildViewController:DiagnosisVC titles:home images:@"tab_normal_1"];
    [self setBarItem:DiagnosisVC];
    
    
    
    //发现
    FindViewController *findVC  = [[FindViewController alloc]init];
    [self addChildViewController:findVC titles:find images:@"tab_normal_2"];
    [self setBarItem:findVC];
    
    BodybuildingController *BodybuildingVc = [[BodybuildingController alloc]init];
    [self addChildViewController:BodybuildingVc titles:Sports images:@"tab_normal_3"];
    [self setBarItem:BodybuildingVc];
}

-(void)setBarItem:(UIViewController *)viewController{
    
    UIButton *LeftItem = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
    [LeftItem setBackgroundImage:[UIImage imageNamed:@"menusnew"] forState:UIControlStateNormal];


    viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:LeftItem];
    [LeftItem addTarget:self action:@selector(LeftItemClick) forControlEvents:UIControlEventTouchUpInside];
    
}

#pragma mark - navigationBarItem点击事件
-(void)LeftItemClick{
   [self.drawer open];
}
- (void)drawerControllerWillOpen:(ICSDrawerController *)drawerController
{
    self.view.userInteractionEnabled = NO;
}

- (void)drawerControllerDidClose:(ICSDrawerController *)drawerController
{
    self.view.userInteractionEnabled = YES;
}


-(void)addChildViewController:(UIViewController *)childController titles:(NSString *)titles images:(NSString *)imageName{
    
    if (titles) {
        childController.title = titles;
        [childController.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor darkGrayColor]} forState:UIControlStateNormal];
        [childController.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor orangeColor]} forState:UIControlStateSelected];
    }
    if (imageName) {
        childController.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

        NSString *SelectImage =[NSString stringWithFormat:@"%@_selected",imageName] ;
        
        childController.tabBarItem.selectedImage = [[UIImage imageNamed:SelectImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    
    KYNavigationController *KYNav = [[KYNavigationController alloc]initWithRootViewController:childController];
    
    [self addChildViewController:KYNav];
    
}

#pragma mark - 懒加载
- (CLLocationManager *)locationManager {
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc]init];
        _locationManager.delegate = self;
        //        _locationManager.allowsBackgroundLocationUpdates = YES;
    }
    return _locationManager;
}



@end
