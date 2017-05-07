//
//  DYDoctor.m
//  AVKY
//
//  Created by Yangdongwu on 16/8/5.
//  Copyright © 2016年 杰. All rights reserved.
//

#import "DYDoctor.h"
#import <FMDB.h>
#import "DYSQLiteManager.h"


@implementation DYDoctor

+ (void)addDoctor:(DYDoctor *)doctor {
    
    NSString *values = [NSString stringWithFormat:@"'%@','%@','%@','%@','%zd','%zd','%zd','%@','%@','%d'",doctor.doctor_id.stringValue,doctor.doctor_name,doctor.doctor_title_name,doctor.doctor_hospital_name,doctor.operation_count.integerValue,doctor.flower.integerValue,doctor.banner.integerValue,doctor.accuracy,doctor.doctor_portrait,doctor.doctor_gender];
    
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO 'T_DoctorList' ( 'doctor_id', 'doctor_name', 'doctor_title_name', 'doctor_hospital_name', 'operation_count', 'flower', 'banner', 'accuracy', 'doctor_portrait', 'doctor_gender') VALUES ( %@ );",values];
    
    FMDatabase *db = [DYSQLiteManager sharedManager].database;
    
    [db executeUpdate:sql];
    
}


+ (void)addDoctors:(NSArray <DYDoctor *>*)doctors {
    for (DYDoctor *doctor in doctors) {
        [self addDoctor:doctor];
    }
}


+ (void)deleteDoctorWithId:(NSNumber *)doctor_id {
    
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM 'T_DoctorList' WHERE doctor_id=%zd;",doctor_id.integerValue];
    
    FMDatabase *db = [DYSQLiteManager sharedManager].database;
    
    [db executeUpdate:sql];
    
}


+ (void)updateDoctor:(DYDoctor *)doctor {
    
    NSString *sql = [NSString stringWithFormat:@"UPDATE 'T_DoctorList' SET 'operation_count'=%zd, 'flower'=%zd, 'banner'=%zd  WHERE doctor_id=%zd;",doctor.operation_count.integerValue, doctor.flower.integerValue, doctor.banner.integerValue, doctor.doctor_id.integerValue];
    
    FMDatabase *db = [DYSQLiteManager sharedManager].database;
    
    [db executeUpdate:sql];
    
}


/*
 //查询table1中所有的数据
 SELECT * FROM "table1";
 
 //从第一行开始,查询五行数据,和主键的值无关
 SELECT * FROM "table1" LIMIT 0, 5;
 
 // 限制 LIMIT 0,5 指从第0行开始,向后面选中5行
 
 //查询指定的字段 name,age 从table1 当 age大于22 并且name是小雨
 SELECT name, age FROM "table1" WHERE age>22 AND name="小雨";
 
 //查询指定的字段 name,age 从table1 当 age大于22 逆序排列 查询一条数据
 SELECT name, age FROM "table1" WHERE age>22 ORDER BY id DESC LIMIT 1;
 */



+ (NSArray <DYDoctor *>*)selectDoctorWithSql:(NSString *)sql {
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    FMDatabase *db = [DYSQLiteManager sharedManager].database;
    
    FMResultSet *result = [db executeQuery:sql];
    
    NSMutableDictionary *temp = [NSMutableDictionary new];
    
    if (!result) {
        return nil;
    }
    
    while ([result next]) {
        
        //ring stringWithFormat:@"INSERT INTO 'T_DoctorList' ( 'doctor_id', 'doctor_name', 'doctor_title_name', 'doctor_hospital_name', 'operation_count', 'flower', 'banner', 'accuracy', 'doctor_portrait', 'doctor_gender'
        
        NSInteger doctor_id = [result longForColumn:@"doctor_id"];
        NSInteger operation_count = [result longForColumn:@"operation_count"];
        NSInteger flower = [result longForColumn:@"flower"];
        NSInteger banner = [result longForColumn:@"banner"];
        BOOL doctor_gender = [result boolForColumn:@"doctor_gender"];
        
        [temp setObject:@(doctor_id) forKey:@"doctor_id"];
        [temp setObject:[result stringForColumn:@"doctor_name"] forKey:@"doctor_name"];
        [temp setObject:[result stringForColumn:@"doctor_title_name"] forKey:@"doctor_title_name"];
        [temp setObject:[result stringForColumn:@"doctor_hospital_name"] forKey:@"doctor_hospital_name"];
        [temp setObject:@(operation_count) forKey:@"operation_count"];
        [temp setObject:@(flower) forKey:@"flower"];
        [temp setObject:@(banner) forKey:@"banner"];
        [temp setObject:[result stringForColumn:@"accuracy"] forKey:@"accuracy"];
        [temp setObject:[result stringForColumn:@"doctor_portrait"] forKey:@"doctor_portrait"];
        [temp setObject:@(doctor_gender) forKey:@"doctor_gender"];
        
        DYDoctor *doctor = [DYDoctor yy_modelWithDictionary:temp];
        
        [array addObject:doctor];
    }
    
    return [array copy];
}


@end
