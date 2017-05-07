//
//  YZNetworkTool+OAuth.m
//  AVKY
//
//  Created by EZ on 16/8/4.
//  Copyright © 2016年 杰. All rights reserved.
//

#import "YZNetworkTool+OAuth.h"

@implementation YZNetworkTool (OAuth)


// 获取access_token
-(void)requestAccessToken:(NSString *)code callBack:(callBack)callBack{
    NSString *urlString = @"https://api.weibo.com/oauth2/access_token";
    NSDictionary *parameters = @{@"code": code, @"client_id": weiboAppKey, @"client_secret": weiboAppSecret, @"grant_type": @"authorization_code", @"redirect_uri": weiboRedirectURL};
    
    [self request:urlString type:NetworkToolTypePost Paramer:parameters callBack:^(id responseBody) {
        callBack(responseBody);
    }];
}

// 获取用户数据
-(void)requestUserAccout:(NSString *)access_token uid:(NSString *)uid callBack:(callBack)callBack {
    NSString *urlString = @"https://api.weibo.com/2/users/show.json";
    NSDictionary *parameters = @{@"access_token": access_token, @"uid":uid};
    
    [self request:urlString type:NetworkToolTypeGet Paramer:parameters callBack:^(id responseBody) {
        callBack(responseBody);
    }];
}

@end
