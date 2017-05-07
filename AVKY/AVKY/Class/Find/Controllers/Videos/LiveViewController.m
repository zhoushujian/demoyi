//
//  LiveViewController.m
//  XJZombieMovie
//
//  Created by 杰 on 16/8/7.
//  Copyright © 2016年 杰. All rights reserved.
//

#import "LiveViewController.h"
#import <IJKMediaFramework/IJKMediaFramework.h>
@interface LiveViewController ()

@property(nonatomic,strong)IJKFFMoviePlayerController *playVC;


@end

@implementation LiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //已加载就隐藏导航栏
    self.navigationController.navigationBar.hidden = YES;
    //设置背景为灰色
    self.view.backgroundColor = [UIColor grayColor];
    
    NSURL *url = [NSURL URLWithString:self.LiveUrl];
    
    IJKFFOptions *options = [IJKFFOptions optionsByDefault];
    
    self.playVC = [[IJKFFMoviePlayerController alloc]initWithContentURL:url withOptions:options];
    
    self.playVC.view.frame = self.view.bounds;
    //自动调整尺寸 --- 根据UI视图的自动尺寸
    self.playVC.view.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    //缩放模式
    self.playVC.scalingMode = IJKMPMovieScalingModeAspectFit;
    self.playVC.shouldAutoplay = YES;
    
    self.view.autoresizesSubviews = YES;
    
    [self.view addSubview:self.playVC.view];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame =CGRectMake(50, 50, 100, 100);
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(BtnClick) forControlEvents:UIControlEventTouchUpInside];
   
    
    [self.view addSubview:btn];
    
}

-(void)BtnClick{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //播放
    [self.playVC prepareToPlay];
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
//        关闭播放器
    [self.playVC shutdown];
}
@end
