//
//  UITextField+image.m
//  AVKY
//
//  Created by EZ on 16/8/4.
//  Copyright © 2016年 杰. All rights reserved.
//

#import "UITextField+image.h"
#import "Masonry.h"

@implementation UITextField (image)

+(void)setTextFieldLeftImage:(UITextField *)textField image:(NSString *)imageName {
    
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 16, 20)];
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:imageName];
    [leftView addSubview:imageView];
    
    //约束imageView
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(leftView).offset(5);
        make.right.mas_equalTo(leftView);
        make.top.mas_equalTo(leftView);
        make.bottom.mas_equalTo(leftView.mas_bottom);
    }];
    
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.leftView = leftView;
}
@end
