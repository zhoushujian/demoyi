//
//  ZYsecondDeseaseController.m
//  AVKY
//
//  Created by 周勇 on 16/8/5.
//  Copyright © 2016年 杰. All rights reserved.
//

#import "ZYsecondDeseaseController.h"
#import "YZNetworkTool.h"
#import "YZNetworkTool+desaese.h"
#import "ZYsecondStageDisease.h"

@interface ZYsecondDeseaseController ()
@property (nonatomic, strong) NSMutableArray *secondArr;
@property (nonatomic, strong) NSMutableArray *textArr;
@property (nonatomic, assign) BOOL isWei;
@end

@implementation ZYsecondDeseaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isWei = NO;
    [[YZNetworkTool sharedManager]requestSecondageDeseaseWith:1 Cllback:^(id responseBody) {
        if (responseBody) {
            self.secondArr = responseBody;
            [self.tableView reloadData];
            [SVProgressHUD dismiss];
        }
    }];
    
    self.navigationItem.rightBarButtonItem  = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(backToController)];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"second"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.secondArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"second" forIndexPath:indexPath];
    ZYsecondStageDisease * sd = self.secondArr[indexPath.row];
    cell.textLabel.text = sd.complication_name;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZYsecondStageDisease * sd = self.secondArr[indexPath.row];
    
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell.accessoryView == nil) {
        cell.accessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ok"]];
        [self.textArr addObject:sd.complication_name];
    }else
    {
        [self.textArr removeObject:sd.complication_name];
        cell.accessoryView = nil;
    }
    
}

-(void)backToController{
    
    NSDictionary * para = @{@"arr":self.textArr};
    [[NSNotificationCenter defaultCenter] postNotificationName:deseaseNotificationKey object:nil userInfo:para];
    [self.navigationController popViewControllerAnimated:YES];
}

-(NSMutableArray *)textArr{
    
    if (_textArr == nil) {
        _textArr = [NSMutableArray array];
    }
    return _textArr;
}

-(void)viewWillDisappear:(BOOL)animated
{
    
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}

@end
