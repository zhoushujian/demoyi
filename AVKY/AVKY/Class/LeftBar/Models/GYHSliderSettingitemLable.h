//
//  GYHSliderSettingitemLable.h
//  AVKY
//
//  Created by Marcello on 16/8/4.
//  Copyright © 2016年 杰. All rights reserved.
//

#import "GYHSliderSettingItem.h"

@interface GYHSliderSettingitemLable : GYHSliderSettingItem

/**
 *  值
 */
@property(nonatomic,copy) NSString *value;

+(instancetype)itemWithTitle:(NSString *)title defaultValue:(NSString *)value;
+(instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon defaultValue:(NSString *)value;
@end
