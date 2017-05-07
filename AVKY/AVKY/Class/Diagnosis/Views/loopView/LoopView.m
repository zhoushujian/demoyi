//
//  LoopView.m
//  AVKY
//
//  Created by 杰 on 16/8/4.
//  Copyright © 2016年 杰. All rights reserved.
//

#import "LoopView.h"
#import "XRCarouselView.h"
#import "CYXLayoutViewController.h"
@interface LoopView ()
//第三方轮播器
@property (nonatomic, strong) XRCarouselView *carouselView;
//轮播图片数组
@property(nonatomic,strong)NSArray *images;

@end

@implementation LoopView


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];

        [self setUI];
        
      
    }
    return self;
}

-(void)setUI{
    [self addSubview:self.carouselView];


}
//重新布局
-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.carouselView.frame = self.bounds;
}

#pragma mark - 懒加载图片数组
-(NSArray *)images{
    if (!_images) {

        _images = @[[UIImage imageNamed:@"ad1.jpg"], [UIImage imageNamed:@"ad2.jpg"], [UIImage imageNamed:@"ad3.jpg"],[UIImage imageNamed:@"ad4.jpg"]];

        
    }
    return _images;
}
#pragma mark - 懒加载轮播器
-(XRCarouselView *)carouselView{
    if (!_carouselView) {
        __weak typeof(self) weakSelf = self;
        _carouselView = [[XRCarouselView alloc]initWithImageArray:self.images imageClickBlock:^(NSInteger index) {
            
            if (weakSelf.myBlock) {
                weakSelf.myBlock();
            }

        }];

        _carouselView.time = 2;
        _carouselView.changeMode = ChangeModeFade;
        _carouselView.pagePosition = PositionBottomCenter;
        [_carouselView setPageColor:globalColor andCurrentPageColor:[UIColor whiteColor]];

    }
    return _carouselView;
}

/**
 *  获取当前View的控制器
 *
 */
#pragma mark -获取当前View的控制器
-(UIViewController *)getCurrentRootViewController {
    
    
    UIViewController *result;
    
  
    UIWindow *topWindow = [[UIApplication sharedApplication] keyWindow];
    
    
    if (topWindow.windowLevel != UIWindowLevelNormal)
        
        
    {
        
        
        NSArray *windows = [[UIApplication sharedApplication] windows];
        
        
        for(topWindow in windows)
            
            
        {
            
            
            if (topWindow.windowLevel == UIWindowLevelNormal)
                
                
                break;
            
            
        }
        
        
    }
    
    
    UIView *rootView = [[topWindow subviews] objectAtIndex:0];
    
    
    id nextResponder = [rootView nextResponder];
    
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        
        
        result = nextResponder;
    
    
    else if ([topWindow respondsToSelector:@selector(rootViewController)] && topWindow.rootViewController != nil)
        
        
        result = topWindow.rootViewController;
    
    
    else
        
        
        NSAssert(NO, @"ShareKit: Could not find a root view controller.  You can assign one manually by calling [[SHK currentHelper] setRootViewController:YOURROOTVIEWCONTROLLER].");
    
    
    return result;
    
    
}

@end
