//
//  HealthcareView.m
//  AVKY
//
//  Created by 杰 on 16/8/7.
//  Copyright © 2016年 杰. All rights reserved.
//

#import "HealthcareView.h"

@interface HealthcareView ()

@property (weak, nonatomic) IBOutlet UIButton *Images;

@end
@implementation HealthcareView



-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self setUI];
    }
    return self;
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        
        
        [self setUI];
    }
    return self;
}
-(void)setUI{
    
}
@end
