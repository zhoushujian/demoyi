//
//  OAuthViewController.m
//  AVKY
//
//  Created by EZ on 16/8/5.
//  Copyright © 2016年 杰. All rights reserved.
//

#import "OAuthViewController.h"
#import "YZNetworkTool+OAuth.h"
#import "UserAccount.h"

@interface OAuthViewController ()<UIWebViewDelegate>
/**
 *  微博登录网页
 */
@property (nonatomic, strong) UIWebView *webView;

@end

@implementation OAuthViewController

-(void)loadView {
    self.view = self.webView;
}

-(void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"用户登录";
    //设置UI
    [self setupUI];
}

#pragma mark - 设置UI
/**
 *  设置UI
 */
-(void)setupUI {
    //添加背景颜色
    self.view.backgroundColor = [UIColor yellowColor];
    
    //设置导航左边item
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(didClickLeftButtonItem)];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    //添加网页
//    [self.view addSubview:self.webView];
    
    NSString *urlString = [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@",weiboAppKey,weiboRedirectURL];
    NSLog(@"%@",urlString);
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    
    [self.webView loadRequest:request];
}

#pragma mark - 响应事件
/**
 *  取消按钮
 */
-(void)didClickLeftButtonItem {
    //dismiss当前控制器
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIWebView 代理方法
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    //拿到绝对路径
    NSString *absoluteString = request.URL.absoluteString;

    // 判断前缀是否有 weiboRedirectURL
    if (![absoluteString hasPrefix:weiboRedirectURL]) {
        return YES;
    }
    
    //判断是否有 code=
    if (![request.URL.query hasPrefix:@"code="]) {
        // 没有 code=  就取消
        [self dismissViewControllerAnimated:YES completion:nil];
        return NO;
    }
    
    //获取code
    NSString *code = [request.URL.query substringFromIndex:5];
    //通过code 获取 access_token
    [[YZNetworkTool sharedManager] requestAccessToken:code callBack:^(id responseBody) {
        NSMutableDictionary *access_token_dic = responseBody;

        if ([access_token_dic isKindOfClass:[NSError class]]) {
            [SVProgressHUD showErrorWithStatus:
             @"网络请求错误"];
            
            delay(0.8);
            [self dismissViewControllerAnimated:YES completion:nil];
            return;
        }
        
        //使用 responseBody 结果,获取用户
        [[YZNetworkTool sharedManager] requestUserAccout:access_token_dic[@"access_token"] uid:access_token_dic[@"uid"] callBack:^(id responseBody) {
            
            NSMutableDictionary *userAccountDic = responseBody;
            //如果返回数据是nil 就直接 return
            if (userAccountDic == nil) {
                return;
            }
            
            //合并字典
            NSMutableDictionary *mtuDict = [NSMutableDictionary dictionary];
            [mtuDict addEntriesFromDictionary:userAccountDic];
            [mtuDict addEntriesFromDictionary:access_token_dic];
            
            
            //将access_token 连同 user 信息保存起来
            [[UserAccount sharedUserAccount] saveUserAccount:mtuDict];
            
            //通知controller登录 (登录成功)
            [[NSNotificationCenter defaultCenter] postNotificationName:loginSuccessNotification object:nil];
            //延迟加载
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self dismissViewControllerAnimated:YES completion:nil];
            });
        }];
    }];
    
    return NO;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    NSString *jsCode = [NSString stringWithFormat:@"document.getElementById('userId').value='%@';document.getElementById('passwd').value='%@';",weiboUserName,weiboUserPassword];
    
    [webView stringByEvaluatingJavaScriptFromString:jsCode];
}

#pragma mark - 懒加载
-(UIWebView *)webView {
    if (_webView == nil) {
        _webView = [[UIWebView alloc] init];
        _webView.frame = self.view.frame;
        _webView.scrollView.bounces = false;
        _webView.delegate = self;
    }
    return _webView;
}
@end
