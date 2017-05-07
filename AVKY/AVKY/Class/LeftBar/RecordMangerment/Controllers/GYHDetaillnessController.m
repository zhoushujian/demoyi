//
//  GYHDetaillnessController.m
//  AVKY
//
//  Created by Marcello on 16/8/5.
//  Copyright © 2016年 杰. All rights reserved.
//

#import "GYHDetaillnessController.h"
#import "YZNetworkTool.h"
#import <MJRefresh.h>
#import "GYHillnessModel.h"

@interface GYHDetaillnessController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>


/**
 *  tableView
 */
@property (nonatomic, strong) UITableView *tableView;

/**
 *  搜索框
 */
@property (nonatomic, strong) UITextField *seachBar;

@property (nonatomic, strong) NSArray *URLString;

/**
 *  搜索结果数组
 */
@property (nonatomic, strong) NSMutableArray *searchResult;
/**
 *  搜索字符
 */
@property (nonatomic, copy) NSString *searchText;

/**
 *  疾病模型数组
 */
@property (nonatomic, strong) NSMutableArray *illnessArray;

/**
 *  请求数据inedex
 */
@property (nonatomic, assign) NSInteger pageIndex;

/**
 *  请求最大数
 */
@property (nonatomic,assign ) NSInteger maxPageIndex;

@property (nonatomic, assign) NSInteger lastId;


@end

@implementation GYHDetaillnessController

@synthesize searchText = _searchText;

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
    [SVProgressHUD show];
    //请求最大数
    self.maxPageIndex = 50;
    //初始化请求数
    self.pageIndex = 1;
    
    [self setNavgationBar];
    
    [self.view addSubview:self.tableView];
    //设置上下拉刷新
    [self setupMJRefresh];
    //加载数据
    //[self loadData];
    
    //    [NSMutable]
}

/**
 *  设置上下啦刷新
 */
- (void)setupMJRefresh{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getMoreIllnessModel)];
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    [footer setTitle:@"数据加载完毕" forState:MJRefreshStateNoMoreData];
    self.tableView.mj_footer = footer;
    [self.tableView.mj_footer beginRefreshing];
}





/**
 *  加载数据
 */
- (void)loadData{
    if (self.maxPageIndex <= self.pageIndex) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
        return;
    }
    NSString *urlString = @"http://iosapi.itcast.cn/doctor/searchCI3List.json.php";
    NSDictionary *parameters = @{@"page":@(self.pageIndex),@"page_size":@15,@"ci1_id":@(self.illnessIndex),@"keyword":self.searchText};
    YZNetworkTool *manger = [YZNetworkTool sharedManager];
    //设置请求类型
    manger.requestSerializer = [AFJSONRequestSerializer serializer];
    [manger request:urlString type:NetworkToolTypePost Paramer:parameters callBack:^(id responseBody) {
        
        //NSArray *arr = responseBody[@"data"];
       
        //请求数据错误
        if ([responseBody isKindOfClass:[NSError class]]) {
          
            NSLog(@"error = %@",responseBody);
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
             [SVProgressHUD showErrorWithStatus:@"网络错误"];
            delay(1);
                [self.navigationController popViewControllerAnimated:YES];
            return ;
        }
        
        //判断有没数据
        
        //获取数据成功
        if (![responseBody[@"msg"] isEqualToString:@"FAIL"]) {
            
            if ([responseBody[@"data"] isEqual:[NSNull null]]) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
                self.maxPageIndex = self.pageIndex;
                return ;
            }
            [self.searchResult removeAllObjects];
            NSArray *dataArr = responseBody[@"data"];
            for (NSDictionary* dic in dataArr) {
                
                GYHillnessModel *model = [GYHillnessModel yy_modelWithDictionary: dic];
                
                if (model.ci3_id > self.lastId) {
                    [self.illnessArray addObject:model];
                    self.lastId = model.ci3_id;
                }
            }
            [self.tableView.mj_footer endRefreshing];
            self.pageIndex = self.pageIndex +1;
            
            [SVProgressHUD showSuccessWithStatus:@"加载成功"];
            delay(1);
            
            [self.tableView reloadData];
        }else{
            [SVProgressHUD showErrorWithStatus:@"网络错误"];
        }
    }
     
     ];
    
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
    
    self.navigationItem.titleView = self.seachBar;
    
    UIButton *rightButton= [[UIButton alloc] init];
    rightButton.frame = CGRectMake(0, 0, 50, 40);

    [rightButton setTitle:@"搜索" forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(didClickSearchButton:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *searchItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    
    self.navigationItem.rightBarButtonItem = searchItem;
    
}


#pragma mark - UITableViewdelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (self.searchResult.count>0) {
        
        return self.searchResult.count;
    }
    
    return self.illnessArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"gh"];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"gh"];
    }
    if (self.searchResult.count != 0) {
        cell.textLabel.attributedText = self.searchResult[indexPath.row];
    }else{
        cell.textLabel.attributedText = nil;
        GYHillnessModel *model =  self.illnessArray[indexPath.row];
        cell.textLabel.text = model.ci3_name;
    }
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *chooseString;
    if (self.searchResult.count > 0) {
        chooseString = [self.searchResult[indexPath.row] string];
    }else{
        GYHillnessModel *model = self.illnessArray[indexPath.row];
        
        chooseString = model.ci3_name;
    }
    
    if (self.getInessString) {
        self.getInessString(chooseString,indexPath.row);
    }
    [self.navigationController popViewControllerAnimated:YES];
}


/**
 *  返回按钮
 *
 *  @param button <#button description#>
 */
- (void)didBackButton:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 *  点击搜索按钮
 *
 *  @param button <#button description#>
 */
- (void)didClickSearchButton:(UIButton*)button{
    [self textFieldShouldReturn:self.seachBar];
}
#pragma mark - 懒加载

- (NSMutableArray *)illnessArray{
    
    if (!_illnessArray) {
        _illnessArray = [NSMutableArray array];
    }
    return _illnessArray;
}


- (UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] init];
        
        _tableView.frame = self.view. bounds;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    
    return _tableView;
}


- (UITextField *)seachBar{
    
    if (!_seachBar) {
        
        _seachBar = [[UITextField alloc] init];
        _seachBar.borderStyle = UITextBorderStyleRoundedRect;
        _seachBar.backgroundColor = [UIColor whiteColor];
        _seachBar.frame = CGRectMake(0, 0, 200, 20);
        _seachBar.delegate = self;
        _seachBar.placeholder = @"  🔍 疾病细分搜索 ";
        _seachBar.returnKeyType =  UIReturnKeySearch;

    }
    
    return _seachBar;
}

- (NSString *)searchText{
    
    if (!_searchText) {
        
        _searchText = @"";
    }
    return _searchText;
}

- (NSMutableArray *)searchResult{
    
    if (!_searchResult) {
        _searchResult = [NSMutableArray array];
    }
    return _searchResult;
}


#pragma mark - 响应方法

/**
 *  获取搜索的结果
 */
- (void)getSearchTextResult:(NSString *)searchString{
    
/******************************************/
    [self.searchResult removeAllObjects];
    if ([searchString isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus:@"请输入关键字"];
        delay(0.8);
        return;
    }
    //遍历模型数组的搜索字符串
    for (GYHillnessModel* model in self.illnessArray) {
        //拿出模型的字符串
        NSString *currentText = model.ci3_name;
        //判断搜索框的字符串是否包含在模型的字符串里面
        if ([currentText containsString:searchString]) {
            //如果在的话,获取字符串的range
            NSRange cpmRange = [currentText rangeOfString:searchString];
            //根据range 字符串
            NSMutableAttributedString *attributeText = [[NSMutableAttributedString alloc]initWithString:currentText];
            [attributeText addAttribute:NSForegroundColorAttributeName value:globalColor range:cpmRange];
            [attributeText addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Bold" size:25.0] range:cpmRange];
            [self.searchResult addObject:attributeText];
        }
    }
    if (self.searchResult.count == 0) {
        [SVProgressHUD showWithStatus:@"无匹配结果"];
        delay(0.8);
    }else{
        [self.tableView reloadData];
    }

    
}

#pragma mark - textFiled 代理方法啊

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self getSearchTextResult:textField.text];
    
    [textField resignFirstResponder];
    
    return NO;
}

/**
 *  下拉刷新获取数据
 */
- (void)getMoreIllnessModel{
    
    [self.searchResult removeAllObjects];
    [self.tableView reloadData];
    [self.tableView.mj_header endRefreshing];
}

// return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
@end
