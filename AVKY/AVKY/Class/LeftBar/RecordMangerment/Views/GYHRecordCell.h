//
//  GYHRecordCell.h
//  AVKY
//
//  Created by Marcello on 16/8/8.
//  Copyright © 2016年 杰. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GYHRecordModel;
@interface GYHRecordCell : UITableViewCell

/**
 *  病历模块
 */
@property (nonatomic, strong) GYHRecordModel *recordModel;

@end
