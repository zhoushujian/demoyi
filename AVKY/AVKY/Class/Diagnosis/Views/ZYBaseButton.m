//
//  ZYBaseButton.m
//  AVKY
//
//  Created by 周勇 on 16/8/4.
//  Copyright © 2016年 杰. All rights reserved.
//

#import "ZYBaseButton.h"

@implementation ZYBaseButton

-(void)layoutSubviews{

    [super layoutSubviews];
    //对titleLabel和imageView图片位置重新布局
    CGFloat totalW = self.bounds.size.width;
    CGFloat totalH = self.bounds.size.height;
    CGFloat titleW = self.titleLabel.bounds.size.width;
    CGFloat titleH = self.titleLabel.bounds.size.height;
    CGFloat imgW = self.imageView.bounds.size.width;
    CGFloat imgH = self.imageView.bounds.size.height;
    CGFloat marginY = (totalH - imgH -titleH)/3;
    CGFloat imgX = (totalW - imgW)/2;
    CGFloat imgY = marginY;
    CGFloat titleX = (totalW - titleW)/2;
    CGFloat titleY = 2*marginY + imgH;
    
    self.imageView.frame = CGRectMake(imgX, imgY, imgW, imgH);
    self.titleLabel.frame = CGRectMake(titleX, titleY, titleW, titleH);
    self.titleLabel.textColor = [UIColor blackColor];

}
@end
