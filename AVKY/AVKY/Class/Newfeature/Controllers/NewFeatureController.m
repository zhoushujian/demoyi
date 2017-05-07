//
//  NewFeatureController.m
//  AVKY
//
//  Created by 杰 on 16/8/4.
//  Copyright © 2016年 杰. All rights reserved.
//

#import "NewFeatureController.h"
#import "KYTabarController.h"
#import "ICSDrawerController.h"
#import "LeftBarController.h"
#import "GYHNOLoginLeftController.h"
#import "UserAccount.h"
#define Image_Count 4
@interface NewFeatureController ()


@property (strong,nonatomic) NewFeatureController *featureVC;

@property(nonatomic,strong)LeftBarController *leftController;

@property(nonatomic,strong)KYTabarController *MainController;

/**
 *  未登录侧边栏
 */
@property (nonatomic, strong) GYHNOLoginLeftController *noLoginController;

@property(nonatomic,strong)ICSDrawerController *ISCDController;
@end

@implementation NewFeatureController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setscrollView];
    // Do any additional setup after loading the view.
}

-(void)setscrollView{
    
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    [self.view addSubview:scrollView];
    scrollView.contentSize = CGSizeMake(Image_Count * [UIScreen mainScreen].bounds.size.width, 0);
    scrollView.pagingEnabled = YES;
    scrollView.bounces = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    
    for (int i = 0; i < Image_Count; ++i) {
        
        
        CGFloat X = i * width;
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(X, 0, width, height)];
        
        imageView.userInteractionEnabled = YES;
        
        //新特性图片加载要使用imageWithContentsOfFile:这种方法不会产生缓存
        
        NSString *imageName = [NSString stringWithFormat:@"swizard%d_568@2x.jpg",i + 1];
        
        
//        
//        if (is4inch) {
//            imageName = [NSString stringWithFormat:@"swizard%d_480@2x.jpg",i + 1];
//        }
        
        NSString *path = [[NSBundle mainBundle] pathForResource:imageName ofType:nil];
        
        imageView.image = [UIImage imageWithContentsOfFile:path];
        
        
        
        if (i ==1) {
            NSLog(@"%@",imageView);
        }
            
            if(i == Image_Count - 1){
            
            UIButton *button = [self setStartBtn];
            
            [imageView addSubview:button];
        }
        
        [scrollView addSubview:imageView];
    }
}




-(UIButton *)setStartBtn{
    

    UIButton *button = [[UIButton alloc] init];

    
    button.frame = CGRectMake(0, 0, 300, 80);
    
    button.center = CGPointMake(self.view.center.x, self.view.bounds.size.height * 0.8);
    
    [button addTarget:self action:@selector(didClickstartButton) forControlEvents:UIControlEventTouchUpInside];
    
    return button;
    
}


-(void)didClickstartButton{
    

    
    //修改window的根控制器
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    //将window的根控制器先存到属性里面，用来做动画
    self.featureVC = (NewFeatureController *)window.rootViewController;
    //设置window的根控制器，如果前面的根控制器没有强指针指向就会被释放
    window.rootViewController = self.ISCDController;;
    
    //将新特性控制器添加到window才能用来制作动画
    [window addSubview:self.featureVC.view];
    [UIView animateWithDuration:1.0 animations:^{
        
        CGRect frame = self.view.frame;
        frame.origin.x = -frame.size.width;
        self.view.frame = frame;
        
    } completion:^(BOOL finished) {

        //动画结束后移除新特性控制器的view
        [self.featureVC.view removeFromSuperview];
        //释放新特性控制器
        self.featureVC = nil;

    }];
    
}

-(KYTabarController *)MainController{
    if (!_MainController) {
        _MainController = [[KYTabarController alloc]init];
    }
    return _MainController;
}

-(LeftBarController *)leftController{
    if (!_leftController) {
        _leftController = [[LeftBarController alloc]init];
    }
    return _leftController;
}


- (GYHNOLoginLeftController *)noLoginController{
    
    if (!_noLoginController) {
        
        _noLoginController = [[GYHNOLoginLeftController alloc] init];
    }
    return _noLoginController;
}

-(ICSDrawerController *)ISCDController{
    if (!_ISCDController) {
        
        //判断是否登录
        
        NSLog(@" ====登录了吗%zd",[UserAccount sharedUserAccount].isLogin);
        if ([UserAccount sharedUserAccount].isLogin) {
            
            _ISCDController = [[ICSDrawerController alloc]initWithLeftViewController:self.leftController centerViewController:self.MainController];
        }else{
            
        _ISCDController = [[ICSDrawerController alloc]initWithLeftViewController:self.noLoginController centerViewController:self.MainController];
        }

    }
    return _ISCDController;
}

-(void)dealloc{
    
   NSLog(@"新特性删除");
    
}


@end
