//
//  DYStepTitleLabel.m
//  AVKY
//
//  Created by Yangdongwu on 16/8/4.
//  Copyright © 2016年 杰. All rights reserved.
//

#import "DYStepTitleLabel.h"

@implementation DYStepTitleLabel

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.textAlignment = NSTextAlignmentCenter;
    self.textColor = [UIColor grayColor];
    self.font = FONT(14);
}

@end
