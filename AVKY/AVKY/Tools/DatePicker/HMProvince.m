//
//  HMProvince.m
//  02-pickerView(省份)
//
//  Created by 罗铃 on 16/5/4.
//  Copyright © 2016年 ios04. All rights reserved.
//

#import "HMProvince.h"

@implementation HMProvince

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (NSMutableArray *)provincesList
{
    NSString *path = [[NSBundle mainBundle]pathForResource:@"02cities" ofType:@"plist"];
    NSArray *arr = [NSArray arrayWithContentsOfFile:path];
    NSMutableArray *mtArr = [NSMutableArray new];
    for (NSDictionary *dict in arr) {
        HMProvince *temp = [[self alloc] initWithDict:dict];
        [mtArr addObject:temp];
    }
    return mtArr;
}

+ (NSArray *)numbersList {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"pickerDatePlist" ofType:@"plist"];
    NSArray *numbers = [NSArray arrayWithContentsOfFile:path];
    return numbers;
}
@end
