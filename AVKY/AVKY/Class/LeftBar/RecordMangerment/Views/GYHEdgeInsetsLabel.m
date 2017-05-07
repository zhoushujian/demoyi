//
//  GYHEdgeInsetsLabel.m
//  AVKY
//
//  Created by Marcello on 16/8/7.
//  Copyright © 2016年 杰. All rights reserved.
//

#import "GYHEdgeInsetsLabel.h"

@interface GYHEdgeInsetsLabel ()



@end

@implementation GYHEdgeInsetsLabel

- (instancetype)init{
    
    if (self = [super init]) {
        
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
        
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    if (self = [super initWithCoder:aDecoder]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    
    self.userInteractionEnabled = YES;
}

- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines {
    UIEdgeInsets insets = self.edgeInsets;
    CGRect rect = [super textRectForBounds:UIEdgeInsetsInsetRect(bounds, insets)
                    limitedToNumberOfLines:numberOfLines];
    
    rect.origin.x    -= insets.left;
    rect.origin.y    -= insets.top;
    rect.size.width  += (insets.left + insets.right);
    rect.size.height += (insets.top + insets.bottom);
    
    return rect;
}

- (void)drawTextInRect:(CGRect)rect {
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, self.edgeInsets)];
}

//点击的时候从父布局中移除
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
//    NSLog(@"hello你好");
    
    self.isDeleted  = !self.isDeleted;
    
    if (self.isDeleted) {
        
        self.textColor = [UIColor redColor];
        if (self.deleteFromSuperView) {
            
            self.deleteFromSuperView(self.text);
        }
    }else{
        //self.textColor = globalColor;
    }
    

    
    

//    [UIView animateWithDuration:1.0 animations:^{
//        [self removeFromSuperview];
//    }];
}


@end
