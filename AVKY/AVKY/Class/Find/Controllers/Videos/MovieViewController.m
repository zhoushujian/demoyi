//
//  MovieViewController.m
//  AVKY
//
//  Created by 杰 on 16/8/7.
//  Copyright © 2016年 杰. All rights reserved.
//
#define URL @"http://service.ingkee.com/api/live/gettop?imsi=&uid=17800399&proto=5&idfa=A1205EB8-0C9A-4131-A2A2-27B9A1E06622&lc=0000000000000026&cc=TG0001&imei=&sid=20i0a3GAvc8ykfClKMAen8WNeIBKrUwgdG9whVJ0ljXi1Af8hQci3&cv=IK3.1.00_Iphone&devi=bcb94097c7a3f3314be284c8a5be2aaeae66d6ab&conn=Wifi&ua=iPhone&idfv=DEBAD23B-7C6A-4251-B8AF-A95910B778B7&osversion=ios_9.300000&count=5&multiaddr=1"

#import "MovieViewController.h"
#import "LiveViewController.h"
#import <SDWebImageManager.h>
#import "MovieModel.h"
#import "AVKYMovieCell.h"
@interface MovieViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)NSMutableArray *dataArray;

@property(nonatomic,strong)UITableView *tableView;



@end

@implementation MovieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"直播列表";
    self.view.backgroundColor = [UIColor whiteColor];//UIBarButtonSystemItemStop
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(leftBarButtonItemClick)];
    
    [self.view addSubview:self.tableView];
    
    
    [MovieModel GetModelUrl:URL Paramer:nil Success:^(id responseBody) {
       
                
        
        self.dataArray = responseBody;
        
        [self.tableView reloadData];

    } failError:^(NSError *error) {
        
    }];

}
-(void)leftBarButtonItemClick{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [[SDWebImageManager sharedManager] cancelAll];
    
}
#pragma mark - tableView代理


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    [[SDImageCache sharedImageCache] clearDisk];
}

#pragma mark - TableView数据源

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.dataArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AVKYMovieCell *cell = [AVKYMovieCell tableViewCell:tableView];
    
    MovieModel *ml = self.dataArray[indexPath.section];
    cell.model = ml;
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    LiveViewController *liveVC = [[LiveViewController alloc]init];
    
    
    
    MovieModel *ml = self.dataArray[indexPath.section];
    
    liveVC.LiveUrl = ml.stream_addr;
    
    [self.navigationController pushViewController:liveVC animated:YES];
    
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1);
        [UIView animateWithDuration:1 animations:^{
        
        cell.layer.transform = CATransform3DMakeScale(1, 1, 1);
    }];
    
}


#pragma mark - 懒加载控件
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor colorWithRed:221/255.0 green:253/255.0 blue:230/255.0 alpha:1];
        _tableView.rowHeight = ([UIScreen mainScreen].bounds.size.width * 618/480)+1;
        
    }
    return _tableView;
}

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
        
    }
    return _dataArray;
}

@end
