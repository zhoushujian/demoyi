//
//  GYHTybeillnessController.m
//  AVKY
//
//  Created by Marcello on 16/8/5.
//  Copyright © 2016年 杰. All rights reserved.
//

#import "GYHTybeillnessController.h"

@interface GYHTybeillnessController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;


@property (nonatomic, strong) NSArray *IllnesString;

@end

@implementation GYHTybeillnessController

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    [self setNavgationBar];
    [self.view addSubview: self.tableView];
    
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

- (void)didBackButton:(UIButton *)button {
    
    
//    ICSDrawerController *drawer = (ICSDrawerController *)[UIApplication sharedApplication].keyWindow.rootViewController;
//    [drawer open];
//    [self setNavgationBar];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableViewDatascoure

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.IllnesString.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cella"];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cella"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.textLabel.text = self.IllnesString[indexPath.row];
    
    return cell;
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.getTypeString) {
        self.getTypeString(self.IllnesString[indexPath.row],indexPath.row + 1);
    }
    
     [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - 懒加载

- (UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] init];
        _tableView.frame = self.view.bounds;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        
    }
    return _tableView;
}


- (NSArray *)IllnesString{
    
    if (!_IllnesString) {
        
        _IllnesString = @[@"肿瘤病",@"血液病",@"心脑血管病",@"神经系统",@"骨科"];
    }
    return _IllnesString;
}






@end
