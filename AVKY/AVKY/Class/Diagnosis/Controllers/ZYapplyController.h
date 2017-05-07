//
//  ZYapplyController.h
//  AVKY
//
//  Created by 周勇 on 16/8/5.
//  Copyright © 2016年 杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYapplyController : UITableViewController
/**
 *  疾病索引
 */
@property (nonatomic, assign) NSInteger index;
/**
 *  显示疾病控制器底部的button和view的显示
 */
@property (nonatomic, copy) void (^showIcon)(BOOL isShow);
@end
