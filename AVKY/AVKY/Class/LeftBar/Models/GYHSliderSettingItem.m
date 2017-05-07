//
//  GYHSliderSettingItem.m
//  AVKY
//
//  Created by Marcello on 16/8/4.
//  Copyright © 2016年 杰. All rights reserved.
//

#import "GYHSliderSettingItem.h"

@implementation GYHSliderSettingItem


+(instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon{
    GYHSliderSettingItem *item = [[self alloc] init];
    item.title = title;
    item.icon = icon;
    return item;
}

+(instancetype)itemWithTitle:(NSString *)title subTitle:(NSString *)subTitle{
    GYHSliderSettingItem *item = [[self alloc] init];
    item.title = title;
    item.subTitle = subTitle;
    return item;
}

+(instancetype)itemWithTitle:(NSString *)title{
    return [self itemWithTitle:title icon:nil];
}

@end
