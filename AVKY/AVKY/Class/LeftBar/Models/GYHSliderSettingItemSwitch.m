//
//  GYHSliderSettingItemSwitch.m
//  AVKY
//
//  Created by Marcello on 16/8/4.
//  Copyright © 2016年 杰. All rights reserved.
//

#import "GYHSliderSettingItemSwitch.h"

@implementation GYHSliderSettingItemSwitch

- (void)setOn:(BOOL)on {
    _on = on;
   // [CZSaveTool saveBool:on forKey:self.title];
}

- (void)setTitle:(NSString *)title {
    [super setTitle:title];
   // _on = [CZSaveTool boolForKey:title];
}

@end
