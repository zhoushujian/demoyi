//
//  GymTableViewCell.h
//  AVKY
//
//  Created by rayChow on 16/8/9.
//  Copyright © 2016年 杰. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GymNewsModel;

@interface GymTableViewCell : UITableViewCell

@property (nonatomic, strong) GymNewsModel *newsModel;


///  返回行高
///
///  @param newsModel 数据模型
///
///  @return 返回行高
+ (CGFloat)rowHeigth: (GymNewsModel *)newsModel;


///  返回 cell 的重用标识
///
///  @param newsModel 数据模型
///
///  @return 返回重用标识
+ (NSString *)identifierWithNew: (GymNewsModel *)newsModel;

@end
