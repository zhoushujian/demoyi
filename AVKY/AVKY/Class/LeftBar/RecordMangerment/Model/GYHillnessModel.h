//
//  GYHillnessModel.h
//  AVKY
//
//  Created by Marcello on 16/8/6.
//  Copyright © 2016年 杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GYHillnessModel : NSObject

/**
 *  疾病细分名
 */
@property (strong,nonatomic) NSString*  ci3_name;
/**
 *  疾病细分id
 */
@property (assign,nonatomic) NSInteger  ci3_id;
/**
 *  疾病分类id
 */
@property (assign,nonatomic) NSInteger  ci2_id;

//-(instancetype)initWithDic:(NSDictionary *)dic;

@end
