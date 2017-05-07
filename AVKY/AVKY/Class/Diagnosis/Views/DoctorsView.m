//
//  DoctorsView.m
//  AVKY
//
//  Created by 杰 on 16/8/4.
//  Copyright © 2016年 杰. All rights reserved.
//

#import "DoctorsView.h"
#import "ZYBaseButton.h"

@interface DoctorsView ()

//九宫格数组
@property (nonatomic, strong) NSMutableArray *buttons;

@end

@implementation DoctorsView


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor grayColor];
        [self createFDbuttonAndController];
    }
    return self;
}

-(void)createFDbuttonAndController{
    self.buttons = [NSMutableArray array];
    for (int i = 0; i < 6; ++i) {
        ZYBaseButton * button = [ZYBaseButton new];
        button.tag = i;
        button.backgroundColor = [UIColor whiteColor];
        [self addSubview:button];

            [button addTarget:self action:@selector(jumpToController:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.buttons addObject:button];
    }
}
/**
 *  布局子控件
 */
#pragma mark - 国际化及重新布局子控件
-(void)layoutSubviews
{
    [super layoutSubviews];
    NSString *tumour = NSLocalizedString(@"tumour", nil);//肿瘤
    NSString *Hematology = NSLocalizedString(@"Hematology", nil);//血液科
    NSString *Cardiovascular = NSLocalizedString(@"Cardiovascular", nil);//心血管
    NSString *NerveSection = NSLocalizedString(@"NerveSection", nil);//神经科
    NSString *Orthopaedics = NSLocalizedString(@"Orthopaedics", nil);//骨科
    NSString *Commonweal = NSLocalizedString(@"Commonweal", nil);//公益活动
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat viewHeight = self.frame.size.height;
    CGFloat margin= 1;
    int rowNumber = 3;
    NSArray * titleArr = @[tumour,Hematology,Cardiovascular,NerveSection,Orthopaedics,Commonweal];
    for (int i = 0; i < self.buttons.count; ++i) {
        int rowIdx = i / rowNumber;
        int colIdx = i % rowNumber;
        UIButton * button = self.buttons[i];
        
        CGFloat buttonW = (screenWidth - (rowNumber+1)*margin)/rowNumber;
        CGFloat buttonH = (viewHeight - 3)/2;
        CGFloat buttonX = margin+colIdx*(margin+buttonW);
        CGFloat buttonY = margin + rowIdx*(margin+buttonH);
        
        button.titleLabel.font = [UIFont systemFontOfSize:12];
        
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        [button setTitle:titleArr[i] forState:UIControlStateNormal];
        UIImage * img = [UIImage imageNamed:[NSString stringWithFormat:@"%d",i+1]];
        [button setImage:img forState:UIControlStateNormal];
    }
}
/**
 *  代理方法
 */
-(void)jumpToController:(UIButton*)button
{
     NSInteger index = button.tag;
    
  
        if ([self.delegate respondsToSelector:@selector(buttonClickWith:)]) {
            [self.delegate buttonClickWith:index];

    }
   
    
    
}
@end
