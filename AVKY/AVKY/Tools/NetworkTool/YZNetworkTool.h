//
//  YZNetworkTool.h
//  AVKY
//
//  Created by EZ on 16/8/4.
//  Copyright © 2016年 杰. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>


//成功和失败回调
typedef void (^callBack)(id responseBody);
typedef void (^failureBlock)(NSError * error);

typedef enum NetworkToolType {
    NetworkToolTypeGet,
    NetworkToolTypePost
}NetworkToolType;

@interface YZNetworkTool : AFHTTPSessionManager

//定义一个创建单例对象的类方法
+(instancetype)sharedManager;

-(void)request:(NSString *)urlStr type:(NetworkToolType)type Paramer:(id)paramer callBack:(callBack)callBack;



@end
