//
//  YZWeightPicker.m
//  AVKY
//
//  Created by EZ on 16/8/9.
//  Copyright © 2016年 杰. All rights reserved.
//

#import "YZWeightPicker.h"
#import "HMProvince.h"

@interface YZWeightPicker ()<UIPickerViewDataSource,UIPickerViewDelegate>
/**
 *  遮盖按钮
 */
@property (nonatomic, strong) UIButton *coverBtn;
/**
 *  pickerView
 */
@property (nonatomic, weak) UIPickerView *pickerView;
/**
 *  数组数组
 */
@property (nonatomic, strong) NSArray *numbers;

/**
 *  label数组
 */
@property (nonatomic, strong) NSArray *strings;

@end

@implementation YZWeightPicker

+(instancetype)weightPicker {
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
    
    //1,添加子控件
    //创建一个labe
    UILabel *nameLabel = [[UILabel alloc] init];
    [self addSubview:nameLabel];
    self.nameLabel = nameLabel;
    nameLabel.font = FONT(18);
    nameLabel.textColor = globalColor;
    
    //两条横分割线
    UIView *topLineView = [[UIView alloc] init];
    [self addSubview:topLineView];
    topLineView.backgroundColor = COLOR(88, 88, 88);
    
    UIView *bottomLineView = [[UIView alloc] init];
    [self addSubview:bottomLineView];
    bottomLineView.backgroundColor = COLOR(88, 88, 88);
    //竖分割线
    UIView *verticalView = [[UIView alloc] init];
    [self addSubview:verticalView];
    verticalView.backgroundColor = COLOR(88, 88, 88);
    
    //pickerView
    UIPickerView *pickerView = [[UIPickerView alloc] init];
    pickerView.delegate = self;
    pickerView.dataSource = self;
    [self addSubview:pickerView];
//    self.pickerView = pickerView;
    
    //创建一个确定
    UIButton *certain = [[UIButton alloc] init];
    [self addSubview:certain];
    [certain setTitleColor:globalColor forState:UIControlStateNormal];
    [certain setTitle:@"确认" forState:UIControlStateNormal];
    certain.titleLabel.font = FONT(18);
    [certain addTarget:self action:@selector(didClickCertainButton) forControlEvents:UIControlEventTouchUpInside];
    certain.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    //创建一个取消
    UIButton *cancelButton = [[UIButton alloc] init];
    [self addSubview:cancelButton];
    [cancelButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    cancelButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    cancelButton.titleLabel.font = FONT(18);
    [cancelButton addTarget:self action:@selector(didClickCancelButton) forControlEvents:UIControlEventTouchUpInside];
    
    /************************ 子控件布局 *******************************/
    
    //label
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo(self).offset(10);
        make.height.mas_equalTo(25);
    }];
    
    //上分割线
    [topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(nameLabel.mas_bottom).offset(10);
        make.height.mas_equalTo(1);
        make.left.right.mas_equalTo(self);
    }];
    
    //pickerView
    [pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(topLineView.mas_bottom);
        make.height.mas_equalTo(120);
        make.left.right.mas_equalTo(self);
    }];
    
    //下分割线
    [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(pickerView.mas_bottom);
        make.height.mas_equalTo(1);
        make.left.right.mas_equalTo(self);
    }];
    
    //竖分割线
    [verticalView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bottomLineView.mas_bottom);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.bottom.mas_equalTo(self.mas_bottom);
        make.width.mas_equalTo(1);
    }];
    
    //取消按钮
    [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(5);
        make.right.mas_equalTo(verticalView.mas_left).offset(-5);
        make.top.mas_equalTo(bottomLineView.mas_bottom).offset(10);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-10);
    }];
    
    //确认按钮
    [certain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(verticalView.mas_right).offset(5);
        make.right.mas_equalTo(self).offset(-5);
        make.top.mas_equalTo(verticalView);
        make.bottom.mas_equalTo(verticalView);
    }];
    
}

#pragma mark - 展示和关闭

/**
 *  显示窗口
 */
-(void)show
{
    //获取window主窗口 直接添加上去,这样做的好去就是不与任何类有关联
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    self.backgroundColor = [UIColor whiteColor];
    [window addSubview:self.coverBtn];
    [window addSubview:self];
    
    //做适配
    CGFloat width;
    if (is4inch) {
        width = 100;
    }else if (is47inch || is55inch){
        width = 160;
    }
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(window);
        make.width.mas_equalTo(screenW - width);
        make.height.mas_equalTo(210);
    }];
    
    [self.coverBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.bottom.mas_equalTo(window);
    }];
}

/**
 *  隐藏pickerView
 */
-(void)dismiss{
    
    [self.coverBtn removeFromSuperview];
    [self removeFromSuperview];

}

#pragma mark - 实现 UIPickerView 代理方法
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{

    //通过KVC 方式 给数组对应的label的共同属性赋值
    [self.strings[component] setValue:self.numbers[component][row] forKey:@"text"];
}

// 告诉pickerView每一行要显示什么内容
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    // 数据源(数组)中的数据 数组 ---> 子数组1(第一列)    子数组2(第二列)   子数组3(第三列)
    // 根据列号在数据源中取每一列的数据(子数组(第一列的数据))
    return self.numbers[component][row];
}

#pragma mark - 实现 UIPickerView 数据源方法
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    //component 列号  拿到列号后再我们构建的数据源(数组--->三个子数组)里面取对应的数据
    // 根据列号在数据源中取出对应列的集合(数据源NSArray里面的每一子数组),每一个子数组的个数就是每一列的行数
    return  [self.numbers[component] count];
}
// 告诉pickerView要显示多少列数据
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    /*
     分析数据:
     我们自己的数据是一个数组:
     数组中包含三个子数组,并且每一个子数组对应pickerView的每一列
     每一个子数组中的元素对应的就是pickerView的每一行要显示的数据
     */
    return self.numbers.count;
}

#pragma mark - 懒响应事件
/**
 *  点击了取消按钮
 */
-(void)didClickCancelButton {
    [self dismiss];
}
/**
 *  点击了确认按钮
 */
-(void)didClickCertainButton {
    
    //1.用可变字符串拼接数字字符串
    NSMutableString *str = [[NSMutableString alloc] init];
    for (UILabel *label in self.strings) {
        if (label.text == nil) {
            label.text = @"0";
        }
        [str appendString:label.text];
    }
    //2.转换成不可变的字符串
    NSString *numberStr = [NSString stringWithString:str];
    
    //3.判断str字符串第一个字符是不是0
    if ([numberStr hasPrefix:@"0"]) {
        numberStr = [numberStr substringFromIndex:1];
    }

    //4.判断bolck是否实现,
    if (self.pickerViewValueChangeBlock) {
        
        self.pickerViewValueChangeBlock(numberStr);
    }
    [self dismiss];
}

#pragma mark - 懒加载
/**
 *  遮罩
 */
- (UIButton *)coverBtn {
    if (_coverBtn == nil) {
        _coverBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _coverBtn.backgroundColor = globalColor;
        _coverBtn.alpha = 0.1;
    }
    return _coverBtn;
}

/**
 * 数字数组
 */
-(NSArray *)numbers {
    if (_numbers == nil) {
        _numbers = [HMProvince numbersList];
    }
    return _numbers;
}

/**
 *  label数组
 */
-(NSArray *)strings {
    if(_strings == nil){
        //创建三个label
        UILabel *label_a = [[UILabel alloc] init];
        UILabel *label_b = [[UILabel alloc] init];
        UILabel *label_c = [[UILabel alloc] init];
        NSArray *arr = [NSArray arrayWithObjects:label_a,label_b,label_c, nil];
        _strings = arr;
    }
    return _strings;
}
@end





