//
//  DYStepView.h
//  AVKY
//
//  Created by Yangdongwu on 16/8/4.
//  Copyright © 2016年 杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DYStepView : UIView

/**
 *  今日任务点击的block
 */
@property (nonatomic, copy) void (^todayTargetClickBlock)();
/**
 *  目标步数
 */
@property (nonatomic, assign) NSInteger targetCount;
/**
 *  完成今日任务的标记
 */
@property (nonatomic, assign) BOOL completeFlag;

@end
