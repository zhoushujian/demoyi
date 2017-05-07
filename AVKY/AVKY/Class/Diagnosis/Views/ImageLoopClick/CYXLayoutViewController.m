//
//  CYXLayoutViewController.m
//  AVKY
//
//  Created by 杰 on 16/8/4.
//  Copyright © 2016年 杰. All rights reserved.
//

#import "CYXLayoutViewController.h"
#import "CYXPhotoViewLayout.h"
#import "CYXPhotoCell.h"
#import <WebKit/WebKit.h>
#import "DYWebViewController.h"

@interface CYXLayoutViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
/**
 *  URLList清单
 */
@property (nonatomic, strong) NSArray *URLList;

@end

@implementation CYXLayoutViewController

static NSString * const ID = @"cell";

- (void)viewDidLoad {
    [super viewDidLoad];

    
    CYXPhotoViewLayout *layout = [[CYXPhotoViewLayout alloc]init];
    
    
//    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    layout.itemSize = CGSizeMake(200, 280);
    
    // 创建collection 设置尺寸
    CGFloat collectionW = self.view.frame.size.width;
    CGFloat collectionH = self.view.frame.size.height;
    CGFloat collectionX = 0;
    CGFloat collectionY = 0;

    CGRect frame = CGRectMake(collectionX, collectionY, collectionW, collectionH);
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:frame collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor colorWithRed:68/255.0 green:83/255.0 blue:244/255.0 alpha:1.0]
;
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [self.view addSubview:collectionView];
collectionView.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"pic_hd_1"]];
    // 注册cell
    [collectionView registerClass:[CYXPhotoCell class] forCellWithReuseIdentifier:ID];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 12;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CYXPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.imageName = [NSString stringWithFormat:@"0%zd", indexPath.item + 1];
    
    return cell;
}

#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    DYWebViewController *webViewController = [[DYWebViewController alloc] initWithUrlString:self.URLList[indexPath.item]];
    
    [self.navigationController pushViewController:webViewController animated:YES];
    
}

#pragma mark - 懒加载
- (NSArray *)URLList {
    if (_URLList == nil) {
        
        NSString *URLListPath = [[NSBundle mainBundle] pathForResource:@"URLList" ofType:@"plist"];
        
        _URLList = [NSArray arrayWithContentsOfFile:URLListPath];
        
    }
    return _URLList;
}


@end
