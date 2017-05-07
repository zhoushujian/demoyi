//
//  GYHRecordModel.h
//  AVKY
//
//  Created by Marcello on 16/8/6.
//  Copyright © 2016年 杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GYHRecordModel : NSObject

/**
 *  疾病分类名
 */
@property (nonatomic, copy) NSString *caseCatogory;
/**
 *  疾病分类index (1-5)
 */
@property (assign,nonatomic) NSInteger catogoryIndex;
/**
 *  疾病细分名
 */
@property (nonatomic, copy) NSString *caseDetail;
/**
 *  疾病描述标签String数组
 */
@property (strong,nonatomic) NSMutableArray<NSString*> *desArray;
/**
 *  疾病详情描述
 */
@property (nonatomic, copy) NSString *describe;
/**
 *  病历图片数组
 */
@property (strong,nonatomic) NSMutableArray *picArray;

/**
 *  相册选中图片数组
 */
@property (nonatomic, strong) NSMutableArray *selectedAssets;

/**
 *  相册修改需要的东西
 */
@property (nonatomic, strong) NSDictionary *pictureDict;

/**
 *  当前病历创建的时间
 */
@property (nonatomic, copy) NSString *time;



/**
 *  病人Id(手机号)
 */
@property (nonatomic, copy) NSString *userId;

@end
