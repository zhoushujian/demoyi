//
//  YZInfoCell.h
//  AVKY
//
//  Created by EZ on 16/8/8.
//  Copyright © 2016年 杰. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YZInfo;

@interface YZInfoCell : UITableViewCell

///**
// *  信息类别
// */
//@property (nonatomic, weak) UILabel *infoCategory;
///**
// *  信息内容
// */
//@property (nonatomic, weak) UILabel *infoText;

@property (nonatomic, strong) YZInfo *info;

@end
