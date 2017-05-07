//
//  YZNetworkTool+Attention.h
//  AVKY
//
//  Created by Yangdongwu on 16/8/5.
//  Copyright © 2016年 杰. All rights reserved.
//

#import "YZNetworkTool.h"

@interface YZNetworkTool (Attention)

- (void)requestDoctorListWithUrl:(NSString *)url parameters:(NSDictionary *)parameters callBack:(callBack)callBack;

@end
