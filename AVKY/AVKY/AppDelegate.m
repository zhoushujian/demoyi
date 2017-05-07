//
//  AppDelegate.m
//  AVKY
//
//  Created by 杰 on 16/8/3.
//  Copyright © 2016年 杰. All rights reserved.
//
#import "BaiduMapAPI_Map/BMKMapComponent.h"
#import "AppDelegate.h"
#import "KYTabarController.h"
#import "LeftBarController.h"
#import "ICSDrawerController.h"
#import "KYNavigationController.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import "WXApi.h"
#import "WeiboSDK.h"
#import "AVUserDefaultsTool.h"
#import "NewFeatureController.h"
#import "GYHNOLoginLeftController.h"
#import "UserAccount.h"
#import "DYSQLiteManager.h"
#import "Reachability.h"
#import "NewFeatureViewController.h"


@interface AppDelegate ()<BMKGeneralDelegate>

@property(nonatomic,strong)KYTabarController *MainController;

@property(nonatomic,strong)LeftBarController *leftController;


@property(nonatomic,strong)ICSDrawerController *ISCDController;

@property (nonatomic, strong) GYHNOLoginLeftController *noLoginController;

@property(nonatomic,strong)NewFeatureController *NewController;

// 用来启动百度地图
@property (strong, nonatomic) BMKMapManager *mapManager;


@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    NSLog(@"%@",NSHomeDirectory());
    
    self.window  = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    
    [self Newfeature];
   //self.window.rootViewController = [self setupNewFeature];
    
    [self.window makeKeyAndVisible];
    
    
    
    //创建本地数据库,创建一个医生的table
    [[DYSQLiteManager sharedManager] openDatabase];
    
    //要使用的第三方平台集合 @(SSDKPlatformTypeSMS),
    NSArray *platforms = @[@(SSDKPlatformTypeSinaWeibo),
                           @(SSDKPlatformTypeMail),
                           @(SSDKPlatformTypeWechat)];
    // 需要在此方法中对原平台SDK进行导入操作 (ShareSDK要调用原平台)
    SSDKImportHandler importHandler = ^(SSDKPlatformType platformType){
        switch (platformType) {
            case SSDKPlatformTypeSinaWeibo:{
                [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                break;
            }
            case SSDKPlatformTypeWechat:{
                [ShareSDKConnector connectWeChat:[WXApi class]];
                break;
            }
            default:
                break;
        }
    };
    //配置第三方平台参数
    SSDKConfigurationHandler  configurationHandler = ^(SSDKPlatformType platformTyoe,NSMutableDictionary *appInfo){
        switch (platformTyoe) {
            case SSDKPlatformTypeWechat:
                [appInfo SSDKSetupWeChatByAppId:weChatAppKey appSecret:weChatAppSecret];
                break;
            case SSDKPlatformTypeSinaWeibo:
                [appInfo SSDKSetupSinaWeiboByAppKey:sinaAppKey appSecret:sinaAppSecret redirectUri:sinaRedirectUri authType:SSDKAuthTypeBoth];
                break;
            default:
                break;
        }
    };
    
    //初始化第三方平台
    [ShareSDK registerApp:ShareSDKAPPKey activePlatforms:platforms onImport:importHandler onConfiguration:configurationHandler];
    
    // 注册短信验证 (验证身份)
    [SMSSDK registerApp:@"1584306aa4990" withSecret:@"bebbeb871d4ba901525224a8356f955b"];
    
    // 要使用百度地图，请先启动BaiduMapManager
    _mapManager = [[BMKMapManager alloc]init];
    
    // 要启动百度地图的引擎 (检查是否可以使用百度地图)
    // 如果要关注网络及授权验证事件，请设定generalDelegate参数
    BOOL ret = [_mapManager start:baiDuMapAK  generalDelegate:self];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    
    return YES;
}

- (NewFeatureViewController *)setupNewFeature
{
    NewFeatureViewController *newFeatureVC = [[NewFeatureViewController alloc] init];
    // 设置本地视频路径数组
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i<4; i++) {
        
        NSString *path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"guide%d",i] ofType:@"mp4"];
        [array addObject:path];
    }
    newFeatureVC.guideMoviePathArr = array;
    // 设置封面图片数组
    newFeatureVC.guideImagesArr = @[@"guide0", @"guide1", @"guide2", @"guide3"];
    // 设置最后一个视频播放完成之后的block
    [newFeatureVC setLastOnePlayFinished:^{
        
        
        [UIApplication sharedApplication].keyWindow.rootViewController = self.ISCDController;

    }];
    return newFeatureVC;
}

-(void)Newfeature{
    NSString *versionKey = @"CFBundleVersion";
    
    NSString *footVersionKey = [AVUserDefaultsTool objetForKey:versionKey];
    
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[versionKey];
    //检查当前的版本号是否和旧的的版本号一致

    if ([currentVersion isEqualToString:footVersionKey]) {
        //若一样，打开主界面

        self.window.rootViewController = self.ISCDController;
        
    }else{
        //若不一样打开新特性界面

       //self.window.rootViewController = self.NewController;
        
        self.window.rootViewController = [self setupNewFeature];
    
        [AVUserDefaultsTool saveObject:currentVersion forKey:versionKey];
//        self.window.rootViewController = self.ISCDController;
    }
    //将旧的版本号设置为新的版本号存储
    footVersionKey = currentVersion;
    self.NewController = nil;
}



-(KYTabarController *)MainController{
    if (!_MainController) {
        _MainController = [[KYTabarController alloc]init];
    }
    return _MainController;
}

-(NewFeatureController *)NewController{
    if (!_NewController) {
        _NewController = [[NewFeatureController alloc]init];
        
    }
    return _NewController;
}

-(LeftBarController *)leftController{
    if (!_leftController) {
        _leftController = [[LeftBarController alloc]init];
    }
    return _leftController;
}


- (GYHNOLoginLeftController *)noLoginController{
    
    if (!_noLoginController) {
        
        _noLoginController = [[GYHNOLoginLeftController alloc] init];
    }
    return _noLoginController;
}


-(ICSDrawerController *)ISCDController{
    
    
    if (!_ISCDController) {
        //判断是否登录
        if ([UserAccount sharedUserAccount].loginID) {

            _ISCDController = [[ICSDrawerController alloc]initWithLeftViewController:self.leftController centerViewController:self.MainController];
        }else{
            _ISCDController = [[ICSDrawerController alloc]initWithLeftViewController:self.noLoginController centerViewController:self.MainController];
        }

    }
    return _ISCDController;
}

//
//- (void)onGetPermissionState:(int)iError
//{
//    if (iError == E_PERMISSIONCHECK_OK) {
////        NSLog(@"百度授权成功");
//    }
//}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
