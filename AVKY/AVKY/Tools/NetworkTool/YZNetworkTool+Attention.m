//
//  YZNetworkTool+Attention.m
//  AVKY
//
//  Created by Yangdongwu on 16/8/5.
//  Copyright © 2016年 杰. All rights reserved.
//

#import "YZNetworkTool+Attention.h"

@implementation YZNetworkTool (Attention)

- (void)requestDoctorListWithUrl:(NSString *)url parameters:(NSDictionary *)parameters callBack:(callBack)callBack {
    
    YZNetworkTool *manager = [YZNetworkTool sharedManager];
    //需要json请求
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager request:url type:NetworkToolTypePost Paramer:parameters callBack:^(id responseBody) {
        callBack(responseBody);
    }];
}

@end
