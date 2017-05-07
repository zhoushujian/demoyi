//
//  YZProvincePicker.h
//  AVKY
//
//  Created by EZ on 16/8/9.
//  Copyright © 2016年 杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YZProvincePicker : UIView

@property (nonatomic,copy) void (^pickerViewValueChangeBlock)(NSString *province,NSString *city);

@property (nonatomic, weak) UIPickerView *pickerView;

/**
 *  提供快速创建的类方法
 */
+(instancetype)provincePicker;


//显示
-(void)show;

//隐藏
-(void)dismiss;

@end
