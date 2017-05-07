//
//  GYHSliderSettingItemArrow.h
//  AVKY
//
//  Created by Marcello on 16/8/4.
//  Copyright © 2016年 杰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GYHSliderSettingItem.h"
@interface GYHSliderSettingItemArrow : GYHSliderSettingItem

/**
 *  目标控制器
 */
@property(nonatomic,assign) Class  destVc;

+(instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon destVc:(Class)destVc;
+(instancetype)itemWithTitle:(NSString *)title destVc:(Class)destVc;



@end
