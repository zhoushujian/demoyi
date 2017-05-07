//
//  DYStepCountLabel.m
//  AVKY
//
//  Created by Yangdongwu on 16/8/4.
//  Copyright © 2016年 杰. All rights reserved.
//

#import "DYStepCountLabel.h"

@implementation DYStepCountLabel

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.textAlignment = NSTextAlignmentCenter;
    self.textColor = globalColor;
    self.font = FONT(30);
}


@end
