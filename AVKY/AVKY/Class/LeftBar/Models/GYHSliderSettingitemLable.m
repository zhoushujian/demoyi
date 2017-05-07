//
//  GYHSliderSettingitemLable.m
//  AVKY
//
//  Created by Marcello on 16/8/4.
//  Copyright © 2016年 杰. All rights reserved.
//

#import "GYHSliderSettingitemLable.h"

@implementation GYHSliderSettingitemLable

+(instancetype)itemWithTitle:(NSString *)title defaultValue:(NSString *)value{
    GYHSliderSettingitemLable *item = [self itemWithTitle:title];
    if (item.value.length == 0 || item.value == nil) {
        item.value = value;
    }
    return item;
}
+(instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon defaultValue:(NSString *)value{
    GYHSliderSettingitemLable *item = [self itemWithTitle:title icon:icon];
    if (item.value.length == 0 || item.value == nil) {
        item.value = value;
    }
    return item;
}


- (void)setValue:(NSString *)value {
    _value = value;
    //[CZSaveTool saveValue:value forKey:self.title];
}

- (void)setTitle:(NSString *)title {
    [super setTitle:title];
    //_value = [CZSaveTool valueForKey:title];
}

- (void)dealloc {
    NSLog(@"CZSettingItemLabel = %@",self.title);
}


@end
