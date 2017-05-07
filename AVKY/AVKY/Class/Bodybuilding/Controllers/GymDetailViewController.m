//
//  GymViewController.m
//  AVKY
//
//  Created by rayChow on 16/8/9.
//  Copyright © 2016年 杰. All rights reserved.
//

#import "GymDetailViewController.h"
#import "YZNetworkTool.h"


@interface GymDetailViewController ()<UIWebViewDelegate>
///  新闻详情数据
@property (nonatomic, strong) NSDictionary *data;
///  新闻标题
@property (nonatomic, copy) NSString *newsTitle;
///  时间和来源
@property (nonatomic, copy) NSString *timeAndSource;
///  新闻详情内容
@property (nonatomic, copy) NSString *bodyStr;

@property (nonatomic, strong) UIWebView *webView;
@end

@implementation GymDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.webView];
    [self loadData];
}

- (void)loadData {
    [[YZNetworkTool sharedManager] GET:self.URLString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
        // 获得第一个key
        NSString *rootKey = responseObject.keyEnumerator.nextObject;
        
        // 获得新闻详情数据
        self.data = responseObject[rootKey];
        
        // 获得新闻标题
        self.newsTitle = self.data[@"title"];
        // 获得新闻时间和来源
        self.timeAndSource = [NSString stringWithFormat:@"%@ %@",self.data[@"ptime"],self.data[@"source"]];
        // 获得新闻内容
        self.bodyStr = self.data[@"body"];
        
        // 获得图片数组
        NSArray *imgs = self.data[@"img"];
        // 遍历数据
        for (NSDictionary *img in imgs) {
            // 获得图片来源
            NSString *src = img[@"src"];
            // 获得ref
            NSString *ref = img[@"ref"];
            
            NSString *imgTagStr = [NSString stringWithFormat:@"<img src=\"%@\" width=\"100%%\"/>",src];
            // 替换
            self.bodyStr = [self.bodyStr stringByReplacingOccurrencesOfString:ref withString:imgTagStr];
        }
        
        // 获得视频数组
        NSArray *videos = self.data[@"video"];
        // 遍历数组
        for (NSDictionary *video in videos) {
            // 获得视频路径
            NSString *mp4_url = video[@"mp4_url"];
            // 获得背景图片
            NSString *cover = video[@"cover"];
            // 获得alt
            NSString *alt = video[@"alt"];
            // 获得ref
            NSString *ref = video[@"ref"];
            
            NSString *videoTag = [NSString stringWithFormat:@"<video width=\"100%%\" controls poster=\"%@\"> <source src=\"%@\"  type=\"video/mp4\"> </video><br/><span style=\"color: gray;font-size: 14px\">%@</span>",cover,mp4_url,alt];
            // 替换
            self.bodyStr = [self.bodyStr stringByReplacingOccurrencesOfString:ref withString:videoTag];
        }
        
        // 加载新闻详情页
        NSURL *URL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"detail.html" ofType:nil]];
        NSURLRequest *request = [NSURLRequest requestWithURL:URL];
        [self.webView loadRequest:request];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error:%@",error);
    }];
}

#pragma mark - webView代理
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSString *jsStr = [NSString stringWithFormat:@"changeContent('%@','%@','%@')",self.newsTitle,self.timeAndSource,self.bodyStr];
    // 执行js方法
    [webView stringByEvaluatingJavaScriptFromString:jsStr];
}

#pragma mark - 懒加载
- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc]init];
        _webView.frame = self.view.bounds;
        _webView.delegate = self;
    }
    return _webView;
}

@end
