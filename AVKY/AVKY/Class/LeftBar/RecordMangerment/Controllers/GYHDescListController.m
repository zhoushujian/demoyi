//
//  GYHDescListController.m
//  AVKY
//
//  Created by Marcello on 16/8/7.
//  Copyright © 2016年 杰. All rights reserved.
//

#import "GYHDescListController.h"

@interface GYHDescListController ()<UITableViewDelegate,UITableViewDataSource>

/**
 *  字符数组
 */
@property (nonatomic, strong) NSMutableArray *stringArray;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *callBackArray;

@end

@implementation GYHDescListController



- (void)viewDidLoad{
    
    [self.view addSubview:self.tableView];
    
    [self setupNav];
}

/**
 *  初始化nagationBar
 */
- (void)setupNav{
    
    UIButton *button = [[UIButton alloc] init];
    button.frame = CGRectMake(0, 0, 50, 30);
    
    [button setTitle:@"确定" forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(didClickSure:) forControlEvents:UIControlEventTouchUpInside];

    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    self.navigationItem.rightBarButtonItem = rightItem;
    
}

#pragma mark - tableViewDeledate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.stringArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
 
    
    UITableViewCell *cell  =[tableView dequeueReusableCellWithIdentifier:@"ll"];
    
    if (cell ==nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ll"];
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = globalColor;
        cell.selectedBackgroundView = view;
    }
    
    cell.textLabel.text = self.stringArray[indexPath.row];
    
    if (self.cacheStringArray) {
        
        [self.cacheStringArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            NSString *text = self.stringArray[indexPath.row];
            
            if ([text isEqualToString:obj]) {
                
                cell.accessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ok"]];
                [self.callBackArray addObject:self.stringArray[indexPath.row]];
            }
        }];
    }
    
    return cell;
}



#pragma mark - UItableViewdelegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    

    
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell.accessoryView == nil) {
        cell.accessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ok"]];
        [self.callBackArray addObject:self.stringArray[indexPath.row]];
    }else
    {
        [self.callBackArray removeObject:self.stringArray[indexPath.row]];
        cell.accessoryView = nil;
    }
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    

}


#pragma mark - 响应方法

- (void)didClickSure:(UIButton *)button{
    
    if (self.getStringArr) {
        
        self.getStringArr(self.callBackArray);
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

- (NSArray *)stringArray{
    
    if (!_stringArray) {
        
        _stringArray = [NSMutableArray arrayWithArray:@[@"腹痛",@"厌食",@"乏力",@"体重减轻",@"恶心",@"欧呕吐",@"呕血"]];
        
    }
    return _stringArray;
}


- (NSMutableArray *)callBackArray{
    
    if (!_callBackArray) {
        
        _callBackArray = [NSMutableArray array];
    }
    
    return _callBackArray;
}

@end
