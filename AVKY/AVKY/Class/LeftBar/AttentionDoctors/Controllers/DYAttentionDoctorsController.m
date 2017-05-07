//
//  DYAttentionDoctorsController.m
//  AVKY
//
//  Created by Yangdongwu on 16/8/5.
//  Copyright © 2016年 杰. All rights reserved.
//

#import "DYAttentionDoctorsController.h"
#import "YZNetworkTool+Attention.h"
#import "YZNetworkTool.h"
#import "DYAttentionDoctorListCell.h"
#import "DYDoctorDetailController.h"
#import "DYDoctor.h"
#import <MJRefresh.h>

#define attentionDoctorsTableViewCellIdentifier @"attentionDoctorsTableViewCellIdentifier"

@interface DYAttentionDoctorsController () <UITableViewDelegate,UITableViewDataSource>

/**
 *  关注医生tableView
 */
@property (nonatomic, strong) UITableView *attentionDoctorsTableView;
/**
 *  医生模型数组
 */
@property (nonatomic, strong) NSArray *doctorMedels;

@end

@implementation DYAttentionDoctorsController

#pragma mark - viewDidLoad方法
- (void)viewDidLoad {
    [super viewDidLoad];

#warning 测试修改参数,记得改回来
    //如果pushFrom为0那么就是从关注医生界面条过来的
    if (self.pushFrom == 0) {
        self.pushFrom = DYPushFromAttentionDoctor;
    }
//    self.pushFrom = DYPushFromSickCall;
    //设置UI
    [self setupUI];
    //网络请求
    [self netRequest];

    
}

#pragma mark - 网络请求
- (void)netRequest {
    
    //根据不同的类型选择不同的接口
    NSString *url = @"";
    NSDictionary *parameters = [[NSDictionary alloc] init];
    
    if (self.pushFrom == DYPushFromSickCall) {
        //就诊医生列表
        url = @"http://iosapi.itcast.cn/doctor/matchDoctors.json.php";
        parameters = @{@"ci1_id":@1,@"ci2_id":@3,@"ci3_id":@3,@"diagnosis_type":@0,@"page_size":@15,@"is_confirmed":@1,@"user_id":@1000089, @"page":@1,@"has_diagnosis":@2};
    }
    else if (self.pushFrom == DYPushFromAttentionDoctor) {
        //关注医生列表
        url = @"http://iosapi.itcast.cn/doctor/doctorList.json.php";
        parameters = @{@"user_id":@1000089,@"page_size":@15,@"page":@1};
    }
    
    //显示遮罩层
    [SVProgressHUD setInfoImage:[UIImage imageNamed:@"0"]];
    [SVProgressHUD showInfoWithStatus:@"正在加载医生列表..."];
//    //设置遮罩属性
//    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
//    [SVProgressHUD setBackgroundColor:globalColor];
//    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    
    
    NSMutableArray *tempArray = [NSMutableArray new];
    
    [[YZNetworkTool sharedManager] requestDoctorListWithUrl:url parameters:parameters callBack:^(id responseBody) {
        
        if([responseBody isKindOfClass:[NSError class]]) {
            [SVProgressHUD showErrorWithStatus:@"您的网络有问题"];
            delay(1.0);
            [self.attentionDoctorsTableView.mj_header endRefreshing];
            [self.attentionDoctorsTableView.mj_footer endRefreshing];
            return;
        }
        
        
        NSArray *dataArray = responseBody[@"data"];
        for (int i = 0; i < dataArray.count; ++i) {
            DYDoctor *doctor = [DYDoctor yy_modelWithDictionary:dataArray[i]];
            [tempArray addObject:doctor];
        }
        self.doctorMedels = [tempArray copy];
        
        
        //处理医院名字的key不同的bug
        for (DYDoctor *doctor in self.doctorMedels) {
            if (self.pushFrom == DYPushFromAttentionDoctor) {
                doctor.doctor_hospital_name = doctor.hospital_name;
            }
            else if (self.pushFrom == DYPushFromSickCall){
                doctor.hospital_name = doctor.doctor_hospital_name;
            }
            
        }
        
        //刷新数组
        [self.attentionDoctorsTableView reloadData];
        
        [SVProgressHUD showSuccessWithStatus:@"加载成功"];
        delay(1.0);
        [self.attentionDoctorsTableView.mj_header endRefreshing];
        [self.attentionDoctorsTableView.mj_footer endRefreshing];
        
    }];
    
 
}

#pragma mark - 设置UI
- (void)setupUI {
    //设置tableView
    [self setupTableView];
}

- (void)setupTableView {
    
    [self.view addSubview:self.attentionDoctorsTableView];
    
    self.attentionDoctorsTableView.frame = self.view.bounds;
    
    //注册cell
    [self.attentionDoctorsTableView registerClass:[DYAttentionDoctorListCell class] forCellReuseIdentifier:attentionDoctorsTableViewCellIdentifier];
    
    //================== 上下拉刷新 =================//
    self.attentionDoctorsTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(netRequest)];
    self.attentionDoctorsTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(netRequest)];
    
}

#pragma mark - tableView数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.doctorMedels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DYAttentionDoctorListCell *cell = [tableView dequeueReusableCellWithIdentifier:attentionDoctorsTableViewCellIdentifier];
    
    cell.doctor = self.doctorMedels[indexPath.row];
    
    return cell;
}

#pragma mark - tableView代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    DYDoctorDetailController *doctorDetailController = [[DYDoctorDetailController alloc] init];
    
    doctorDetailController.pushFrom = self.pushFrom;
    
    doctorDetailController.doctor = self.doctorMedels[indexPath.row];
    
    [self.navigationController pushViewController:doctorDetailController animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

#pragma mark - 内存警告
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark - 懒加载
- (UITableView *)attentionDoctorsTableView {
    if (_attentionDoctorsTableView == nil) {
        _attentionDoctorsTableView = [[UITableView alloc] init];
        _attentionDoctorsTableView.dataSource = self;
        _attentionDoctorsTableView.delegate = self;
    }
    return _attentionDoctorsTableView;
}

- (NSArray *)doctorMedels {
    if (_doctorMedels == nil) {
        _doctorMedels = [[NSArray alloc] init];
    }
    return _doctorMedels;
}

@end
