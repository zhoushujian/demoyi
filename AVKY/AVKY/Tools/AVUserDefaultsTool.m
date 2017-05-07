//
//  AVUserDefaultsTool.m
//  AVKY
//
//  Created by 杰 on 16/8/4.
//  Copyright © 2016年 杰. All rights reserved.
//

#import "AVUserDefaultsTool.h"

@implementation AVUserDefaultsTool

+ (void)saveBool:(BOOL)b forKey:(NSString *)key{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:b forKey:key];
    
}
+ (BOOL)boolForKey:(NSString *)key{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults boolForKey:key];
    
}

+(void)saveObject:(id)object forKey:(NSString *)key{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:object forKey:key];
    
}

+(id)objetForKey:(NSString *)key{

    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    return [defaults objectForKey:key];
    
}

@end
