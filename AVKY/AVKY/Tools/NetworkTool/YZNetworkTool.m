//
//  YZNetworkTool.m
//  AVKY
//
//  Created by EZ on 16/8/4.
//  Copyright © 2016年 杰. All rights reserved.
//

#import "YZNetworkTool.h"

@implementation YZNetworkTool

+(instancetype)sharedManager {
    static YZNetworkTool *instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
        instance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html",@"text/plain", nil];
    });
    
    return instance;
}

-(void)request:(NSString *)urlStr type:(NetworkToolType)type Paramer:(id)paramer callBack:(callBack)callBack {
    
    // GET 请求
    if (type == NetworkToolTypeGet) {
        [self GET:urlStr parameters:paramer progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            //成功返回
            if (callBack) {
                callBack(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            callBack(error);
        }];
    }
    
    // POST 请求
    if (type == NetworkToolTypePost) {
        [self POST:urlStr parameters:paramer progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            //成功返回
            if (callBack) {
                callBack(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            //失败返回
            callBack(error);
        }];
    }
}

@end
