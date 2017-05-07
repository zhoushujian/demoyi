//
//  GYHEdgeInsetsLabel.h
//  AVKY
//
//  Created by Marcello on 16/8/7.
//  Copyright © 2016年 杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GYHEdgeInsetsLabel : UILabel

/**
 *  内边距
 */
@property(nonatomic, assign) UIEdgeInsets edgeInsets;

/**
 * 点击删除本身
 */
@property (nonatomic, copy) void(^deleteFromSuperView)(NSString *text);

/**
 *  是否删除
 */
@property (nonatomic, assign) BOOL isDeleted;

@end
