//
//  DYFunctionButton.m
//  AVKY
//
//  Created by Yangdongwu on 16/8/4.
//  Copyright © 2016年 杰. All rights reserved.
//

#import "DYFunctionButton.h"

@implementation DYFunctionButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup {

    [self setTitleColor:globalColor forState:UIControlStateNormal];
    [self setBackgroundImage:[UIImage imageNamed:@"link_button_02"] forState:UIControlStateNormal];
    
}

@end
