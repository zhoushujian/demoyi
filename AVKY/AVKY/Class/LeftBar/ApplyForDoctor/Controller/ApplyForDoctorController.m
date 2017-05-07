//
//  ApplyForDoctorController.m
//  AVKY
//
//  Created by zheng on 16/8/8.
//  Copyright © 2016年 杰. All rights reserved.
//

#import "ApplyForDoctorController.h"
#import "YZNetworkTool.h"
#import "YZNetworkTool+Attention.h"
#import "ZYADoctor.h"
#import "ZYADoctorCell.h"


@interface ApplyForDoctorController ()<UITableViewDataSource,UITableViewDelegate>

//tableview
@property(nonatomic,strong)UITableView *tableView;

//doctor数组
@property(nonatomic,strong)NSMutableArray *doctorArr;

@end

@implementation ApplyForDoctorController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.view.backgroundColor = [UIColor whiteColor];

    [self.view addSubview:self.tableView];
    [self request];
    
}

#pragma mark -网络请求方法
-(void)request {
    NSString *urlStr = @"http://iosapi.itcast.cn/doctor/matchDoctors.json.php";
    
    NSDictionary *parameters = @{@"ci1_id":@1,@"ci2_id":@3,@"ci3_id":@3,@"diagnosis_type":@0,@"page_size":@15,@"is_confirmed":@1,@"user_id":@1000089, @"page":@1,@"has_diagnosis":@2};

    [[YZNetworkTool sharedManager] requestDoctorListWithUrl:urlStr parameters:parameters callBack:^(id responseBody) {
        
        if([responseBody isKindOfClass:[NSError class]]) {
            [SVProgressHUD showErrorWithStatus:@"您的网络有问题"];
              delay(1.0);
            return;
        }
        
        //调用第三方弹出提示框
       [SVProgressHUD showWithStatus:@"正在加载中...."];
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
        delay(1.5);
        NSArray *dataArray = responseBody[@"data"];
        
        NSMutableArray *mtArray = [NSMutableArray new];
        for (int i = 0; i < dataArray.count; i++) {
            
            ZYADoctor *doctor = [ZYADoctor yy_modelWithDictionary:dataArray[i]];
            
            [mtArray addObject:doctor];
        }
        self.doctorArr = mtArray;
        [self.tableView reloadData];
        
    }];
}

#pragma mark -UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.doctorArr.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ZYADoctor *doctor = self.doctorArr[indexPath.row];
    ZYADoctorCell *cell = [ZYADoctorCell doctorCellWithTableView:tableView];
    
    cell.doctor = doctor;
    
    return cell;
}

#pragma mark -UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.001;
}

#pragma mark -懒加载
-(UITableView*)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    }
    return _tableView;
}

-(NSMutableArray*)doctorArr {
    if (_doctorArr == nil) {
        _doctorArr = [[NSMutableArray alloc]init];
    }
    return _doctorArr;
}

@end
