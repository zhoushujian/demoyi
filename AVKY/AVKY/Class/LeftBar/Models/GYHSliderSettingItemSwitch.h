//
//  GYHSliderSettingItemSwitch.h
//  AVKY
//
//  Created by Marcello on 16/8/4.
//  Copyright © 2016年 杰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GYHSliderSettingItem.h"

typedef void (^SwitchBlock)(BOOL on);
@interface GYHSliderSettingItemSwitch : GYHSliderSettingItem

/**
 *  记录开关状态
 */
@property(nonatomic,assign) BOOL  on;
/**
 *  监听开关状态改变回调
 */
@property(nonatomic,copy) SwitchBlock switchBlock;

@end
