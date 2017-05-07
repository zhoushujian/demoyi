//
//  GYHSliderSettingItemArrow.m
//  AVKY
//
//  Created by Marcello on 16/8/4.
//  Copyright © 2016年 杰. All rights reserved.
//

#import "GYHSliderSettingItemArrow.h"
#import "GYHSliderSettingItem.h"

@implementation GYHSliderSettingItemArrow

+(instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon destVc:(Class)destVc{
    GYHSliderSettingItemArrow *item = [self itemWithTitle:title icon:icon];
    item.destVc = destVc;
    return item;
}

+(instancetype)itemWithTitle:(NSString *)title destVc:(Class)destVc {
    return [self itemWithTitle:title icon:nil destVc:destVc];
}

@end
