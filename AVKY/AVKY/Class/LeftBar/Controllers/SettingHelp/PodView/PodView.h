//
//  PodView.h
//  AVKY
//
//  Created by 杰 on 16/8/9.
//  Copyright © 2016年 杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <POP.h>

typedef NS_ENUM(NSInteger, FlyType) {
    FlyTypeUToD     = 0,
    FlyTypeDToD     = 1,
};
@interface PodView : UIView
@property (nonatomic, strong) UIView *flyView;
@property (nonatomic, assign) CGFloat fly_w;
@property (nonatomic, assign) CGFloat fly_h;


- (void)startFly:(FlyType)type;

@end
