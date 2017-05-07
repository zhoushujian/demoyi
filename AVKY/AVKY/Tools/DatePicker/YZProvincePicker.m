//
//  YZProvincePicker.m
//  AVKY
//
//  Created by EZ on 16/8/9.
//  Copyright © 2016年 杰. All rights reserved.
//

#import "YZProvincePicker.h"
#import "HMProvince.h"



@interface YZProvincePicker ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (weak, nonatomic) NSString *province;
@property (weak, nonatomic) NSString *city;
@property (nonatomic,assign) NSInteger proIndex;
@property (nonatomic,strong) NSArray *citys;

/**
 *  遮盖按钮
 */
@property (nonatomic, strong) UIButton *coverBtn;
/**
 *  工具条
 */
@property (nonatomic,strong) UIView *keyBoardtTool;

@end

@implementation YZProvincePicker

+(instancetype)provincePicker {
    return [[self alloc] init];
}

//纯代码创建的子控件会调用这个方法
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

//从xib创建的子控件会调用这个方法
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    return self;
}

#pragma mark - 设置UI

-(void)setup{
    //创建 pickerView
    UIPickerView *pickerView = [[UIPickerView alloc] init];
    pickerView.delegate = self;
    pickerView.dataSource = self;
    [self addSubview:pickerView];
    self.pickerView = pickerView;
    
    [self.pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.height.mas_equalTo(216);
        make.bottom.mas_equalTo(self.mas_bottom);
    }];
    
    //创建工具条
    [self addSubview:self.keyBoardtTool];
    
    [self.keyBoardtTool mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self);
        make.height.mas_equalTo(40);
        make.left.mas_equalTo(self);
        make.right.mas_equalTo(self);
    }];
    
    UIButton *confirm = [[UIButton alloc] init];
    [self.keyBoardtTool addSubview:confirm];
    
    [confirm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.keyBoardtTool).offset(-10);
        make.centerY.mas_equalTo(self.keyBoardtTool.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(50, 30));
    }];
    
    [confirm setTintColor:[UIColor orangeColor]];
    [confirm setTitle:@"确认" forState:UIControlStateNormal];
    confirm.titleLabel.textAlignment = NSTextAlignmentCenter;
    confirm.titleLabel.font = FONT(20);
    [confirm addTarget:self action:@selector(didClickConfirnButton) forControlEvents:UIControlEventTouchUpInside];

}

#pragma mark - 响应事件

-(void)didClickConfirnButton {

    if (self.province == nil) {
        [SVProgressHUD showErrorWithStatus:@"滚动还没结束!"];
        delay(1);
        return;
    }
    [self dismiss];
    
    if (self.pickerViewValueChangeBlock) {
        self.pickerViewValueChangeBlock(self.province,self.city);
    }
}

//显示
-(void)show
{
    //获取window主窗口 直接添加上去,这样做的好去就是不与任何类有关联
    UIWindow *window = [UIApplication sharedApplication].keyWindow;

    [window addSubview:self.coverBtn];
    [window addSubview:self];
    self.backgroundColor = globalColor;
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(window.mas_bottom);
        make.left.mas_equalTo(window);
        make.right.mas_equalTo(window);
        make.height.mas_equalTo(256);
    }];
    
    [self.coverBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(window);
        make.left.mas_equalTo(window);
        make.right.mas_equalTo(window);
        make.height.mas_equalTo(screenH - 256);
    }];
}

//隐藏
-(void)dismiss{
    
    // 以动画形式隐藏日期选择控件
    [UIView animateWithDuration:0.25 animations:^{
        self.frame = CGRectMake(0, screenH , screenW, self.frame.size.height);
    } completion:^(BOOL finished) {
        // 移除控件
        [self.coverBtn removeFromSuperview];
        [self removeFromSuperview];
    }];
}


#pragma mark - PickerView数据源方法
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
//    NSLog(@"返回每列多少行");
    if(component == 0){
        return self.citys.count;
    }else{
        HMProvince *pro = self.citys[self.proIndex];
        return pro.cities.count;
    }
    
}

#pragma mark - pickerView代理方法
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    if (component == 0) {
        HMProvince *pro = self.citys[row];
        return pro.name;
    }else{
        HMProvince *pro = self.citys[self.proIndex];
        return pro.cities[row];
    }
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0) {
        //保存省所在选中行的索引
        self.proIndex = [pickerView selectedRowInComponent:0];
        [pickerView reloadComponent:1];
    }
    
    //把省选中的行赋值给lab
    //    NSInteger provinceIndex = [pickerView selectedRowInComponent:0];
    self.province = [self.citys[self.proIndex] name];

    //把选中市的哪行赋值市lab
    NSInteger cityIndex = [pickerView selectedRowInComponent:1];
    //获取省对应的市
    HMProvince *pro = self.citys[self.proIndex];
    self.city = pro.cities[cityIndex];
}


#pragma mark - 懒加载
-(NSArray *)citys
{
    if (_citys == nil) {
        _citys = [HMProvince provincesList];
    }
    return _citys;
}
/**
 *  遮罩
 */
- (UIButton *)coverBtn {
    if (_coverBtn == nil) {
        _coverBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_coverBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        _coverBtn.backgroundColor = globalColor;
        _coverBtn.alpha = 0.1;
    }
    return _coverBtn;
}

/**
 *  工具条
 */
-(UIView *)keyBoardtTool {
    if (_keyBoardtTool == nil) {
        _keyBoardtTool = [[UIView alloc] init];
        _keyBoardtTool.backgroundColor = [UIColor orangeColor];
    }
    return _keyBoardtTool;
}

#pragma mark - dealloc
-(void)dealloc
{
    NSLog(@"%s",__func__);
}


@end
