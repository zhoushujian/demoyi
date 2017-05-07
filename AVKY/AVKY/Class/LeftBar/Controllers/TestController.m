//
//  TestController.m
//  AVKY
//
//  Created by Marcello on 16/8/4.
//  Copyright © 2016年 杰. All rights reserved.
//

#import "TestController.h"
#import "ICSDrawerController.h"
#import "KYTabarController.h"
#import "LeftBarController.h"
#import "ICSDrawerController.h"
#import "GYHNOLoginLeftController.h"
#import "GYHSliderSettingItemArrow.h"
#import "GYHSliderSettingGroup.h"
#import "FeedbackController.h"
#import "GYHSliderCell.h"
#import "ModifyPasswordController.h"
@interface TestController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)KYTabarController *MainController;

@property(nonatomic,strong)LeftBarController *leftController;


@property(nonatomic,strong)ICSDrawerController *ISCDController;

@property (nonatomic, strong) GYHNOLoginLeftController *noLoginController;

@property (nonatomic, assign) BOOL isLogina;

@property(nonatomic,strong)UITableView *tableView;



@property(nonatomic,strong) NSMutableArray *groups;
@end

@implementation TestController

- (void)viewDidLoad{
    

    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"pic_hd_2"]];
    
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = [UIColor clearColor];
    [self SetUI];
    
}

-(void)SetUI{
    /**
     
     "Feedback" = "Feedback";//意见反馈
     "Explain" = "Explain";//说明
     "ModifyPassword" = "Modify Password";//修改密码
     "ClearCache" = "Clear Cache";//清理缓存
     "Cancellation" = "Cancellation";//注销
     */
    NSString *Feedback = NSLocalizedString(@"Feedback", nil);
     NSString *Explain = NSLocalizedString(@"Explain", nil);
     NSString *ModifyPassword = NSLocalizedString(@"ModifyPassword", nil);
     NSString *ClearCache = NSLocalizedString(@"ClearCache", nil);
     NSString *Cancellation = NSLocalizedString(@"Cancellation", nil);
    
    GYHSliderSettingItemArrow *item0 = [GYHSliderSettingItemArrow itemWithTitle:Feedback icon:@"medtronic_phone" destVc:[FeedbackController class]];
    
    
    GYHSliderSettingItemArrow *item1 = [GYHSliderSettingItemArrow itemWithTitle: Explain icon:@"medtronic_service" destVc:[FeedbackController class]];
    
    GYHSliderSettingItemArrow *item2 = [GYHSliderSettingItemArrow itemWithTitle:ModifyPassword icon:@"medtronic_story" destVc:[ModifyPasswordController class]];
    
    
    GYHSliderSettingItemArrow *item3 = [GYHSliderSettingItemArrow itemWithTitle: ClearCache icon:@"service_private_manager_s" destVc:nil];
    
    //实现Item3的Block方法
    item3.operationBlock= ^{
        
        [self ClearMemoryPop];
        
    };
    
    
    
    GYHSliderSettingItemArrow *item4 = [GYHSliderSettingItemArrow itemWithTitle:Cancellation icon:@"medtronic_vip_zone" destVc:[FeedbackController class]];
    
    
    GYHSliderSettingGroup *group1 = [GYHSliderSettingGroup groupWithItems:@[item0,item1,item2,item3,item4]];
    
     self.groups = [NSMutableArray arrayWithObjects:group1, nil];
    

    
}

#pragma mark  - tableView数据源

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    GYHSliderSettingGroup *group = self.groups[section];
    return group.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    GYHSliderCell *cell = [GYHSliderCell cellWithTabelView:tableView];
    
    cell.showLineView = NO;
    
    GYHSliderSettingGroup *group = self.groups[indexPath.section];
    
    cell.item = group.items[indexPath.row];
    
    cell.showLineView = (indexPath.row == group.items.count - 1);
    
    return cell;
}
#pragma mark - tableView代理
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.001;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    GYHSliderSettingGroup *group = self.groups[indexPath.section];
    GYHSliderSettingItem *item = group.items[indexPath.row];
    
    if (item.operationBlock) {
        item.operationBlock();
        return;
    }
    
    if (indexPath.row ==4) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"你确定要退出吗" preferredStyle:UIAlertControllerStyleActionSheet];
        [alert addAction:[UIAlertAction actionWithTitle:@"注销" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            // 清除微博登录加载的数据
            [[UserAccount sharedUserAccount] removeOAuthKey];
            // 当前登录的用户ID
            [UserAccount sharedUserAccount].loginID = nil;
            [self didClick];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        
        [self presentViewController:alert animated:YES completion:^{
            
        }];
        
        return;
    }
    
    if ([item isKindOfClass:[GYHSliderSettingItemArrow class]]) {
        GYHSliderSettingItemArrow *arrowItem = (GYHSliderSettingItemArrow *)item;
        if (arrowItem.destVc) {
            
            UIViewController *controller = [[arrowItem.destVc alloc] init];
            controller.title = item.title;
            
            [self.navigationController pushViewController:controller animated:YES];
            
        }
    
    }

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    self.isLogina = !self.isLogina;
}

- (void)didClick{

    CATransition *animation = [[CATransition alloc] init];
    animation.duration = 1.0;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = kCATransitionFade;
    [UIApplication sharedApplication].keyWindow.rootViewController = self.ISCDController;
    [[UIApplication sharedApplication].keyWindow.layer addAnimation:animation forKey:@"animation"];
}



#pragma mark -清理缓存

-(void)myClearCacheAction{
    dispatch_async(
                   dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
                   , ^{
                       NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
                       
                       NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachPath];
                       //文件个数
                       NSLog(@"files :%lu",(unsigned long)[files count]);
                       for (NSString *p in files) {
                           NSError *error;
                           NSString *path = [cachPath stringByAppendingPathComponent:p];
                           if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
                               [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
                           }
                       }
                       [self performSelectorOnMainThread:@selector(clearCacheSuccess) withObject:nil waitUntilDone:YES];});
}


-(void)clearCacheSuccess{
    
    NSLog(@"清理成功");
    
}

-(void)ClearMemoryPop{
    
    NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    CGFloat fileSize = [self folderSizeAtPath:cachPath];
    
    NSString *Memory = [NSString stringWithFormat:@"缓存大小：%.2lfMB",fileSize];
    
    
    
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"你确定要清理缓存？" message:Memory preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"清除" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
        [SVProgressHUD show];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [SVProgressHUD showSuccessWithStatus:@"清理成功"];
            delay(1.2);
            
            //调用清理缓存
            [self myClearCacheAction];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
                
            });
        });
       

    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
    
}



- (CGFloat)folderSizeAtPath:(NSString *)folderPath
{
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) {
        return 0;
    }
    
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    
    NSString *fileName = nil;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil) {
        NSString *fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    
    return folderSize/(1024.0*1024.0);
}

-(long long)fileSizeAtPath:(NSString *)filePath
{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
    
}




#pragma mark - 懒加载控件
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


- (GYHNOLoginLeftController *)noLoginController{
    
    if (!_noLoginController) {
        
        _noLoginController = [[GYHNOLoginLeftController alloc] init];
    }
    return _noLoginController;
}

-(ICSDrawerController *)ISCDController{
    
    
    if (!_ISCDController) {
        
        //判断是否登录
        if (self.isLogina) {
            _ISCDController = [[ICSDrawerController alloc]initWithLeftViewController:self.leftController centerViewController:self.MainController];
        }else{
            
            _ISCDController = [[ICSDrawerController alloc]initWithLeftViewController:self.noLoginController centerViewController:self.MainController];
        }
        
    }
    return _ISCDController;
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}




@end
