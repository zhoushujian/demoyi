//
//  YZNetworkTool+desaese.m
//  AVKY
//
//  Created by 周勇 on 16/8/5.
//  Copyright © 2016年 杰. All rights reserved.
//

#import "YZNetworkTool+desaese.h"
#import "YZNetworkTool.h"
#import "ZYfirstStageDisease.h"
#import "ZYsecondStageDisease.h"

@implementation YZNetworkTool (desaese)
/**
 *  获取疾病详细数据
 */
-(void)requestFirstageDeseaseWith:(NSInteger)index Cllback:(callBack)callback{
    
    NSString *url = @"http://iosapi.itcast.cn/doctor/searchCI3List.json.php";
    NSDictionary *parameters = @{@"page":@1,@"page_size":@15,@"ci1_id":[NSNumber numberWithInteger:index+1],@"keyword":@""};
    
    [YZNetworkTool sharedManager].requestSerializer = [AFJSONRequestSerializer serializer];
    //需要设置返回值类型修改
    [YZNetworkTool sharedManager].responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html",nil];
    
    [self request:url type:NetworkToolTypePost Paramer:parameters callBack:^(id responseBody) {

        if([responseBody isKindOfClass:[NSError class]] || [responseBody[@"data"] isKindOfClass:[NSNull class]] || responseBody == nil) {
            [SVProgressHUD showErrorWithStatus:@"请检查您的网络"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
            return;
        }
    
        NSMutableArray * marr = [NSMutableArray array];
        if (![responseBody[@"data"] isKindOfClass:[NSNull class]]) {
            NSArray * arr = responseBody[@"data"];
            for (NSDictionary * dic in arr) {
                ZYfirstStageDisease * first = [ZYfirstStageDisease yy_modelWithDictionary:dic];
                [marr addObject:first];
            }
        }else
        {
            callback(nil);
        }
        callback(marr);
    }];
}
/**
 *  获取二级疾病数据
 */
-(void)requestSecondageDeseaseWith:(NSInteger)index Cllback:(callBack)callback{
    NSString *url;
    NSDictionary *parameters;
    switch (index) {
        case 0:
            url = @"http://iosapi.itcast.cn/doctor/complicationList.json.php";
            parameters = @{@"page":@1,@"page_size":@15,@"ci2_id":@3};
            break;
        case 1:
            url = @"http://iosapi.itcast.cn/doctor/complicationList.json.php";
            parameters = @{@"page":@1,@"page_size":@15,@"ci1_id":@1,@"ci2_id":@3};
            break;
        default:
            break;
    }
    [YZNetworkTool sharedManager].requestSerializer = [AFJSONRequestSerializer serializer];
    //需要设置返回值类型修改
    [YZNetworkTool sharedManager].responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html",nil];
    [self request:url type:NetworkToolTypePost Paramer:parameters callBack:^(id responseBody) {
        
        if([responseBody isKindOfClass:[NSError class]] || [responseBody[@"data"] isKindOfClass:[NSNull class]] || responseBody == nil) {
            [SVProgressHUD showErrorWithStatus:@"请检查您的网络"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
            return;
        }

        NSArray * arr = responseBody[@"data"];
        NSMutableArray * marr = [NSMutableArray array];
        if (responseBody[@"data"]) {
            for (NSDictionary * dic in arr) {
                ZYsecondStageDisease * first = [ZYsecondStageDisease yy_modelWithDictionary:dic];
                [marr addObject:first];
            }
        }else
        {
            callback(nil);
        }
        callback(marr);
    }];
}

@end
