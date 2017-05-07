//
//  GYHNOLoginLeftController.m
//  AVKY
//
//  Created by Marcello on 16/8/5.
//  Copyright © 2016年 杰. All rights reserved.
//

#import "GYHNOLoginLeftController.h"

#import "GYHIdentifiView.h"
#import "LeftBarController.h"
#import "KYTabarController.h"
#import "YZLoginController.h"
#import "ICSDrawerController.h"
#import "YZLoginController.h"
#import "YZRegisterController.h"
#import "YZUserinfoController.h"

#import "GYHLoginView.h"


@interface GYHNOLoginLeftController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) ICSDrawerController *ISCDController;

@property(nonatomic,strong)KYTabarController *MainController;

@property(nonatomic,strong)LeftBarController *leftController;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray * stringArray;

@end

@implementation GYHNOLoginLeftController


- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    [self setUpHeadView];
    
    self.view.backgroundColor = [UIColor redColor];
}


/**
 *  设置headView
 */
- (void)setUpHeadView{
    
    CGRect frame = CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width*3.0/4.0f , 100);
    
    //点击手势
//    UITapGestureRecognizer*tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickIdentifiView:)];
    
    UIView *tableHeadView = [[UIView alloc] init];
    tableHeadView.frame = frame;
    tableHeadView.backgroundColor = [UIColor clearColor];
    self.tableView.tableHeaderView = tableHeadView;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //添加tableView
    [self.view addSubview:self.tableView];
    
    //添加头像View
    GYHLoginView *identiView = [[GYHLoginView alloc] init];
    
    identiView.frame = frame;
    
    /**
     *  登录回调
     */
    [identiView setGoToLogin:^{
        
        YZLoginController *loginViewController = [[YZLoginController alloc] init];
        
        UITabBarController *tab = (UITabBarController *)self.drawer.centerViewController;
        UINavigationController *nav = tab.selectedViewController;
        [nav popViewControllerAnimated:NO];
        [self.drawer close];
        [nav pushViewController:loginViewController animated:YES];
        
    }];
    
    /**
     *  注册回调
     */
    [identiView setGoToRegister:^{
        
        YZRegisterController *registController = [[YZRegisterController alloc] init];
        UITabBarController *tab = (UITabBarController *)self.drawer.centerViewController;
        UINavigationController *nav = tab.selectedViewController;
        [nav popViewControllerAnimated:NO];
        [self.drawer close];
        [nav pushViewController:registController animated:YES];
        
    }];
    
    [self.view addSubview:identiView];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeRootViewController:) name:loginSuccessNotification object:nil];
}

#pragma mark - UITableView delegarte 

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.stringArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
   
    
    if (indexPath.row == 0) {
        cell.textLabel.font = [UIFont systemFontOfSize:25];
    }else if(indexPath.row == 2 ){
         cell.textLabel.font = [UIFont systemFontOfSize:20];
    }else if(indexPath.row == 3){
         cell.textLabel.font = [UIFont systemFontOfSize:15];
    }else{
         cell.textLabel.font = [UIFont systemFontOfSize:11];
    }
    cell.textLabel.text = self.stringArray[indexPath.row];
    
    return cell;
}



#pragma mark - 响应事件

/**
 *  点击了头像的View
 *
 *  @param view <#view description#>
 */
- (void)didClickIdentifiView:(UIView *)view{
    
    //创建目标控制器
    YZUserinfoController *userinfoController = [[YZUserinfoController alloc] init];
    UITabBarController *tab = (UITabBarController *)self.drawer.centerViewController;
    UINavigationController *nav = tab.selectedViewController;
    [nav popViewControllerAnimated:NO];
    [self.drawer close];
    [nav pushViewController:userinfoController animated:NO];
    
}

/**
 *  更改根控制器
 *
 *  @param some <#some description#>
 */
- (void)changeRootViewController:(NSNotification *)some{
    
//    NSLog(@"通知收到了吗");
    
    CATransition *animation = [[CATransition alloc] init];
    animation.duration = 1.0;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = kCATransitionFade;

    [UIApplication sharedApplication].keyWindow.rootViewController = self.ISCDController;
    [[UIApplication sharedApplication].keyWindow.layer addAnimation:animation forKey:@"animation"];
    
//    NSLog(@"转换成功了吗");
    
}



#pragma mark - 懒加载

- (ICSDrawerController *)ISCDController{
    if (!_ISCDController) {
        
        _ISCDController = [[ICSDrawerController alloc]initWithLeftViewController:self.leftController centerViewController:self.MainController];
    }
    
    return _ISCDController;
}


-(KYTabarController *)MainController{
    if (!_MainController) {
        _MainController = [[KYTabarController alloc]init];
    }
    return _MainController;
}



-(LeftBarController *)leftController{
    if (!_leftController) {
        _leftController = [[LeftBarController alloc]init];
    }
    return _leftController;
}


- (UITableView *)tableView{
    
    if (!_tableView) {
        CGRect frame = CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width*3.0/4.0f , self.view.bounds.size.height);
        
        _tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.frame = self.view.bounds;
    }
    
    return _tableView;
}

- (NSArray *)stringArray{
    
//### 沁园春《 操 》
//#### 夜店风光，千里红灯，万里鸡飘。
//#### 望包房内外，MM攒动，沙发上下，JJ乱翘。
//#### 性交如此多招，
//#### 引无数英雄累断折腰。
//#### 长城内外金枪不倒，
//#### 黄河两岸淫水滔滔。
//#### 唐宗宋祖只会肛交，
//#### 一代天骄成吉思汗，
//#### 体外射精一米多高，
//#### 数风流人物全干通宵！
    
    if (!_stringArray) {
        
        _stringArray = @[];
        
//        _stringArray = @[@"     沁园春《 操 》",@"夜店风光，",@"千里红灯，",@"万里鸡飘。",@"望包房内外，",@"MM攒动，",@"沙发上下，",@"JJ乱翘。",@"性交如此多招，",@"引无数英雄累断折腰。",@"长城内外金枪不倒，",@"黄河两岸淫水滔滔。",@"唐宗宋祖只会肛交，",@"一代天骄成吉思汗，",@"体外射精一米多高，",@"数风流人物全干通宵！",@"         -------------作者:罗叼毛"];
    }
    
    return _stringArray;
}

@end
