//
//  GYHSliderSettingGroup.m
//  AVKY
//
//  Created by Marcello on 16/8/4.
//  Copyright © 2016年 杰. All rights reserved.
//

#import "GYHSliderSettingGroup.h"

@implementation GYHSliderSettingGroup


+ (instancetype)groupWithItems:(NSArray *)items {
    GYHSliderSettingGroup *group = [[self alloc] init];
    group.items = items;
    return group;
}

@end
