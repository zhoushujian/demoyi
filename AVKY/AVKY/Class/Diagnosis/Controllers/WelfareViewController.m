//
//  WelfareViewController.m
//  AVKY
//
//  Created by 杰 on 16/8/8.
//  Copyright © 2016年 杰. All rights reserved.
//

#import "WelfareViewController.h"
#import <WebKit/WebKit.h>
@interface WelfareViewController ()

@property(nonatomic,strong)WKWebView *WkWebView;

@end

@implementation WelfareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    [self.view addSubview:self.WkWebView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(WKWebView *)WkWebView{
    if (!_WkWebView) {
        _WkWebView = [[WKWebView alloc]init];
        _WkWebView.frame = self.view.bounds;
        NSURL *path = [NSURL URLWithString:@"http://202.106.210.115:18080/hyde-pluto-h360/nt/appEntrance.htm"];
        NSURLRequest *request = [NSURLRequest requestWithURL:path];
    
        [_WkWebView loadRequest:request];
        
    }
    return _WkWebView;
}

@end
