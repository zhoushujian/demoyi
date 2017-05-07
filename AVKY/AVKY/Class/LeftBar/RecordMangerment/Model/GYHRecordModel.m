//
//  GYHRecordModel.m
//  AVKY
//
//  Created by Marcello on 16/8/6.
//  Copyright © 2016年 杰. All rights reserved.
//

#import "GYHRecordModel.h"

@implementation GYHRecordModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.caseCatogory = @"请选择";
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.caseDetail = [aDecoder decodeObjectForKey:@"casedetail"];
        self.caseCatogory = [aDecoder decodeObjectForKey:@"caseCatogory"];
        self.desArray = [aDecoder decodeObjectForKey:@"desArray"];
        self.describe = [aDecoder decodeObjectForKey:@"describe"];
        self.picArray = [aDecoder decodeObjectForKey:@"picArray"];
        self.catogoryIndex = [aDecoder decodeIntegerForKey:@"catogoryIndex"];
        self.selectedAssets = [aDecoder decodeObjectForKey:@"selectedAssets"];
        self.pictureDict = [aDecoder decodeObjectForKey:@"pictureDict"];
        
        self.time = [aDecoder decodeObjectForKey:@"time"];


    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.caseDetail forKey:@"casedetail"];
    [aCoder encodeObject:self.caseCatogory forKey:@"caseCatogory"];
    [aCoder encodeObject:self.desArray forKey:@"desArray"];
    [aCoder encodeObject:self.describe forKey:@"describe"];
    [aCoder encodeObject:self.picArray forKey:@"picArray"];
    [aCoder encodeInteger:self.catogoryIndex forKey:@"catogoryIndex"];
    
    [aCoder encodeObject:self.pictureDict forKey:@"pictureDict"];
    
    [aCoder encodeObject:self.selectedAssets forKey:@"selectedAssets"];
    
    [aCoder encodeObject:self.time forKey:@"time"];

}



@end
