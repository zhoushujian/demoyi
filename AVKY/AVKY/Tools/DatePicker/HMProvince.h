//
//  HMProvince.h
//  02-pickerView(省份)
//
//  Created by 罗铃 on 16/5/4.
//  Copyright © 2016年 ios04. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMProvince : NSObject
@property (nonatomic,strong) NSArray *cities;
@property (nonatomic,copy) NSString *name;

-(instancetype)initWithDict:(NSDictionary *)dict;

+(NSMutableArray *)provincesList;

+(NSArray *)numbersList;

@end
