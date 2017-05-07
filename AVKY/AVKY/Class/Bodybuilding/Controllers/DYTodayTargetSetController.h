//
//  DYTodayTargetSetController.h
//  AVKY
//
//  Created by Yangdongwu on 16/8/4.
//  Copyright © 2016年 杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DYTodayTargetSetController : UIViewController
/**
 *  设置每日目标的block
 */
@property (nonatomic, copy) void (^todayTargetBlock)(NSString *stepCount);

@end
