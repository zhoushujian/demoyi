//
//  DYTodayTargetSetController.m
//  AVKY
//
//  Created by Yangdongwu on 16/8/4.
//  Copyright © 2016年 杰. All rights reserved.
//

#import "DYTodayTargetSetController.h"
#import "YZWeightPicker.h"

#define margin 40
#define textFieldHeight 30

@interface DYTodayTargetSetController ()
/**
 *  今日任务输入框
 */
@property (nonatomic, strong) UITextField *todayTargetSetTextFiled;
/**
 *  设置今日目标的按钮
 */
@property (nonatomic, strong) UIButton *setTodayTargetButton;

@end

@implementation DYTodayTargetSetController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"pic_hd_1"]];
    //设置UI
    [self setupUI];
    //设置navItem
    [self setupNavBarItem];
}

- (void)setupNavBarItem {
    self.navigationItem.title = @"每日目标设置";
}


- (void)setupUI {
    
    //添加子控件
    [self.view addSubview:self.todayTargetSetTextFiled];
    [self.view addSubview:self.setTodayTargetButton];
    
    //设置子控件
    self.todayTargetSetTextFiled.borderStyle = UITextBorderStyleRoundedRect;
    self.todayTargetSetTextFiled.placeholder = @"请输入进入目标步数";
    self.todayTargetSetTextFiled.keyboardType = UIKeyboardTypeNumberPad;
    
    
    self.setTodayTargetButton.backgroundColor = [UIColor greenColor];
    [self.setTodayTargetButton setTitle:@"确定" forState:UIControlStateNormal];
    [self.setTodayTargetButton setTitleColor:globalColor forState:UIControlStateNormal];
    [self.setTodayTargetButton setBackgroundImage:[UIImage imageNamed:@"link_button_02"] forState:UIControlStateNormal];
    [self.setTodayTargetButton addTarget:self action:@selector(setTodayTargetButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //自动布局子控件
    [self.todayTargetSetTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_topLayoutGuide).offset(margin);
        make.left.equalTo(self.view).offset(margin);
        make.height.mas_equalTo(textFieldHeight);
    }];
    
    [self.setTodayTargetButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_topLayoutGuide).offset(margin);
        make.left.equalTo(self.todayTargetSetTextFiled.mas_right).offset(margin);
        make.right.equalTo(self.view).offset(-margin);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(textFieldHeight);
    }];
    
}




#pragma mark - 点击事件
/**
 *  点击设置步数调用block
 */
- (void)setTodayTargetButtonClick:(UIButton *)sender {
    
    if (self.todayTargetSetTextFiled.text.length == 0) {
        
        [SVProgressHUD showErrorWithStatus:@"请输入步数"];
        delay(1.0);
        
        return;
    }
    
    if (self.todayTargetSetTextFiled.text != nil) {
        self.todayTargetBlock(self.todayTargetSetTextFiled.text);
    }
}

#pragma mark - 内存警告和销毁
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark - 懒加载
- (UITextField *)todayTargetSetTextFiled {
    if (_todayTargetSetTextFiled == nil) {
        _todayTargetSetTextFiled = [[UITextField alloc] init];
    }
    return _todayTargetSetTextFiled;
}

- (UIButton *)setTodayTargetButton {
    if (_setTodayTargetButton == nil) {
        _setTodayTargetButton = [[UIButton alloc] init];
    }
    return _setTodayTargetButton;
}

@end
