//
//  ZYcureMethodSelect.m
//  AVKY
//
//  Created by 周勇 on 16/8/7.
//  Copyright © 2016年 杰. All rights reserved.
//

#import "ZYcureMethodSelect.h"

@interface ZYcureMethodSelect ()
@property (nonatomic, strong) NSMutableArray *selectArr;
@end

@implementation ZYcureMethodSelect


-(void)viewDidLoad{
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"method"];
    [self.selectArr addObjectsFromArray:@[@"手术治疗",@"保守治疗",@"药物治疗"]];
    
}

#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"method"];
    
    cell.textLabel.text = self.selectArr[indexPath.row];
    cell.accessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"arrow_right"]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [[NSNotificationCenter defaultCenter]postNotificationName:deseaseNotificationKey object:nil userInfo:@{@"method":self.selectArr[indexPath.row]}];
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(NSMutableArray *)selectArr
{
    if (_selectArr == nil) {
        _selectArr = [NSMutableArray array];
    }
    return _selectArr;
}

@end
