//
//  DYFMDBTool.h
//  FMDBTest
//
//  Created by Yangdongwu on 16/8/7.
//  Copyright © 2016年 DovYoung. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FMDatabase;

@interface DYSQLiteManager : UIView

/**
 *  单例方法
 */
+ (instancetype)sharedManager;
/**
 *  链接数据库
 */
- (void)openDatabase;
/**
 *  FMDatabase
 */
@property (nonatomic, strong) FMDatabase *database;

@end
