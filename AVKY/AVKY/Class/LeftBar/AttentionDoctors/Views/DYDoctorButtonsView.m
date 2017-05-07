//
//  DYDoctorButtonsView.m
//  AVKY
//
//  Created by Yangdongwu on 16/8/5.
//  Copyright © 2016年 杰. All rights reserved.
//

//优化备用类

#import "DYDoctorButtonsView.h"
#import "DYChartCell.h"
#import "DYPatientInfoController.h"
#import "YZNetworkTool+Attention.h"
#import <SobotKit/SobotKit.h>

#define buttonHeight 40
#define collectionViewCellIdentifier @"collectionViewCellIdentifier"
#define margin 10

@interface DYDoctorButtonsView () <UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

/**
 *  显示内容的scrollView
 */
@property (nonatomic, strong) UIScrollView *scrollView;
/**
 *  按钮数组
 */
@property (nonatomic, strong) NSMutableArray *buttonArray;
/**
 *  提示View
 */
@property (nonatomic, strong) UIView *tipView;
/**
 *  显示内容的数组
 */
@property (nonatomic, strong) NSMutableArray *contentArray;
/**
 *  按钮的名字数组
 */
@property (nonatomic, strong) NSArray *buttonTitleArray;
/**
 *  选中按钮的index
 */
@property (nonatomic, assign) NSInteger selectedIndex;
/**
 *  按钮宽度
 */
@property (nonatomic, assign) CGFloat buttonWidth;
/**
 *  collectionView
 */
@property (nonatomic, strong) UICollectionView *collectionView;
/**
 *  UICollectionViewFlowLayout
 */
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
/**
 *  预约数组
 */
@property (nonatomic, strong) NSArray *bespokenArray;
/**
 *  记录cell的
 */
@property (nonatomic, strong) NSIndexPath *indexPath;
/**
 *  咨询医生按钮
 */
@property (nonatomic, strong) UIButton *consultDoctorButton;


@end


@implementation DYDoctorButtonsView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    
    self.backgroundColor = [UIColor orangeColor];
    //================== 注册cell =================//
    UINib *nib = [UINib nibWithNibName:@"DYChartCell" bundle:[NSBundle mainBundle]];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:collectionViewCellIdentifier];
    
}

- (void)netRequset {
    
    //================== 接诊条件请求 =================//
    NSString *urlJieZhen = @"http://iosapi.itcast.cn/doctor/doctorReceivingSetting.json.php";
    NSDictionary *parametersJieZhen = @{@"doctor_id":@300000315};
    [[YZNetworkTool sharedManager] requestDoctorListWithUrl:urlJieZhen parameters:parametersJieZhen callBack:^(id responseBody) {
        
        if ([responseBody isKindOfClass:[NSError class]]) {
            [SVProgressHUD showErrorWithStatus:@"您的网络不给力"];
            delay(0.5);
            return;
        }
        
        UITextView *textView = self.contentArray[0];
        NSDictionary *dataDictionary = responseBody[@"data"];
        NSString *receiving_setting_extra = dataDictionary[@"receiving_setting_extra"];
        NSArray *receiving_settings = dataDictionary[@"receiving_settings"];
        NSString *string = [[NSString alloc] init];
        for (NSString *str in receiving_settings) {
            string = [NSString stringWithFormat:@"%@\n%@\n",string,str];
        }
        NSString *finalString = [NSString stringWithFormat:@"%@\n%@",receiving_setting_extra,string];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            textView.text = finalString;
        });
    }];
    //================== 医生简介请求 =================//
    NSString *urlJianJie = @"http://iosapi.itcast.cn/doctor/getIntroduction.json.php";
    NSDictionary *parametersJianJie = @{@"doctor_id":@300000315};
    [[YZNetworkTool sharedManager] requestDoctorListWithUrl:urlJianJie parameters:parametersJianJie callBack:^(id responseBody) {
        
        if ([responseBody isKindOfClass:[NSError class]]) {
            [SVProgressHUD showErrorWithStatus:@"您的网络不给力"];
            delay(0.5);
            return;
        }
        
        UITextView *textView = self.contentArray[1];
        NSDictionary *dataDictionary = responseBody[@"data"];
        NSString *introduction = dataDictionary[@"introduction"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            textView.text = introduction;
        });
    }];
}

- (void)setPushFrom:(DYPushFrom)pushFrom {
    _pushFrom = pushFrom;
    //设置UI
    [self setupUI];
    
    [self buttonClick:self.buttonArray[0]];
    //================== 网络请求 =================//
    [self netRequset];
    
}

#pragma mark - 设置UI
- (void)setupUI {
    //添加子控件
    [self addSubview:self.scrollView];
    [self addSubview:self.tipView];
    
    //按钮宽度
    self.buttonWidth = screenW / self.pushFrom;
    
    //创建设置按钮
    for (int i = 0; i < self.pushFrom; ++i) {
        UIButton *button = [[UIButton alloc] init];
        [self addSubview:button];
        [self.buttonArray addObject:button];
        button.frame = CGRectMake(i * self.buttonWidth, 0, self.buttonWidth, buttonHeight);
        button.tag = i;
        [button setTitle:self.buttonTitleArray[i] forState:UIControlStateNormal];
        [button setTitleColor:globalColor forState:UIControlStateSelected];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"link_button_02"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    //按钮下面的view
    self.tipView.frame = CGRectMake(0, buttonHeight + 1, self.buttonWidth, 2);
    
    //设置scrollView的contentSize
    self.scrollView.contentSize = CGSizeMake(screenW * self.pushFrom, 0);
    //自动布局scrollView
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(buttonHeight + 3);
        make.left.right.bottom.equalTo(self);
    }];
    
    
    
    
}

#pragma mark - 点击事件
- (void)buttonClick:(UIButton *)button {
    //点击偏移
    [self.scrollView setContentOffset:CGPointMake(button.tag * screenW, 0) animated:YES];
    UIButton *selectedButton = self.buttonArray[self.selectedIndex];
    selectedButton.selected = NO;
    button.selected = YES;
    self.selectedIndex = button.tag;
    
    [UIView animateWithDuration:0.5 animations:^{
        CGRect tipFrame = self.tipView.frame;
        tipFrame.origin.x = self.buttonWidth * button.tag;
        self.tipView.frame = tipFrame;
    }];
    
}

#pragma mark - 点击了智牙齿
- (void)consultDoctorClick:(UIBarButtonItem *)sender {

    if (self.consultDoctorBlock) {
        self.consultDoctorBlock();
    }
}

#pragma mark - scrollView的代理方法

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat offsetX = scrollView.contentOffset.x;
    NSInteger  selectedIndex = offsetX / screenW;

    [self buttonClick:self.buttonArray[selectedIndex]];
}

#pragma mark - 布局子控件函数
- (void)layoutSubviews {
    [super layoutSubviews];
    for (int i = 0; i < 3; ++i) {
        if (i == 2) {
            //预约时间表格
            NSArray *array;
            if (self.bespokenArray.count > 0) {
                array = self.bespokenArray[0];
            }
            [self.scrollView addSubview:self.collectionView];
            self.collectionView.frame = CGRectMake(i * screenW, 50, screenW, screenW * self.bespokenArray.count / array.count - self.bespokenArray.count + 1);
            self.collectionView.backgroundColor = [UIColor lightGrayColor];
            
            
            //================== 添加咨询医生按钮 =================//
            [self.scrollView addSubview:self.consultDoctorButton];
            
            [self.consultDoctorButton setTitle:@"咨询医生" forState:UIControlStateNormal];
            [self.consultDoctorButton setBackgroundImage:[UIImage imageNamed:@"buttonBackground2"] forState:UIControlStateNormal];

            [self.consultDoctorButton addTarget:self action:@selector(consultDoctorClick:) forControlEvents:UIControlEventTouchUpInside];
            
            self.consultDoctorButton.frame = CGRectMake(i * screenW + margin, self.scrollView.bounds.size.height - buttonHeight - margin, screenW - 2 * margin, buttonHeight);
            
        }
        else {
            UITextView *textView = self.contentArray[i];
            textView.editable = NO;
            textView.text = @"🎎努力😄加载😄数据😄中...";
            textView.font = FONT(18);
            textView.textAlignment = NSTextAlignmentCenter;
            textView.frame = CGRectMake(i * screenW, 0, screenW, self.scrollView.bounds.size.height);
            [self.scrollView addSubview:textView];
            textView.backgroundColor = [UIColor whiteColor];
        }
        
    }
}

#pragma mark - UICollectionView 代理方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return self.bespokenArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    NSArray *array = self.bespokenArray[section];
    
    return array.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DYChartCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionViewCellIdentifier forIndexPath:indexPath];
    if (indexPath.section == 0) {
        cell.backgroundColor = [UIColor grayColor];
    }
    else {
        cell.backgroundColor = [UIColor clearColor];
    }
    
    NSArray *array = self.bespokenArray[indexPath.section];
    
    [cell.button setTitle:array[indexPath.row] forState:UIControlStateNormal];
    [cell.button setTitleColor:globalColor forState:UIControlStateNormal];
    
    return cell;
}

#pragma mark - collectionView 的代理方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    self.indexPath = indexPath;
    
    DYChartCell *cell = (DYChartCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    NSString *string = cell.button.currentTitle;

    if ([string isEqualToString:@"有号"]) {
        
        DYPatientInfoController *patientInfoController = [[DYPatientInfoController alloc] init];
        
        patientInfoController.patientInfoBlock = ^{
            
            DYChartCell *cell = (DYChartCell *)[self.collectionView cellForItemAtIndexPath:self.indexPath];
            
            [cell.button setTitle:@"已约" forState:UIControlStateNormal];
            
        };
        
        self.patientBlock(patientInfoController);
        
    }
    
    
}

#pragma mark - 懒加载
- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
    }
    return _collectionView;
}

- (UICollectionViewFlowLayout *)layout {
    if (_layout == nil) {
        _layout = [[UICollectionViewFlowLayout alloc] init];
        
        CGFloat itemWidth = (screenW - (8 + 1) * 1)/8;
        
        _layout.itemSize = CGSizeMake(itemWidth, itemWidth);
        
        _layout.minimumLineSpacing = 1;
        
        _layout.minimumInteritemSpacing = 1;
        
    }
    return _layout;
}

- (UIScrollView *)scrollView {
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.bounces = NO;
    }
    return _scrollView;
}

- (NSMutableArray *)contentArray {
    if (_contentArray == nil) {
        _contentArray = [[NSMutableArray alloc] init];
        for (int i = 0; i < self.pushFrom; ++i) {
            UITextView *textView = [[UITextView alloc] init];
            textView.showsVerticalScrollIndicator = NO;
            textView.showsHorizontalScrollIndicator = NO;
            [_contentArray addObject:textView];
        }
    }
    return _contentArray;
}

- (NSMutableArray *)buttonArray {
    if (_buttonArray == nil) {
        _buttonArray = [[NSMutableArray alloc] init];
    }
    return _buttonArray;
}

- (NSArray *)buttonTitleArray {
    if (_buttonTitleArray == nil) {
        _buttonTitleArray = @[@"接诊条件",@"医生简介",@"预约时间"];
    }
    return _buttonTitleArray;
}

- (UIView *)tipView {
    if (_tipView == nil) {
        _tipView = [[UIView alloc] init];
        _tipView.backgroundColor = globalColor;
    }
    return _tipView;
}

- (NSArray *)bespokenArray {
    if (_bespokenArray == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"yuyue" ofType:@"plist"];
        _bespokenArray = [NSArray arrayWithContentsOfFile:path];
    }
    return _bespokenArray;
}

- (UIButton *)consultDoctorButton {
    if (_consultDoctorButton == nil) {
        _consultDoctorButton = [[UIButton alloc] init];
    }
    return _consultDoctorButton;
}


@end
