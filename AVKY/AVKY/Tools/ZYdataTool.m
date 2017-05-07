//
//  ZYdataTool.m
//  AVKY
//
//  Created by 周勇 on 16/8/4.
//  Copyright © 2016年 杰. All rights reserved.
//

#import "ZYdataTool.h"

@implementation ZYdataTool

+ (instancetype)sharedTool {
    static id instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] initWithBaseURL:nil];
    });
    
    return instance;
}

@end
