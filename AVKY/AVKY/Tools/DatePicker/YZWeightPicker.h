//
//  YZWeightPicker.h
//  AVKY
//
//  Created by EZ on 16/8/9.
//  Copyright © 2016年 杰. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface YZWeightPicker : UIView

@property (nonatomic,copy) void (^pickerViewValueChangeBlock)(NSString *str);

/**
 *  需要修改的名称
 */
@property (nonatomic, weak) UILabel *nameLabel;

+(instancetype)weightPicker;

/**
 *  显示pickerView
 */
-(void)show;

/**
 *  隐藏pickerView
 */
-(void)dismiss;

@end
