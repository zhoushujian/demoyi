//
//  DYFMDBTool.m
//  FMDBTest
//
//  Created by Yangdongwu on 16/8/7.
//  Copyright © 2016年 DovYoung. All rights reserved.
//

#import "DYSQLiteManager.h"
#import <FMDB.h>

@interface DYSQLiteManager ()

@end

@implementation DYSQLiteManager

+ (instancetype)sharedManager {
    static id instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
}


- (void)openDatabase {
    
    
    
    //拿到本地路径
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    //生成数据库路径
    NSString *databasePath = [documentPath stringByAppendingPathComponent:@"databaseAVKY.db"];
    
    if ([[NSBundle mainBundle] pathForResource:@"databaseAVKY111.db" ofType:nil]) {
    }
    
    self.database = [FMDatabase databaseWithPath:databasePath];
    
    if ([self.database open]) {
        [self creatDoctorTable];
    }
    else {
        NSLog(@"数据库链接失败");
    }
    
}


- (void)creatDoctorTable {
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"hasDoctorTable"]) {
        //已经存在
        return;
    }
    
    //创建表格的sql语句
    NSString *sqlDoctorTable = @"CREATE TABLE 'T_DoctorList' (\n    'doctor_id' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,\n    'doctor_name' TEXT,\n    'doctor_title_name' TEXT,\n    'doctor_hospital_name' TEXT,\n    'operation_count' integer,\n    'flower' integer,\n    'banner' integer,\n    'pipeidu' TEXT\n,    'doctor_portrait' TEXT\n,    'doctor_gender' integer,\n    'accuracy' TEXT\n,\n    'hospital_name' TEXT,\n    'hospital_id' integer  )";
    
    BOOL resultCreatDoctorTable = [self.database executeUpdate:sqlDoctorTable];

    if (resultCreatDoctorTable) {
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"hasDoctorTable"];
        
    }
    else {
        NSLog(@"doctor Table Creat Fail!!!");
    }
    
    
}

@end
