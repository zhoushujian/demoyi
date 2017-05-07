//
//  DYWebViewController.m
//  AVKY
//
//  Created by Yangdongwu on 16/8/10.
//  Copyright © 2016年 杰. All rights reserved.
//

#import "DYWebViewController.h"
#import <WebKit/WebKit.h>

@interface DYWebViewController ()

/**
 *  显示网络的控制器
 */
@property (nonatomic, strong) WKWebView *webView;
/**
 *  跳转的urlstring
 */
@property (nonatomic, copy) NSString *UrlString;

@end

@implementation DYWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}


- (instancetype)initWithUrlString:(NSString *)UrlString {
    if (self = [super init]) {
        self.UrlString = UrlString;
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.webView = [[WKWebView alloc] init];
    
    [self.view addSubview:self.webView];
    
    self.webView.frame = CGRectMake(0, 64, screenW, screenH - 64);
    
    NSURL *url = [NSURL URLWithString:self.UrlString];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [self.webView loadRequest:request];
    
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    self.webView = nil;
    
}







@end
