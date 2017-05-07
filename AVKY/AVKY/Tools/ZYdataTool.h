//
//  ZYdataTool.h
//  AVKY
//
//  Created by 周勇 on 16/8/4.
//  Copyright © 2016年 杰. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface ZYdataTool : AFHTTPSessionManager
// 请求数据单例
+(instancetype)sharedTool;


@end
