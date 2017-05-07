//
//  FindViewController.m
//  AVKY
//
//  Created by 杰 on 16/8/3.
//  Copyright © 2016年 杰. All rights reserved.
//

#import "FindViewController.h"

#import <WebKit/WebKit.h>
#import "QRCodeReaderViewController.h"


#import "TabBarView.h"

@interface FindViewController ()<QRCodeReaderDelegate>

@property(nonatomic,strong)WKWebView *WKwebView;



@end

@implementation FindViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor orangeColor];
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
//    [self.view addSubview:self.WKwebView];
//    NSLog(@"%@",result);
    
    NSURL *url = [NSURL URLWithString:result];
    
    [self.WKwebView loadRequest:[NSURLRequest requestWithURL:url]];
    
    
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
    // Dispose of any resources that can be recreated.
}




-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
//
//    [self.TabarView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.mas_equalTo(self.view);
//        make.top.mas_equalTo(self.mas_topLayoutGuide);
//        make.height.mas_equalTo(40);
//    }];
    
    
}

//-(TabBarView *)TabarView{
//    if (!_TabarView) {
//        _TabarView = [[TabBarView alloc]initWithFrame:CGRectZero];
//    }
//    return _TabarView;
//}
-(WKWebView *)WKwebView{
    if (!_WKwebView) {
        _WKwebView = [[WKWebView alloc]init];
        _WKwebView.frame = self.view.bounds;
        [self.view addSubview:_WKwebView];
    }
    return _WKwebView;
}


@end
