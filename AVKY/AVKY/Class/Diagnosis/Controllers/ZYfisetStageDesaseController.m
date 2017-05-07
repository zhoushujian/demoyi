//
//  ZYfisetStageDesaseController.m
//  AVKY
//
//  Created by 周勇 on 16/8/5.
//  Copyright © 2016年 杰. All rights reserved.
//

#import "ZYfisetStageDesaseController.h"
#import "YZNetworkTool.h"
#import "YZNetworkTool+desaese.h"
#import "ZYfirstStageDisease.h"
#import "ZYcomposeController.h"
@interface ZYfisetStageDesaseController ()<UITextFieldDelegate>
/**
 *  模型数组
 */
@property (nonatomic, strong) NSMutableArray *modelArr;
/**
 *  新数组
 */
@property (nonatomic, strong) NSMutableArray *newlArr;
/**
 *  UITextField
 */
@property (nonatomic, strong) UITextField * tx;
/**
 *  原始数据
 */
@property (nonatomic, strong)  NSMutableArray *origArr;
/**
 *  富文本数组
 */
@property (nonatomic, strong) NSMutableArray *attArr;

//@property (nonatomic, strong) UILongPressGestureRecognizer *longPress;
@end

@implementation ZYfisetStageDesaseController
/**
 *  获取数据,添加配置textfield,添加搜索按钮
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[YZNetworkTool sharedManager] requestFirstageDeseaseWith:_index Cllback:^(id responseBody) {
        self.modelArr = responseBody;
        self.origArr = responseBody;
        [self.tableView reloadData];
        [SVProgressHUD dismiss];
    }];
    
    [self setUP];
}
/**
 *  配置UI
 */
-(void)setUP{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(compose)];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tx = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, screenW* 0.3, 40)];
    self.tx.layer.cornerRadius = 10;
    self.tx.clipsToBounds = YES;
    self.tx.backgroundColor = [UIColor whiteColor];
    self.navigationItem.titleView = self.tx;
    self.tx.placeholder = @"🔍请输入你要搜索的内容😄";
    self.tx.textAlignment = NSTextAlignmentCenter;
    self.tx.delegate = self;
    self.tx.returnKeyType = UIReturnKeySearch;
    self.tx.enablesReturnKeyAutomatically = YES;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"搜索" style:UIBarButtonItemStylePlain target:self action:@selector(search)];
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:nil];
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.modelArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    ZYfirstStageDisease * first = self.modelArr[indexPath.row];
    cell.textLabel.text= first.ci3_name;
    cell.accessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"arrow_right"]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ZYfirstStageDisease * first = self.modelArr[indexPath.row];
    NSString * firstTitleText = first.ci3_name;
    NSDictionary * para = @{@"key":firstTitleText};
    [[NSNotificationCenter defaultCenter] postNotificationName:deseaseNotificationKey object:nil userInfo:para];
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}

-(void)setIndex:(NSInteger)index{
    _index = index;
}
/**
 *  右侧搜索按钮
 */
-(void)search{
    
    self.newlArr = [NSMutableArray array];
    self.modelArr = self.origArr;
    self.attArr = [NSMutableArray array];
    NSString * con = self.tx.text;
    
    for (ZYfirstStageDisease * model in self.modelArr) {
        
        for (int i = 0; i < con.length; ++i) {
            NSRange range = NSMakeRange(i, 1);
            NSString *one = [con substringWithRange:range];
            NSLog(@"%@",one);
            if ([model.ci3_name containsString:one]) {
                
                NSMutableAttributedString * ms = [[NSMutableAttributedString alloc]initWithString:model.ci3_name];
                NSRange  range = [model.ci3_name rangeOfString:one];
                if ([model.ci3_name containsString:con]) {
                    range = [model.ci3_name rangeOfString:con];
                }
                [ms addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:[UIColor redColor]} range:range];
                [self.attArr addObject:ms];
                [self.newlArr addObject:model];
            }
        }
    }
    for (int i = 0; i < self.newlArr.count; ++i) {
        NSMutableAttributedString * ms = self.attArr[i];
        UITableViewCell * cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        cell.textLabel.attributedText = ms;
    }
    self.modelArr = self.newlArr;
    if (self.modelArr.count == 0) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    [self.tableView reloadData];
    [self.tx endEditing:YES];
    
}
/**
 *  懒加载
 */
-(NSMutableArray *)origArr{
    
    if (_origArr == nil) {
        _origArr = [NSMutableArray array];
    }
    return _origArr;
}
/**
 *  监听键盘搜索键
 */
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self search];
    return YES;
}
/**
 *  滚动tableview消除键盘
 */
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.tx endEditing:YES];
}

-(void)compose{
    
    
    ZYcomposeController * com = [[ZYcomposeController alloc]init];
    com.dataArr = self.modelArr;
    [self.navigationController pushViewController:com animated:YES];
}
@end
