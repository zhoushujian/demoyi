//
//  LoopText.m
//  AVKY
//
//  Created by 杰 on 16/8/4.
//  Copyright © 2016年 杰. All rights reserved.
//

#import "LoopText.h"


@interface LoopText()


@property(nonatomic,strong)UIButton *doctBtn;




@property(nonatomic,strong)NSArray *arrays;
@end

@implementation LoopText


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setUI];
    }
    return self;
}
-(void)setUI{
    [self addSubview:self.doctBtn];
    


}



-(void)layoutSubviews{
    [super layoutSubviews];

    [self.doctBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.width.mas_equalTo(self);
        make.bottom.top.mas_equalTo(self);
    }];
 

}


-(UIButton *)doctBtn{
    if (!_doctBtn) {
        NSString *FamousDoctor = NSLocalizedString(@"Doctor", nil);
        _doctBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_doctBtn setImage:[UIImage imageNamed:@"ic_fack_keyboard_btn_send"] forState:UIControlStateNormal];
        
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:FamousDoctor];
        [str beginEditing];
        
        [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14.0] range:NSMakeRange(0, 5)];
        [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Verdana" size:14] range:NSMakeRange(0, 5)];


        [_doctBtn setAttributedTitle:str forState:UIControlStateNormal];
        
        _doctBtn.imageEdgeInsets = UIEdgeInsetsMake(5, -30, 5, 0);
        _doctBtn.userInteractionEnabled = NO;

    }
    return _doctBtn;
}



@end
