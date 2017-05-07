//
//  YZNetworkTool+OAuth.h
//  AVKY
//
//  Created by EZ on 16/8/4.
//  Copyright © 2016年 杰. All rights reserved.
//

#import "YZNetworkTool.h"


@interface YZNetworkTool (OAuth)

// 获取access_token
-(void)requestAccessToken:(NSString *)code callBack:(callBack)callBack;

// 获取用户数据
-(void)requestUserAccout:(NSString *)access_token uid:(NSString *)uid callBack:(callBack)callBack;

@end
