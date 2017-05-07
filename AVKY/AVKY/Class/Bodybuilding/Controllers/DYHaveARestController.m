//
//  DYHaveARestController.m
//  AVKY
//
//  Created by Yangdongwu on 16/8/4.
//  Copyright © 2016年 杰. All rights reserved.
//szh1ol0z7GZ1eUL79i7SXSW2jI14Ppth

#import "DYHaveARestController.h"
#import "SearchModel.h"
#import "ZYASearchView.h"

//引入base相关所有的头文件
#import <BaiduMapAPI_Base/BMKBaseComponent.h>

//引入地图功能所有的头文件
#import <BaiduMapAPI_Map/BMKMapComponent.h>

//引入检索功能所有的头文件
#import <BaiduMapAPI_Search/BMKSearchComponent.h>

//引入定位功能所有的头文件
#import <BaiduMapAPI_Location/BMKLocationComponent.h>

//引入计算工具所有的头文件
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>

//只引入所需的单个头文件
#import <BaiduMapAPI_Map/BMKMapView.h>

@interface DYHaveARestController ()<BMKMapViewDelegate,BMKLocationServiceDelegate,BMKPoiSearchDelegate>
// 百度地图视图
@property (strong, nonatomic) BMKMapView *mapView;

//搜索输入框
@property(nonatomic,strong)UITextField *searchFile;

//搜索按钮
@property(nonatomic,strong)UIButton *searchBtn;

//定位服务(与地图独立)
@property(nonatomic,strong)BMKLocationService *locationService;

//POI检索
@property(nonatomic,strong)BMKPoiSearch *poiSearch;


@end

@implementation DYHaveARestController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavigationBar];
    
    // 使用BMKMapView一定要注意生命周期的控制
    self.mapView = [[BMKMapView alloc] initWithFrame:self.view.bounds];
    self.mapView.zoomEnabled = YES;
    [self.view addSubview:self.mapView];

}

#pragma mark -设置NavigationBar
- (void)setNavigationBar {
  
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 240, 30)];
    [view addSubview:self.searchFile];
    self.navigationItem.titleView = view;
    
    UIButton *button = [[UIButton alloc] init];
    button.frame = CGRectMake(0, 0, 50, 40);
    [button setImage:[UIImage imageNamed:@"home_nav_button_back"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(didBackButton:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        self.navigationItem.leftBarButtonItem = leftItem;
    
    [self.searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [self.searchBtn addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];
    [self.searchBtn addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.searchBtn];
}

- (void)didBackButton:(UIButton *)button {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 当mapview即将被显式的时候调用，恢复之前存储的mapview状态
    [self.mapView viewWillAppear];
    // 在显示地图的时候配置代码理
    self.mapView.delegate = self;
    self.locationService.delegate = self;
    self.poiSearch.delegate =self;
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // 当mapview即将被隐藏的时候调用，存储当前mapview的状态
    [self.mapView viewWillDisappear];
    // 此处记得不用的时候需要置nil，否则影响内存的释放
    self.mapView.delegate = nil;
    self.poiSearch.delegate = nil;
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    //设置地图,显示用户位置
    [self.mapView setShowsUserLocation:NO];
    //设置用户追踪模式
    self.mapView.userTrackingMode = BMKUserTrackingModeFollow;
    [self.mapView setShowsUserLocation:YES];
    //开始定位,需要配置info.plist文件
    [self.locationService startUserLocationService];
}



#pragma mark - searchAction 搜索的点击事件

-(void)searchAction {
    //退出键盘
    [self.searchFile endEditing:YES];
    BMKNearbySearchOption *option = [[BMKNearbySearchOption alloc] init];
    option.keyword = self.searchFile.text;
    option.radius = 5000;
    
    BMKUserLocation *userLocation = self.locationService.userLocation;
    option.location = userLocation.location.coordinate;
    
    [self.poiSearch poiSearchNearBy:option];
}

#pragma mark - BMKPoiSearchDelegate

//检索返回的代理方法
-(void)onGetPoiResult:(BMKPoiSearch *)searcher result:(BMKPoiResult *)poiResult errorCode:(BMKSearchErrorCode)errorCode {
    if (errorCode) {
        NSLog(@"检索失败:%zd",errorCode);
    }
    
    //返回结果
    NSLog(@"%zd",poiResult.totalPoiNum);
    
    // BMKPoiInfo 表示具体某个位置的信息
    NSArray <BMKPoiInfo *> *poiArray = poiResult.poiInfoList;
    for (BMKPoiInfo *info in poiArray) {
        //添加大头针模型
        SearchModel *search = [[SearchModel alloc] init];
        search.coordinate = info.pt;
        search.phoneNumer = info.phone;
        [self.mapView addAnnotation:search];
    }
}

#pragma mark - BMKMapViewDelegate

-(BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation {
    if ([annotation isKindOfClass:[SearchModel class]]) {
        ZYASearchView *searchView = [ZYASearchView searchViewWithAnnotation:annotation inMapView:mapView];
        
        return searchView;
    }
    
    //默认效果
    return nil;
}

#pragma mark - BMKLocationServiceDelegate

-(void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation {
    //userLocation是用户大头针的数据模型
    //地图跟定位是分开的,更新地图上用户的位置数据
    [self.mapView updateLocationData:userLocation];
    //停止定位
    [self.locationService stopUserLocationService];
   
    //默认不会修改地图区域,需要导入工具模块
    BMKCoordinateRegion region = BMKCoordinateRegionMake(userLocation.location.coordinate, BMKCoordinateSpanMake(0.01, 0.01));
    
    [self.mapView setRegion:region animated:YES];
}

#pragma mark -Getter & setter

-(BMKLocationService*)locationService {
    if (!_locationService) {
        _locationService = [[BMKLocationService alloc] init];
    }
    return _locationService;
}

-(BMKPoiSearch*)poiSearch {
    if (!_poiSearch) {
        _poiSearch =[[ BMKPoiSearch alloc] init];
    }
    return _poiSearch;
}

-(UIButton*)searchBtn {
    if (_searchBtn == nil) {
        _searchBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 40)];
    }
    return _searchBtn;
}

-(UITextField*)searchFile {
    if (_searchFile == nil) {
        _searchFile = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 240, 30)];
        _searchFile.placeholder = @"请输入地址";
        _searchFile.textAlignment = NSTextAlignmentCenter;
        _searchFile.borderStyle = UITextBorderStyleRoundedRect;
        _searchFile.textColor = [UIColor grayColor];
        _searchFile.backgroundColor = [UIColor whiteColor];
    }
    return _searchFile;
}

@end
