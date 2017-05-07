//
//  DYDoctorButtonsView.h
//  AVKY
//
//  Created by Yangdongwu on 16/8/5.
//  Copyright © 2016年 杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DYAttentionHeader.h"

@interface DYDoctorButtonsView : UIView

/**
 *  来源方式
 */
@property (nonatomic, assign) DYPushFrom pushFrom;
/**
 *  跳转的block
 */
@property (nonatomic, copy) void (^patientBlock)(UIViewController *controller);
/**
 *  咨询医生回调
 */
@property (nonatomic, copy) void (^consultDoctorBlock)();

@end
