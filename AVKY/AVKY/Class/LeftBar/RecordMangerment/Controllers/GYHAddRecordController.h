//
//  GYHAddRecordController.h
//  AVKY
//
//  Created by Marcello on 16/8/5.
//  Copyright © 2016年 杰. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GYHRecordModel;
@interface GYHAddRecordController : UIViewController

/**
 *  病历模型
 */
@property (nonatomic, strong) GYHRecordModel *recordModel;

/**
 *  回调病历模型
 */
@property (nonatomic, copy) void(^callbackModel)(GYHRecordModel *model);

/**
 *  回调删除病历模型
 */
@property (nonatomic, copy) void(^callbackDeletedModel)(GYHRecordModel *model);

@end
