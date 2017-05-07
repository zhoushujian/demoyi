//
//  ZYapplyController.m
//  AVKY
//
//  Created by 周勇 on 16/8/5.
//  Copyright © 2016年 杰. All rights reserved.
//

#import "ZYArrowOneCell.h"
#import "ZYselectCell.h"
#import "ZYapplyController.h"
#import "YZNetworkTool.h"
#import "ZYfisetStageDesaseController.h"
#import "ZYsecondDeseaseController.h"
#import "ZYcureMethodSelect.h"
#import "ZYcomposeController.h"

@interface ZYapplyController ()
@property (nonatomic, assign) BOOL showFive;
@property (nonatomic, assign) BOOL cellInter;
@property (nonatomic, assign) BOOL isWei;
@end

@implementation ZYapplyController

- (void)viewDidLoad {
    [super viewDidLoad];
    //配置tableview
    [self setupTableView];
    [self addNotification];
}
-(void)addNotification{

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeShowFive:) name:@"show" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(cellinter:) name:@"cellInter" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(controllerJump:) name:@"buttonClickJump" object:nil];
}

#pragma mark - 配置tableview
-(void)setupTableView{
    
    self.showFive = NO;
    self.cellInter = NO;
    self.isWei = NO;
    
    self.tableView = [self.tableView initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    
    UINib * nib = [UINib nibWithNibName:@"ZYArrowOneCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"arrow"];
    UINib * nib1 = [UINib nibWithNibName:@"ZYselectCell" bundle:nil];
    [self.tableView registerNib:nib1 forCellReuseIdentifier:@"select"];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.tableHeaderView = [UIView new];
    self.tableView.bounces = NO;
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = 10;
    self.tableView.separatorStyle =  UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.scrollEnabled = NO;
    
   }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ZYArrowOneCell * cell = [tableView dequeueReusableCellWithIdentifier:@"arrow"];
    cell.userInteractionEnabled = NO;
    if (self.cellInter) {
        cell.userInteractionEnabled = YES;
    }
    switch (indexPath.section) {
        case 0:
            cell.userInteractionEnabled = YES;
            break;
        case 1:
            cell.userInteractionEnabled = YES;
            break;
        case 2:
            cell = [tableView dequeueReusableCellWithIdentifier:@"select"];
            if (!self.cellInter) {
                for (UIButton * buton in cell.subviews) {
                    buton.userInteractionEnabled = NO;
                }
            }else{
                for (UIButton * buton in cell.subviews) {
                    buton.userInteractionEnabled = YES;
                }
            }
            break;
        case 3:
            cell = [tableView dequeueReusableCellWithIdentifier:@"select"];
            if (!self.cellInter) {
                for (UIButton * buton in cell.subviews) {
                    buton.userInteractionEnabled = NO;
                }
            }else{
                for (UIButton * buton in cell.subviews) {
                    buton.userInteractionEnabled = YES;
                }
            }
            break;
        case 4:
            if (self.showFive == NO) {
                cell.hidden = YES;
            }else
            {
                cell.hidden = NO;
            }
            break;
        default:
            break;
    }
    cell.index = indexPath.section;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZYfisetStageDesaseController * fvc = [[ZYfisetStageDesaseController alloc]init];
//    self.navigationItem.backBarButtonItem =

//    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(JumpToCompose)];
    
    fvc.index = _index;
    ZYsecondDeseaseController * svc = [[ZYsecondDeseaseController alloc]init];
    ZYcureMethodSelect * cms = [[ZYcureMethodSelect alloc]init];
    switch (indexPath.section) {
        case 0:
            [SVProgressHUD setBackgroundColor:globalColor];
            [SVProgressHUD showWithStatus:@"玩命加载中!"];
            [self.navigationController pushViewController:fvc animated:YES];
            break;
        case 1:
            if (_isWei) {
                [SVProgressHUD setBackgroundColor:globalColor];
                [SVProgressHUD showWithStatus:@"玩命加载中!"];
                [self.navigationController pushViewController:svc animated:YES];
            }else{
                if (_cellInter) {
                    [SVProgressHUD showSuccessWithStatus:@"无并发症"];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [SVProgressHUD dismiss];
                    });
                }else
                {
                    [SVProgressHUD showSuccessWithStatus:@"请选择疾病类型"];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [SVProgressHUD dismiss];
                    });
                }
            }
            break;
        case 2:
        case 3:
            if (!self.cellInter) {
                [SVProgressHUD showSuccessWithStatus:@"请选择疾病类型"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [SVProgressHUD dismiss];
                });
            }
            break;
        case 4:
            [self.navigationController pushViewController:cms animated:YES];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (self.showIcon) {
                    self.showIcon(NO);
                }
            });
            break;
    }
}

-(void)setIndex:(NSInteger)index
{
    _index = index;
}
#pragma mark - 代理方法
-(void)changeShowFive:(NSNotification *)notification{
    
    if (notification.userInfo[@"show"]) {
        NSNumber * number = notification.userInfo[@"show"];
        BOOL isShow = number.boolValue;
        self.showFive = isShow;
        NSIndexPath * isx = [NSIndexPath indexPathForRow:0 inSection:4];
        [self.tableView reloadRowsAtIndexPaths:@[isx] withRowAnimation:UITableViewRowAnimationNone];
    }
}
-(void)cellinter:(NSNotification *)notification{
    if (notification.userInfo[@"inter"]) {
        NSNumber * number = notification.userInfo[@"inter"];
        BOOL cellInter = number.boolValue;
        self.cellInter = cellInter;
        
        NSIndexPath * isx2 = [NSIndexPath indexPathForRow:0 inSection:2];
        NSIndexPath * isx3 = [NSIndexPath indexPathForRow:0 inSection:3];
        NSIndexPath * isx4 = [NSIndexPath indexPathForRow:0 inSection:4];
        [self.tableView reloadRowsAtIndexPaths:@[isx2,isx3,isx4] withRowAnimation:UITableViewRowAnimationNone];
        if ([notification.userInfo[@"info"]  isEqualToString: @"胃恶性肿瘤"]){
            self.isWei = cellInter;
        }else
        {
            NSIndexPath * isx1 = [NSIndexPath indexPathForRow:0 inSection:1];
            [self.tableView reloadRowsAtIndexPaths:@[isx1] withRowAnimation:UITableViewRowAnimationNone];
            self.isWei = !cellInter;
        }
    }
}

-(void)controllerJump:(NSNotification *)notification{

    if (notification.userInfo[@"jump"]) {
        NSInteger index = [notification.userInfo[@"jump"] integerValue];
        [self tableView:self.tableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index]];
    }
}
/**
 *  消除遮盖 移除通知
 */
-(void)dealloc{
    
    [SVProgressHUD dismiss];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"show" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"cellInter" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"cellInter" object:nil];
}

//-(void)JumpToCompose{
//    ZYcomposeController * com  = [[ZYcomposeController alloc]init];
//    [self.navigationController pushViewController:com animated:YES];
//    
//}
@end
