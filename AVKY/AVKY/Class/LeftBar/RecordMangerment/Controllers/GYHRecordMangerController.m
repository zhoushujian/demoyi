//
//  GYHRecordMangerController.m
//  AVKY
//
//  Created by Marcello on 16/8/4.
//  Copyright © 2016年 杰. All rights reserved.
//

#import "GYHRecordMangerController.h"
#import "GYHInformationView.h"
#import "GYHBottomView.h"
#import <Masonry.h>
#import "TestController.h"
#import "ICSDrawerController.h"
#import "GYHAddRecordController.h"
#import "GYHRecordCell.h"
#import "GYHRecordModel.h"
/**
 **
 *
 *
 *
 *
 *
 *
 *病历根据创建时间,或者修改时间 对病历模型进行重新排序   ============== 等待完善
 *
 *
 */
@interface GYHRecordMangerController ()<UITableViewDataSource,UITableViewDelegate>

/**
 *  病历时间轴
 */
@property (nonatomic, strong) UITableView *timeLineView;

/**
 *  个人信息View
 */
@property (nonatomic, strong) GYHInformationView *inforView;

/**
 *  增加病历button
 */
@property (nonatomic, strong) GYHBottomView *addRecodrView;

/**
 *  病历管理数组
 */
@property (nonatomic, strong) NSMutableArray *recordMangerArr;

/**
 *  排序数组
 */
@property (nonatomic, strong) NSMutableArray *sortMtuArr;

@end

@implementation GYHRecordMangerController

@synthesize sortMtuArr = _sortMtuArr;


- (void)viewDidLoad{
    [super viewDidLoad];
//    [UIApplication sharedApplication].keyWindow.r
    /**
     *  设置个人信息View
     */
    [self setupInformationView];
    
    //设置底部的View
    [self setupBottomView];
    
    //设置navgationbar
    [self setNavgationBar];
    
    //设置时间轴
    [self setupTimeLineView];
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
}

/**
 *  设置个人信息View
 */
- (void)setupInformationView{
    
    GYHInformationView *identifiView = [[GYHInformationView alloc] init];
    identifiView.frame = CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 200) ;
    identifiView.backgroundColor = [ UIColor whiteColor];
    
    self.inforView = identifiView;
    [self.view addSubview:identifiView];
    
}

/**
 *  设置底部的View
 */
- (void)setupBottomView {
    
    //点击手势
    UITapGestureRecognizer*tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickInformationiView:)];
    
    GYHBottomView *bottomView = [[GYHBottomView alloc] init];
    
    bottomView.backgroundColor = [UIColor whiteColor];
    
    [bottomView addGestureRecognizer:tapGesture];
    [self.view addSubview:bottomView];
    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake([UIScreen mainScreen].bounds.size.width, 50));
        make.bottom.mas_equalTo(self.view.mas_bottom);
    }];
    
    self.addRecodrView = bottomView;
    
}

/**
 *  设置navgationBar
 */
- (void)setNavgationBar{
    
    UIButton *button = [[UIButton alloc] init];
    button.frame = CGRectMake(0, 0, 50, 40);
    [button setImage:[UIImage imageNamed:@"home_nav_button_back"] forState:UIControlStateNormal];
    button.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    [button addTarget:self action:@selector(didBackButton:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = leftItem;
    
}

/**
 *  设置时间轴
 */
- (void)setupTimeLineView{
    
    [self.view addSubview:self.timeLineView];
    
    [self.timeLineView registerNib:[UINib nibWithNibName:@"GYHRecordCell"  bundle:nil]forCellReuseIdentifier:@"record"];

    //布局UI
    
    [self.timeLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.inforView.mas_bottom).offset(10);
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.bottom.mas_equalTo(self.addRecodrView.mas_top).offset(-20);
    }];
}


#pragma mark - UIUITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (self.sortMtuArr) {
        
        return self.sortMtuArr.count;
    }
    return 0;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    GYHRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"record"];
    GYHRecordModel *model = self.sortMtuArr[indexPath.row];
    cell.recordModel = model;

    return cell;

}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //修改病历
    GYHAddRecordController *editController = [self editRecordModel:indexPath];
    
    [self.navigationController pushViewController:editController animated:YES];
    

}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    

    UITableViewRowAction *action =[UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        //删除当前的病历模型
        [self.recordMangerArr removeObjectAtIndex:indexPath.row];
        self.sortMtuArr = self.recordMangerArr;
        
    }] ;
    
    action.backgroundColor = [UIColor redColor];
    
    UITableViewRowAction *edictAction =[UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"编辑" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        //修改编辑病历
        GYHAddRecordController *editController = [self editRecordModel:indexPath];
        //跳转
        [self.navigationController pushViewController:editController animated:YES];
        
    }] ;
    
    edictAction.backgroundColor = globalColor;

    return @[action,edictAction];
    
}




#pragma mark - 响应事件

/**
 *  跳转增加病历控制器
 *
 *  @param view <#view description#>
 */
- (void)didClickInformationiView:(UIView*)view{
    
    GYHAddRecordController *addRecordController = [[GYHAddRecordController alloc] init];

    addRecordController.title = @"添加病历";
    [addRecordController setCallbackModel:^(GYHRecordModel * model) {
        //获取病历模型
        [self.recordMangerArr addObject:model];
        
        self.sortMtuArr = self.recordMangerArr;

    }];
    
    [self.navigationController pushViewController:addRecordController animated:YES];
    
}

/**
 *  点击cell 或者侧滑cell 的时候 进入编辑控制器
 *
 *  @param indexPath <#indexPath description#>
 */

- (GYHAddRecordController*)editRecordModel:(NSIndexPath *)indexPath{
    
    //修改病历
    
    GYHAddRecordController *edictController = [[GYHAddRecordController alloc] init];
    
    edictController.title = @"修改病历";
    
    edictController.recordModel = self.recordMangerArr[indexPath.row];
    
    [edictController setCallbackModel:^(GYHRecordModel * model) {
        
        //获取病历模型
        [self.recordMangerArr removeObjectAtIndex:indexPath.row];
        
        [self.recordMangerArr insertObject:model atIndex:indexPath.row];
        self.sortMtuArr = self.recordMangerArr;
        
    }];
    
    [edictController setCallbackDeletedModel:^(GYHRecordModel *model) {
        
        //删除 要删除的病历模型
        [self.recordMangerArr removeObjectAtIndex:indexPath.row];
        self.sortMtuArr = self.recordMangerArr;

    }];

    return edictController;
}



/**
 *  返回按钮
 *
 *  @param button <#button description#>
 */
- (void)didBackButton:(UIButton *)button {
    ICSDrawerController *drawer = (ICSDrawerController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    [drawer open];
    [self.navigationController popViewControllerAnimated:YES];
}


/**
 *  设置排序数组
 *
 *  @param sortMtuArr <#sortMtuArr description#>
 */
- (void)setSortMtuArr:(NSMutableArray *)sortMtuArr{
    _sortMtuArr = sortMtuArr;
    
    //编辑后归档
//    NSString *key = [UserAccount sharedUserAccount].screen_name;
      NSString *userId = [UserAccount sharedUserAccount].loginID ;
    
    NSString *paths = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSString *casesPath = [paths stringByAppendingPathComponent:[NSString stringWithFormat:@"%@Cases",userId]];
    [NSKeyedArchiver archiveRootObject:self.sortMtuArr toFile:casesPath];
    
       // NSLog(@"path = %@",casesPath);
    
    
    //排序功能等待实现
    
    [self.timeLineView reloadData];
}



#pragma mark - 懒加载
/**
 *  时间轴的TableView
 *
 *  @return <#return value description#>
 */
- (UITableView *)timeLineView{
    
    if (!_timeLineView) {
        _timeLineView = [[UITableView alloc] init];
        _timeLineView.delegate = self;
        _timeLineView.dataSource = self;
        _timeLineView.rowHeight = 150;
        _timeLineView.separatorStyle = UITableViewCellSeparatorStyleNone;
       _timeLineView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return _timeLineView;
}

/**
 *  储存病历数组
 *
 *  @return <#return value description#>
 */
- (NSMutableArray *)recordMangerArr{
    
    if (!_recordMangerArr) {
        
//        NSString *key =[UserAccount sharedUserAccount].screen_name;
        
        //根据userid 从本地解档
        NSString *userId = [UserAccount sharedUserAccount].loginID ;
        NSString *paths = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
        NSString *casesPath = [paths stringByAppendingPathComponent:[NSString stringWithFormat:@"%@Cases",userId]];
        _recordMangerArr = [NSKeyedUnarchiver unarchiveObjectWithFile:casesPath];
        
        //NSLog(@"path = %@",casesPath);

        
        if (_recordMangerArr == nil) {
             _recordMangerArr = [NSMutableArray array];
        }
       
    }
    
    return _recordMangerArr;
}

- (NSMutableArray *)sortMtuArr{
    
    if (_sortMtuArr == nil) {
        
        //NSString *key =[UserAccount sharedUserAccount].screen_name;
        
        //本地解档
        NSString *userId = [UserAccount sharedUserAccount].loginID ;
        NSString *paths = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
        NSString *casesPath = [paths stringByAppendingPathComponent:[NSString stringWithFormat:@"%@Cases",userId]];
        _sortMtuArr = [NSKeyedUnarchiver unarchiveObjectWithFile:casesPath];
        
      //  NSLog(@"path = %@",casesPath);
        
        if (_sortMtuArr == nil) {
            _sortMtuArr = [NSMutableArray array];
        }
    }
    
    return _sortMtuArr;
}

- (void)dealloc{
    
    NSLog(@"???????完了吗");
}

@end
