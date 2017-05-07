//
//  FindViewController.m
//  AVKY
//
//  Created by 杰 on 16/8/3.
//  Copyright © 2016年 杰. All rights reserved.
//

#import "FindViewController.h"

#import "QRCodeReaderViewController.h"


#import "TabBarView.h"

#import "FindModel.h"

@interface FindViewController ()<QRCodeReaderDelegate>


@property(nonatomic,strong)TabBarView *TabarView;


@end

@implementation FindViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [FindModel GetModelUrl:@"http://shop.hxky.cn/m/surveytest/surveyTestForApp/newHome?appName=test&clientId=ec0cb54db0f5ede9d2b9eab70dde5d7c&deviceToken=f628e416bab1b898868f864d19425cbd9ecd317a18b3f1c4e1335665806368d6&deviceType=iPhone&imem=i_45d091f3bacab2875b9d90129_eyrier3434&osType=iOS&pageNo=1&pageSize=10&version=3.2.1" Paramer:nil Success:^(id responseBody) {
        
        NSLog(@"%@",responseBody);
    } failError:^(NSError *error) {
        
    }];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.TabarView];
    // Do any additional setup after loading the view.
    UIButton *scanBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [scanBtn setBackgroundImage:[UIImage imageNamed:@"Scan"] forState:UIControlStateNormal];
    [scanBtn addTarget:self action:@selector(scanAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:scanBtn];
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

#pragma mark - QRCodeReader Delegate Methods

- (void)reader:(QRCodeReaderViewController *)reader didScanResult:(NSString *)result
{
    [self dismissViewControllerAnimated:YES completion:^{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"QRCodeReader" message:result delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }];
}

- (void)readerDidCancel:(QRCodeReaderViewController *)reader
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

    
}




-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
//
    [self.TabarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.mas_topLayoutGuide);
        make.height.mas_equalTo(40);
    }];
    
    
}

-(TabBarView *)TabarView{
    if (!_TabarView) {
        _TabarView = [[TabBarView alloc]initWithFrame:CGRectZero];
    }
    return _TabarView;
}



@end
