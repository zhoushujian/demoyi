//
//  YZNetworkTool+SickCallDoctorList.m
//  AVKY
//
//  Created by Yangdongwu on 16/8/7.
//  Copyright © 2016年 杰. All rights reserved.
//

#import "YZNetworkTool+SickCallDoctorList.h"

@implementation YZNetworkTool (SickCallDoctorList)

- (void)requestSickCallDoctorListcallBack:(callBack)callBack {
    NSString *url = @"http://iosapi.itcast.cn/doctor/matchDoctors.json.php";
    NSDictionary *parameters = @{@"ci1_id":@1,@"ci2_id":@3,@"ci3_id":@3,@"diagnosis_type":@0,@"page_size":@15,@"is_confirmed":@1,@"user_id":@1000089, @"page":@1,@"has_diagnosis":@2};
    
    YZNetworkTool *manager = [YZNetworkTool sharedManager];
    //需要json请求
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager request:url type:NetworkToolTypePost Paramer:parameters callBack:^(id responseBody) {
        callBack(responseBody);
    }];
}

@end
