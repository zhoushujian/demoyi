//
//  CYXPhotoCell.m
//  AVKY
//
//  Created by 杰 on 16/8/4.
//  Copyright © 2016年 杰. All rights reserved.
//

#import "CYXPhotoCell.h"

@interface CYXPhotoCell ()

@property (nonatomic, weak) UIImageView *imageView; /**< <#注释#> */

@end

@implementation CYXPhotoCell



- (instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        self.layer.borderWidth = 2;
        self.layer.borderColor = [UIColor whiteColor].CGColor;
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 15.0;
        
        UIImageView  *imageView = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
        self.imageView = imageView;
        [self.contentView addSubview:imageView];
    }
    return self;
}

- (void)setImageName:(NSString *)imageName{
    
    _imageName = [imageName copy];
    
    self.imageView.image = [UIImage imageNamed:imageName];
    
}

@end
