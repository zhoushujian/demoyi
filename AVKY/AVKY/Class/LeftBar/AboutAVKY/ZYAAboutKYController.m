//
//  ZYAAboutKYController.m
//  AVKY

//  Created by zheng on 16/8/5.
//  Copyright © 2016年 杰. All rights reserved.


#import "ZYAAboutKYController.h"
#import "Masonry.h"
#import <WebKit/WebKit.h>

@interface ZYAAboutKYController ()

//中间间隔线
@property(nonatomic,strong)UIView *lineView;

//版本label
@property(nonatomic,strong)UILabel *versionLabel;

//交流label
@property(nonatomic,strong)UILabel *commuteLabel;

//点击用户协议的view
@property(nonatomic,strong)UIView *clickView;

@end

@implementation ZYAAboutKYController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupUI];
}

#pragma mark -添加子控件
-(void)setupUI {
    //中间间隔线
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:lineView];
    
    //versionLabel
    UILabel *versionLabel = [[UILabel alloc] init];
    versionLabel.textColor = [UIColor lightGrayColor];
    versionLabel.text = @"Version:1.1.0";
    versionLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:versionLabel];
    
    //commuteLabel
    UILabel *commuteLabel = [[UILabel alloc] init];
    commuteLabel.textColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"pipeidu"]];
    commuteLabel.text = @"用户交流群:3838438";
    commuteLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:commuteLabel];
    
    //clickView
    UIView *clickView = [[UIView alloc] init];
    //添加手势
    UITapGestureRecognizer *clickGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickAction)];
    [clickView addGestureRecognizer:clickGesture];
    [self.view addSubview:clickView];
    
    //右边图标
    UIImageView *rightImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"position-right"]];
    [clickView addSubview:rightImg];
    
    //iconView
    UIImageView *iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"product_img_icon_xieyi.png"]];
    [clickView addSubview:iconView];
    
    //textBtn
    UILabel *textLabel = [[UILabel alloc] init];
    textLabel.text = @"用户协议";
    textLabel.textColor = [UIColor grayColor];
    [clickView addSubview:textLabel];
    
    //logoTextImg
    UIImageView *logoTextImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"product_text_logo_nor.png"]];
    [self.view addSubview:logoTextImg];
    
    //logopicImg
    UIImageView *logoPicImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"product_img_logo_nor.png"]];
    [self.view addSubview:logoPicImg];

    //约束子控制器
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(8);
        make.right.mas_equalTo(self.view.mas_right).offset(-8);
        make.centerY.mas_equalTo(self.view.mas_centerY).offset(40);
        make.height.mas_equalTo(1);
    }];
    
    [versionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-10);
        make.height.mas_equalTo(40);
    }];
    
    [commuteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.height.mas_equalTo(40);
        make.bottom.mas_equalTo(versionLabel.mas_top).offset(-10);
    }];
    
    [clickView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(lineView.mas_left);
        make.bottom.mas_equalTo(lineView.mas_top);
        make.right.mas_equalTo(lineView.mas_right);
        make.height.mas_equalTo(40);
    }];
    
    [rightImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(clickView.mas_right);
        make.size.mas_equalTo(CGSizeMake(15, 15));
        make.centerY.mas_equalTo(clickView.mas_centerY);
        
    }];
    
    [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(clickView.mas_centerY);
        make.left.mas_equalTo(clickView.mas_left);
        make.size.mas_equalTo(CGSizeMake(15, 15));
    }];
    
    [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(iconView.mas_right).offset(20);
        make.top.mas_equalTo(clickView.mas_top);
        make.bottom.mas_equalTo(clickView.mas_bottom);
        make.width.mas_equalTo(100);
    }];
    
    [logoTextImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(100, 50));
        make.bottom.mas_equalTo(clickView.mas_top).offset(-50);
    }];
    
    [logoPicImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(100, 100));
        make.bottom.mas_equalTo(logoTextImg.mas_top).offset(-10);
    }];
    
}

#pragma mark - 用户协议的点击事件

-(void)clickAction {
    NSURL *url = [NSURL URLWithString:@"http://baike.baidu.com/link?url=O6s0CJKYaBUobzPh9IgEIIO5ICTUuUrlqZsxhCMVlJ_fBcrAZuzQWViVyw64jXlybN0rXRBQwYh6I-6o_1vqX8sWQa4pGEelTQUVWk1ua52ZQciB5VLxY4IwjQnh_f9J"];
    WKWebView *webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
    [self.view addSubview:webView];
}

//懒加载
-(UIView *)clickView{
    if (!_clickView) {
        _clickView = [[UIView alloc] init];
    }
    return _clickView;
}

-(UILabel *)commuteLabel{
    if (!_commuteLabel) {
        _commuteLabel = [[UILabel alloc] init];
        _commuteLabel.textColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"pipeidu"]];
        _commuteLabel.text = @"用户交流群:3838438";
        _commuteLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _commuteLabel;
}

-(UILabel *)versionLabel{
    if (!_versionLabel) {
        _versionLabel = [[UILabel alloc] init];
        _versionLabel.textColor = [UIColor lightGrayColor];
        _versionLabel.text = @"Version:1.1.0";
        _versionLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _versionLabel;
}

-(UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor grayColor];
    }
    return _lineView;
}


@end
