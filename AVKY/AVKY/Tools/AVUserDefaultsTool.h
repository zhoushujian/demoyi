//
//  AVUserDefaultsTool.h
//  AVKY
//
//  Created by 杰 on 16/8/4.
//  Copyright © 2016年 杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AVUserDefaultsTool : NSObject
//-------偏好设置的存取工具--------
//保存bool到偏好设置
+ (void)saveBool:(BOOL)b forKey:(NSString *)key;
//读取bool从偏好设置
+ (BOOL)boolForKey:(NSString *)key;

//保存对象到偏好设置
+(void)saveObject:(id)object forKey:(NSString *)key;
//读取对象到从偏好设置
+(id)objetForKey:(NSString *)key;

@end
