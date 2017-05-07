//
//  FindViewController.m
//  AVKY

//  Created by 杰 on 16/8/3.
//  Copyright © 2016年 杰. All rights reserved.
//
#import <WebKit/WebKit.h>
#import "FindViewController.h"
#import "QRCodeReaderViewController.h"
#import "MAModel.h"
#import "FindCollectionViewCell.h"
#import "ProductsModel.h"
#import "FindHeadView.h"
#import "WJAdsView.h"
#import "AppDelegate.h"
#import "KYNavigationController.h"
#import "MovieViewController.h"


UIKIT_EXTERN NSString *const UICollectionElementKindSectionHeader;  //定义好Identifier
static NSString *const HeaderIdentifier = @"HeaderIdentifier";


@interface FindViewController ()<QRCodeReaderDelegate,UICollectionViewDataSource,UICollectionViewDelegate,WJAdsViewDelegate>


@property(nonatomic,strong)WKWebView *WKwebView;

@property (nonatomic,strong)UICollectionViewFlowLayout *layout;
@property(nonatomic,strong)FindHeadView *HeadView;

@property(nonatomic,strong)NSArray *arrays;

@property(nonatomic,strong)UICollectionView *CollectionView;

@property(nonatomic,strong)UITableView *tableView;


@end

@implementation FindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    NSString *find = NSLocalizedString(@"find", nil);
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:find forState:UIControlStateNormal];
    btn.frame = CGRectMake(0, 0, 100, 30);
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView =btn;[UIButton buttonWithType:UIButtonTypeCustom];
    
    [SVProgressHUD showWithStatus:@"正在加载中...."];

    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    
    [self.CollectionView registerClass:[FindHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HeaderIdentifier];
 
    [self.view addSubview:self.CollectionView];
    [self SetLayoutSubviews];
    
    UIView *im = [[UIView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:im];
    im.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"pic_hd_2"]];

    [MAModel GetModelUrl:@"http://shop.hxky.cn/j/myshop/testShopHome/home?appName=test&clientId=ec0cb54db0f5ede9d2b9eab70dde5d7c&deviceToken=f628e416bab1b898868f864d19425cbd9ecd317a18b3f1c4e1335665806368d6&deviceType=iPhone&imem=i_45d091f3bacab2875b9d90129_eyrier3434&osType=iOS&version=3.2.1" Paramer:nil Success:^(id responseBody) {

            [im removeFromSuperview];
        
        self.arrays = responseBody;
            [SVProgressHUD dismiss];
        
        [self performSelector:@selector(showAdsView)
                   withObject:nil
                   afterDelay:2];

        [self.CollectionView reloadData];
    } failError:^(NSError *error) {
        
    }];

  
    UIButton *scanBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [scanBtn setBackgroundImage:[UIImage imageNamed:@"pic_ct_scan_hl"] forState:UIControlStateNormal];
    [scanBtn addTarget:self action:@selector(scanAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:scanBtn];
}

#pragma mark -Btn点击事件
-(void)btnClick:(UIButton *)sender{
    
    MovieViewController *movie = [[MovieViewController alloc]init];
    

    KYNavigationController *MovieNav = [[KYNavigationController alloc]initWithRootViewController:movie];
    
       [self presentViewController:MovieNav animated:YES completion:nil];

    
    
}


#pragma mark -设置弹出页面滑动的图片弹框
-(void)showAdsView{
    
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    
    app.window.backgroundColor = [UIColor colorWithWhite:20
                                                   alpha:0.3];
    WJAdsView *adsView = [[WJAdsView alloc] initWithWindow:app.window];
    adsView.tag = 10;
    adsView.delegate = self;
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int i = 0; i < 4; i ++) {
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,adsView.mainContainView.frame.size.width, adsView.mainContainView.frame.size.width)];
        NSString *path = [NSString stringWithFormat:@"yindao35%d",i+1];
        image.image = [UIImage imageNamed:path];
        image.layer.cornerRadius = adsView.mainContainView.frame.size.width/2;
        image.layer.borderColor = [UIColor grayColor].CGColor;
        image.layer.masksToBounds = YES;
        image.layer.borderWidth = 5;
        
        [array addObject:image];
        
        
        
    }
    [self.view addSubview:adsView];
    
    adsView.containerSubviews = array;
    
    [adsView showAnimated:YES];
}




-(void)scanAction{
    QRCodeReaderViewController *reader = [QRCodeReaderViewController new];
    reader.modalPresentationStyle = UIModalPresentationFormSheet;
    reader.delegate = self;
    
    __weak typeof (self) wSelf = self;
    [reader setCompletionWithBlock:^(NSString *resultAsString) {
        [wSelf.navigationController popViewControllerAnimated:YES];
        [[[UIAlertView alloc] initWithTitle:@"" message:resultAsString delegate:self cancelButtonTitle:@"好的" otherButtonTitles: nil] show];
    }];
    
    
    [self.navigationController pushViewController:reader animated:YES];
}


#pragma mark -布局控件Frame
-(void)SetLayoutSubviews{
    
    
    [self.CollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(self.mas_topLayoutGuideTop);
    }];

}


    
    
#pragma mark -CollectionView数据源
    
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return self.arrays.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    FindCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];

    MAModel  *ml = self.arrays[indexPath.item];
    
    cell.Model = ml;
    return cell;
    
}


#pragma mark - 二维码扫描代理实现跳转
- (void)reader:(QRCodeReaderViewController *)reader didScanResult:(NSString *)result{}

- (void)readerDidCancel:(QRCodeReaderViewController *)reader
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 这两个代理是设置UICollectionView的组头与组尾的
//执行的 headerView 代理  返回 headerView 的高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
  
    return CGSizeMake(screenW, 750);
}


//kind参数就是用来区分是组头还是组尾的
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    FindHeadView *headView = nil;
    
    if( [kind isEqualToString:UICollectionElementKindSectionHeader ]){
        headView =[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:HeaderIdentifier forIndexPath:indexPath];
    }
    
    return headView;
}

#pragma mark - UICollectionView的头
-(FindHeadView *)HeadView{
    if (!_HeadView) {
        _HeadView = [[FindHeadView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 700)];
        _HeadView.backgroundColor = [UIColor colorWithRed:213/255.0 green:209/255.0 blue:201/255.0 alpha:1];

    }
    return _HeadView;
}

#pragma mark - 懒加载控件
-(UICollectionView *)CollectionView{
    if (!_CollectionView) {
        
        self.layout = [UICollectionViewFlowLayout new];
        _CollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0,375, 40) collectionViewLayout:self.layout];
        _CollectionView.backgroundColor = [UIColor whiteColor];
        
        self.layout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width/2-2, 200);
        
        self.layout.minimumInteritemSpacing = 1;

        self.layout.minimumLineSpacing =1;
        
        self.layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        [_CollectionView registerClass:[FindCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
       
        [_CollectionView registerClass:[FindHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headView"];
        _CollectionView.dataSource = self;
        _CollectionView.delegate = self;
    }
    return _CollectionView;
}
-(NSArray *)arrays{
    if (!_arrays) {
        _arrays = [NSArray array];
    }
    return _arrays;
}
-(void)dealloc{
    NSLog(@"死了");
}
@end
