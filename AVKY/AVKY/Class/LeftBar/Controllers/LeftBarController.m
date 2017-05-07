//
//  LeftBarController.m
//  AVKY
//
//  Created by 杰 on 16/8/3.
//  Copyright © 2016年 杰. All rights reserved.
//

#import "LeftBarController.h"
#import "GYHIdentifiView.h"
#import "GYHSliderSettingItem.h"
#import "GYHSliderSettingGroup.h"
#import "GYHSliderSettingItemArrow.h"
#import "TestController.h"
#import "GYHSliderCell.h"
#import "KYNavigationController.h"
#import "YZLoginController.h"
#import <ShareSDK/ShareSDK.h>
#import "GYHRecordMangerController.h"
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import "DYAttentionDoctorsController.h"
#import "ZYAAboutKYController.h"
#import "YZUserinfoController.h"
#import "ApplyForDoctorController.h"

@interface LeftBarController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property(nonatomic,strong) NSMutableArray *groups;


@end

@implementation LeftBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"" object:nil];
    self.view.backgroundColor = [UIColor whiteColor];
    
//设置tableView的cell的模型
    [self setUPItem];
    //设置侧边栏头部的View
    [self setUpHeadView];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  设置item
 */
- (void)setUPItem{
    
    /**
     "MedicalDoctor" = "MedicalDoctor";//名医申请
     "katamnesis" = "katamnesis";//病历管理
     "follow" = "follow";//关注医生
     "setting" = "Setting";//设置
     "about" = "about";//关于
     "share" = "share";//分享
     */
    
    NSString *MedicalDoctor = NSLocalizedString(@"MedicalDoctor", nil);
    NSString *katamnesis = NSLocalizedString(@"katamnesis", nil);
    NSString *follow = NSLocalizedString(@"follow", nil);
    NSString *setting = NSLocalizedString(@"setting", nil);
    NSString *about = NSLocalizedString(@"about", nil);
    NSString *share = NSLocalizedString(@"share", nil);
    
    GYHSliderSettingItemArrow *item0 = [GYHSliderSettingItemArrow itemWithTitle:MedicalDoctor icon:@"More_LotteryRecommend" destVc:[ApplyForDoctorController class]];
    
    
    GYHSliderSettingItemArrow *item1 = [GYHSliderSettingItemArrow itemWithTitle:katamnesis icon:@"MoreNetease" destVc:[GYHRecordMangerController class]];
    
    GYHSliderSettingItemArrow *item2 = [GYHSliderSettingItemArrow itemWithTitle:follow icon:@"RedeemCode" destVc:[DYAttentionDoctorsController class]];
    
    GYHSliderSettingGroup *group1 = [GYHSliderSettingGroup groupWithItems:@[item0,item1,item2]];
    
    GYHSliderSettingItemArrow *item10 = [GYHSliderSettingItemArrow itemWithTitle:setting icon:@"MoreHelp" destVc:[TestController class]];
    
    GYHSliderSettingItemArrow *item11 = [GYHSliderSettingItemArrow itemWithTitle:about icon:@"MoreAbout" destVc:[ZYAAboutKYController class]];
    
    GYHSliderSettingItemArrow *item12 = [GYHSliderSettingItemArrow itemWithTitle:share icon:@"MoreShare" destVc:nil];
    
//     GYHSliderSettingItemArrow *item13 = [GYHSliderSettingItemArrow itemWithTitle:@"注销账号" icon:@"MoreHelp" destVc:nil];
    
    GYHSliderSettingGroup *group2 = [GYHSliderSettingGroup groupWithItems:@[item10,item11,item12]];
    
    self.groups = [NSMutableArray arrayWithObjects:group1,group2, nil];

}

/**
 *  设置headView
 */
- (void)setUpHeadView{
    
    //点击手势
    UITapGestureRecognizer*tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickIdentifiView:)];
    
    UIView *tableHeadView = [[UIView alloc] init];
    tableHeadView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 100) ;
    tableHeadView.backgroundColor = [UIColor clearColor];
    self.tableView.tableHeaderView = tableHeadView;
    //添加tableView
    [self.view addSubview:self.tableView];
    
    //添加头像View
    UIView *identiView = [[GYHIdentifiView alloc] init];
    
    identiView.frame = CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width , 100);
    //添加手势
    [identiView addGestureRecognizer:tapGesture];
    
    [self.view addSubview:identiView];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    GYHSliderSettingGroup *group = self.groups[section];
    return group.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    GYHSliderCell *cell = [GYHSliderCell cellWithTabelView:tableView];

    GYHSliderSettingGroup *group = self.groups[indexPath.section];
    
    cell.item = group.items[indexPath.row];
    
    cell.showLineView = (indexPath.row == group.items.count - 1);


    return cell;
}

#pragma mark - UITableViewDelegate 

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    // 取消选中
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    GYHSliderSettingGroup *group = self.groups[indexPath.section];
    GYHSliderSettingItem *item = group.items[indexPath.row];
    if (item.operationBlock) {
        item.operationBlock();// 执行block
        return;
    }
    if ([item isKindOfClass:[GYHSliderSettingItemArrow class]]) {
        GYHSliderSettingItemArrow *arrowItem = (GYHSliderSettingItemArrow *)item;
        if (arrowItem.destVc) {
            
            UIViewController *controller = [[arrowItem.destVc alloc] init];
            controller.title = item.title;
            UITabBarController *tab = (UITabBarController *)self.drawer.centerViewController;
            UINavigationController *nav = tab.selectedViewController;
           // [nav popViewControllerAnimated:NO];
            [nav popToRootViewControllerAnimated:NO];
            //关闭抽屉效果
            [self.drawer close];
            [nav pushViewController:controller animated:NO];
            
        }else{
            
            NSArray *imagesArr = @[[UIImage imageNamed:@"1"]];
            NSURL *url = [NSURL URLWithString:@"http://www.itheima.com"];
            NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
            //创建分享参数
            [shareParams SSDKSetupShareParamsByText:@"一杆枪,两颗弹,二十多年未抗战"
                                             images:imagesArr
                                                url:url
                                              title:@"一分钟让你变真男人"
                                               type:SSDKContentTypeAuto];
            
            //分享结果的回调方法
            SSUIShareStateChangedHandler hanler = ^ (SSDKResponseState state,
                                                     SSDKPlatformType platformType,
                                                     NSDictionary *userData,
                                                     SSDKContentEntity *contentEntity,
                                                     NSError *error,
                                                     BOOL end) {
                switch (state) {
                    case SSDKResponseStateSuccess:
                        NSLog(@"分享成功");
                        break;
                    case SSDKResponseStateFail:
                        NSLog(@"分享失败");
                        break;
                    default:
                        break;
                }
            };
            //分享回调
            [ShareSDK showShareActionSheet:nil items:nil shareParams:shareParams onShareStateChanged:hanler];
            
        }
    }

}


#pragma mark - 响应事件

/**
 *  点击了头像的View  跳转到登录界面
 *
 *  @param view <#view description#>
 */
- (void)didClickIdentifiView:(UIView *)view{

    //创建目标控制器
    YZUserinfoController  *loginController = [[YZUserinfoController alloc] init];
    UITabBarController *tab = (UITabBarController *)self.drawer.centerViewController;
    UINavigationController *nav = tab.selectedViewController;
    [nav popViewControllerAnimated:NO];
    [self.drawer close];
    [nav pushViewController:loginController animated:NO];

}


#pragma mark - 懒加载

- (UITableView *)tableView{
    
    if (!_tableView ) {
        
        CGRect frame = CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width*3.0/4.0f , self.view.bounds.size.height);
        _tableView = [[UITableView alloc] initWithFrame: frame style:UITableViewStyleGrouped];;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
    }
    
    return _tableView;
}



@end
