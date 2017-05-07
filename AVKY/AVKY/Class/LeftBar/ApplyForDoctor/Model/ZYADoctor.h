//
//  ZYADoctor.h
//  AVKY
//
//  Created by zheng on 16/8/9.
//  Copyright © 2016年 杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYADoctor : NSObject

/**
 *  医生图片
 */
@property (nonatomic, copy) NSString *doctor_portrait;
/**
 *  医生名字
 */
@property (nonatomic, copy) NSString *doctor_name;
/**
 *  科室名字
 */
@property (nonatomic, copy) NSString *doctor_title_name;
/**
 *  就诊医生的医院名字
 */
@property (nonatomic, copy) NSString *doctor_hospital_name;
/**
 *  关注医生的医院名字
 */
@property (nonatomic, copy) NSString *hospital_name;
/**
 *  医生性别
 */
@property (nonatomic, assign) BOOL doctor_gender;
/**
 *  预约数
 */
@property (nonatomic, strong) NSNumber *operation_count;

/**
 *  医生的id
 */
@property (nonatomic, strong) NSNumber *doctor_id;
/**
 *  匹配度
 */
@property (nonatomic, copy) NSString *accuracy;
/**
 *  医院Id
 */
@property (nonatomic, strong) NSNumber *hospital_id;



@end
