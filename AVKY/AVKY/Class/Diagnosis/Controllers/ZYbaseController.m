//
//  ZYbaseController.m
//  ZYMY
//
//  Created by 周勇 on 16/8/4.
//  Copyright © 2016年 周勇. All rights reserved.
//

#define screenHeight [UIScreen mainScreen].bounds.size.height
#import "ZYbaseController.h"
#import "Masonry.h"
#import "ZYArrowOneCell.h"
#import "ZYselectCell.h"
#import "ZYapplyController.h"
#import "ZYfisetStageDesaseController.h"
#import "DYAttentionDoctorsController.h"

@interface ZYbaseController ()
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIButton *bottomButton;
@property (nonatomic, assign) BOOL cellInter;
@end

@implementation ZYbaseController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.view.backgroundColor = [UIColor whiteColor];
    //创建子空间
    [self setupSubViews];
    // 显示tabbar遮盖的内容
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self addNotification];
}

#pragma mark - 接收通知
-(void)addNotification{
    //showBottom
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showButtomViews:) name:@"showBottom" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(cellinter:) name:@"cellInter" object:nil];
}
#pragma mark - 创建subviews
-(void)setupSubViews{
    //创建一个label
    UILabel * diseaseLabel = [[UILabel alloc]init];
    diseaseLabel.text = [NSString stringWithFormat:@"疾病类型:%@",self.title];
    NSArray * titleArr = @[@"肿瘤",@"血液科",@"心血管",@"神经科",@"骨科",@"公益活动"];
    NSInteger index = [titleArr indexOfObject:self.title];
    [diseaseLabel sizeToFit];
    
    //创建一个tableview
    ZYapplyController * avc = [[ZYapplyController alloc]init];
    avc.index = index;
    [self addChildViewController:avc];
    UITableView * zytableview = avc.tableView;
    self.view.backgroundColor = avc.tableView.backgroundColor;
    //创建一个view,里面有两个label和一个imageview
    UIView * zyview = [UIView new];
    self.bottomView = zyview;
    zyview.backgroundColor = avc.tableView.backgroundColor;
    UILabel * titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"重症诊所为您匹配到";
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.textColor = [UIColor darkGrayColor];
    UILabel * numberLabel = [[UILabel alloc]init];
    numberLabel.text = @"24位医生";
    numberLabel.font = [UIFont systemFontOfSize:24];
    numberLabel.textColor = [UIColor greenColor];
    UIImageView * docIcon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"doctorCount"]];;
    [titleLabel sizeToFit];
    [numberLabel sizeToFit];
    [docIcon sizeToFit];
    [zyview addSubview:titleLabel];
    [zyview addSubview:numberLabel];
    [zyview addSubview:docIcon];
    //创建一个button用于跳转公益页面
    UIButton * button = [[UIButton alloc]init];
    self.bottomButton = button;
    [button setTitle:@"就诊申请" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(jumpTodetail:) forControlEvents:UIControlEventTouchUpInside];
    //    [button setBackgroundImage:[UIImage imageNamed:@"buttonBackground"] forState:UIControlStateNormal];
    //    [button setBackgroundImage:[UIImage imageNamed:@"verify_code_button_highlighted"] forState:UIControlStateNormal];
    button.backgroundColor = [UIColor colorWithWhite:0.7 alpha:0.7];
    button.userInteractionEnabled = NO;
    //添加子空间
    //    [self.view addSubview:diseaseLabel];
    [self.view addSubview:zytableview];
    [self.view insertSubview:diseaseLabel aboveSubview:zytableview];
    [self.view addSubview:zyview];
    [self.view addSubview:button];
    
    // 判断显示底部view
    zyview.hidden = YES;
    //    button.hidden = YES;
    avc.showIcon = ^(BOOL isShow){
        zyview.hidden = isShow;
        //        button.hidden = isShow;
        [button setBackgroundImage:[UIImage imageNamed:@"buttonBackground"] forState:UIControlStateNormal];
        button.userInteractionEnabled = !isShow;
    };
    //添加约束
    [diseaseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.top.equalTo(self.view).offset(10);
        make.height.mas_equalTo(20);
    }];
    [zytableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(diseaseLabel).offset(5);
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
        make.height.mas_equalTo(screenHeight*0.6);
    }];
    [zyview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.mas_equalTo(-40);
        make.height.mas_equalTo(screenHeight*0.25);
    }];
    
    //添加zyviw子类的约束titleLabel numberLabel docIcon
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(zyview.mas_centerX);
        make.top.equalTo(zyview.mas_top).mas_offset(10);
        
    }];
    [numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(zyview.mas_centerX);
        make.top.equalTo(titleLabel.mas_bottom).mas_offset(10);
    }];
    [docIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(zyview.mas_centerX);
        make.top.equalTo(numberLabel.mas_bottom).mas_offset(10);
    }];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.left.equalTo(self.view).mas_offset(20);
        make.right.equalTo(self.view).mas_offset(-20);
        make.height.mas_equalTo(40);
        make.bottom.equalTo(self.view).offset(-10);
    }];
}

#pragma mark - 加载疾病列表页面
-(void)jumpTodetail:(UIButton *)button{
    DYAttentionDoctorsController * detail = [[DYAttentionDoctorsController alloc]init];
    detail.pushFrom = DYPushFromSickCall;
    [self.navigationController pushViewController:detail animated:YES];
}
#pragma mark - 代理方法
-(void)showButtomViews:(NSNotification *)notification{
    
    BOOL show = [notification.userInfo[@"bottom"] intValue];
    self.bottomView.hidden = show;
    [self.bottomButton setBackgroundImage:[UIImage imageNamed:@"buttonBackground"] forState:UIControlStateNormal];
    self.bottomButton.userInteractionEnabled = !show;
    
}

#pragma mark - 通知事件处理
-(void)cellinter:(NSNotification *)notification{
    if (notification.userInfo[@"inter"]) {
        NSNumber * number = notification.userInfo[@"inter"];
        BOOL cellInter = number.boolValue;
        self.cellInter = cellInter;
        self.bottomView.hidden = cellInter;
        self.bottomButton.backgroundColor = [UIColor colorWithWhite:0.7 alpha:0.7];
        self.bottomButton.userInteractionEnabled = !cellInter;
        [self.bottomButton setBackgroundImage:nil forState:UIControlStateNormal];
    }
}
/**
 *  移除通知
 */
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"showBottom" object:nil];
}
@end
