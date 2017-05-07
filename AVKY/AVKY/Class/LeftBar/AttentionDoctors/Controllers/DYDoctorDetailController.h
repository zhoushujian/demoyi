//
//  DYDoctorDetailController.h
//  AVKY
//
//  Created by Yangdongwu on 16/8/5.
//  Copyright © 2016年 杰. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DYDoctor;
#import "DYAttentionHeader.h"

@interface DYDoctorDetailController : UIViewController
/**
 *  跳转来源
 */
@property (nonatomic, assign) DYPushFrom pushFrom;
/**
 *  点击的cell对应的医生的模型
 */
@property (nonatomic, strong) DYDoctor *doctor;

@end
