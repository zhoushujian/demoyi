//
//  FindHeadView.m
//  AVKY
//
//  Created by 杰 on 16/8/6.
//  Copyright © 2016年 杰. All rights reserved.
//

#import "FindHeadView.h"
#import "HealthcareView.h"
#import "JZMenuButton.h"
#import "DrugView.h"
#import "XRCarouselView.h"
#import "DYWebViewController.h"
#import "KYNavigationController.h"

#import "ICSDrawerController.h"

@interface FindHeadView ()

@property(nonatomic,strong)HealthcareView *HealthcareView;

@property(nonatomic,strong)UIView *CategoryView;

@property(nonatomic,strong)DrugView *drugView;

@property(nonatomic,strong)NSArray *images;

@property(nonatomic,strong)NSArray *titles;



@property(nonatomic,strong)XRCarouselView *carouselView;


/**
 *  图片链接
 */
@property (nonatomic, strong) NSArray *girlHTMLArray;

@end
@implementation FindHeadView

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithRed:240/255.0 green:243/255.0 blue:242/255.0 alpha:1];
        [self setUI];
    }
    return self;
}

-(void)setUI{
    [self addSubview:self.carouselView];
    [self addSubview:self.CategoryView];
    
    
    CGFloat appW=([UIScreen mainScreen].bounds.size.width-100)/4;
    CGFloat appH=60;
    CGFloat leftJ=20;
    CGFloat topJ=10;
    
    for (int i=0; i<8; i++) {
        CGFloat hang=i/4;
        CGFloat lie=i%4;
        
        CGFloat appX=leftJ+lie*(leftJ+appW);
        CGFloat appY=topJ+hang*(topJ+appH);
        
        NSString *path = [NSString stringWithFormat:@"jibing03%d",i];
        UIImage *image = [UIImage imageNamed:path];
         JZMenuButton *app=[[JZMenuButton alloc]initWithFrame:CGRectMake(appX, appY, appW, appH)];

        [self.CategoryView addSubview:app];
        [app setTag:i];
        [app setImage:image forState:UIControlStateNormal];
        app.titleLabel.font =[UIFont systemFontOfSize:12];
        [app setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [app setTitle:self.titles[i] forState:UIControlStateNormal];
        [app addTarget:self action:@selector(downButton:) forControlEvents:UIControlEventTouchUpInside];
        
    }

    [self addSubview:self.HealthcareView];
    
    [self addSubview:self.drugView];
}

-(void)downButton:(UIButton *)sender{
    NSLog(@"%ld",sender.tag);
    
    NSString *urlString = self.girlHTMLArray[sender.tag];
    
    DYWebViewController *web = [[DYWebViewController alloc] initWithUrlString:urlString];
    
    ICSDrawerController *icsDrawController = (ICSDrawerController *)[self getCurrentRootViewController];
    
   UITabBarController *tab =(UITabBarController*)icsDrawController.centerViewController;
    UINavigationController *nav = tab.selectedViewController;
    [nav popViewControllerAnimated:NO];

    [nav pushViewController:web animated:NO];

    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self.carouselView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(self);
        make.height.mas_equalTo(self.mas_height).multipliedBy(0.3);
    }];
    [self.CategoryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.top.mas_equalTo(self.carouselView.mas_bottom);
        make.height.mas_equalTo(self.mas_height).multipliedBy(0.22);
    }];
    
    [self.HealthcareView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
       make.top.mas_equalTo(self.CategoryView.mas_bottom).offset(4);
        make.height.mas_equalTo(self.mas_height).multipliedBy(0.25);
        
    }];
    [self.drugView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self);
        make.top.mas_equalTo(self.HealthcareView.mas_bottom).offset(4);
        
    }];
    
    
}


-(UIView *)CategoryView{
    if (!_CategoryView) {
        _CategoryView = [[UIView alloc]init];
        _CategoryView.backgroundColor = [UIColor whiteColor];
    }
    return _CategoryView;
}



-(HealthcareView *)HealthcareView{
    if (!_HealthcareView) {
        _HealthcareView = [[[NSBundle mainBundle]loadNibNamed:@"HealthcareView" owner:nil options:nil ]lastObject];
    }
    return _HealthcareView;
}

-(NSArray *)titles{
    if (!_titles) {
        _titles = @[@"干货",@"购物",@"分类",@"男性",@"女性",@"老人",@"药到家",@"体检"];
    }
    return _titles;
}

-(DrugView *)drugView{
    if (!_drugView) {
        _drugView = [[[NSBundle mainBundle]loadNibNamed:@"DrugView" owner:nil options:nil]lastObject];
        _drugView.backgroundColor = [UIColor colorWithRed:240/255.0 green:243/255.0 blue:242/255.0 alpha:1];
    }
    return _drugView;
}
-(NSArray *)images{
    if (!_images) {
        _images = @[[UIImage imageNamed:@"lun1.jpg"], [UIImage imageNamed:@"lun2.jpg"], [UIImage imageNamed:@"lun3.jpg"],[UIImage imageNamed:@"lun4.jpg"], [UIImage imageNamed:@"lun5.jpg"],[UIImage imageNamed:@"lun6.jpg"]];
        
        
    }
    return _images;
}

-(XRCarouselView *)carouselView{
    if (!_carouselView) {
        _carouselView = [XRCarouselView carouselViewWithImageArray:self.images describeArray:nil];
        _carouselView.time = 2;
        _carouselView.changeMode = ChangeModeFade;
        _carouselView.pagePosition = PositionBottomCenter;
        [_carouselView setPageColor:globalColor andCurrentPageColor:[UIColor whiteColor]];
        
    }
    return _carouselView;
}


- (NSArray *)girlHTMLArray{
    
    if (!_girlHTMLArray ) {
        
        _girlHTMLArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"GirlList" ofType:@"plist"]];
    }
    
    return _girlHTMLArray;
}



/**
 *  获取当前View的控制器
 *
 *  @return <#return value description#>
 */
-(UIViewController *)getCurrentRootViewController {
    
    
    UIViewController *result;
    // Try to find the root view controller programmically
    // Find the top window (that is not an alert view or other window)
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
