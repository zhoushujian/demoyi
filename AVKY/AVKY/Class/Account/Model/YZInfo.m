//
//  YZInfo.m
//  AVKY
//
//  Created by EZ on 16/8/8.
//  Copyright © 2016年 杰. All rights reserved.
//

#import "YZInfo.h"

@implementation YZInfo

-(instancetype)initWithDic:(NSDictionary *)dic{
    
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dic];
    }
    
    return self;
}

+(instancetype)infoWithDic:(NSDictionary *)dic{
    
    return [[self alloc] initWithDic:dic];
}


@end
