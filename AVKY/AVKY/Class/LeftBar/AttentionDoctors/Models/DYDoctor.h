//
//  DYDoctor.h
//  AVKY
//
//  Created by Yangdongwu on 16/8/5.
//  Copyright © 2016年 杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DYDoctor : NSObject

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
 *  鲜花数
 */
@property (nonatomic, strong) NSNumber *flower;
/**
 *  预约数
 */
@property (nonatomic, strong) NSNumber *operation_count;
/**
 *  锦旗数
 */
@property (nonatomic, strong) NSNumber *banner;
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
/**
 *  添加模型
 */
+ (void)addDoctor:(DYDoctor *)doctor;
/**
 *  添加多个模型
 */
+ (void)addDoctors:(NSArray <DYDoctor *>*)doctors;
/**
 *  根据id删除模型
 */
+ (void)deleteDoctorWithId:(NSNumber *)doctor_id;
/**
 *  更新模型数据
 */
+ (void)updateDoctor:(DYDoctor *)doctor;
/**
 *  选择模型,需要传一个sql语句
 */
+ (NSArray <DYDoctor *>*)selectDoctorWithSql:(NSString *)sql;

@end
