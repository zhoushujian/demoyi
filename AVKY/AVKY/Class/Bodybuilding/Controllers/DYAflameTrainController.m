//
//  DYAflameTrainController.m
//  AVKY
//
//  Created by Yangdongwu on 16/8/4.
//  Copyright © 2016年 杰. All rights reserved.
// http://c.m.163.com/nc/article/list/T1348649079062/0-20.html

#import "DYAflameTrainController.h"
#import "GymDetailViewController.h"
#import "GymTableViewCell.h"
#import "GymNewsModel.h"

@interface DYAflameTrainController ()
///  新闻数据
@property (nonatomic, strong) NSArray *news;

@end

@implementation DYAflameTrainController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavigationBar];
    [self loadData];
 
}


///  加载新闻数据
- (void)loadData {
    NSString *URLString = @"http://c.m.163.com/nc/article/list/T1348649079062/0-20.html";
    [GymNewsModel loadNewsWithURLString:URLString success:^(NSArray *news) {
        ///  记录新闻数据
        self.news = news;
        ///  刷新表格
        [self.tableView reloadData];
    } failed:^(NSError *error) {
        NSLog(@"error = %@",error);
    }];
}

- (void)setNavigationBar {
    self.navigationItem.title = @"燃脂训练";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -UITableViewDataSource方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.news.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GymNewsModel *model = self.news[indexPath.row];
    GymTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[GymTableViewCell identifierWithNew:model]];
    cell.newsModel = model;
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    GymNewsModel *model = self.news[indexPath.row];
    return [GymTableViewCell rowHeigth:model];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GymNewsModel *model = self.news[indexPath.row];
    GymDetailViewController *detailVc = [[GymDetailViewController alloc]init];
    detailVc.URLString = model.detailURLString;
    NSLog(@"%@",model.detailURLString);
    [self.navigationController pushViewController:detailVc animated:YES];
}

@end
