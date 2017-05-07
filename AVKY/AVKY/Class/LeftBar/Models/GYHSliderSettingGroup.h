//
//  GYHSliderSettingGroup.h
//  AVKY
//
//  Created by Marcello on 16/8/4.
//  Copyright © 2016年 杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GYHSliderSettingGroup : NSObject


/**
 *  头部标题
 */
@property(nonatomic,copy) NSString *header;
/**
 *  尾部标题
 */
@property(nonatomic,copy) NSString *footer;

/**
 *  该组对应的所有 item(CZSettingItem模型、一个 item 代表一行)
 */
@property(nonatomic,strong) NSArray *items;

+(instancetype)groupWithItems:(NSArray *)items;

@end
