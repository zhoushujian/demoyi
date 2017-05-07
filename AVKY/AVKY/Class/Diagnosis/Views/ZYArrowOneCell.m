//
//  ZYArrowOneCell.m
//  AVKY
//
//  Created by 周勇 on 16/8/5.
//  Copyright © 2016年 杰. All rights reserved.
//

#import "ZYArrowOneCell.h"

@interface ZYArrowOneCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;

@end
#define isIphone5s
@implementation ZYArrowOneCell


- (void)awakeFromNib {
    [super awakeFromNib];
    [UIDevice currentDevice];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(labelTextChange:) name:deseaseNotificationKey object:nil];
    
}
/**
 *  实现controller的跳转
 */
- (IBAction)buttonClick:(UIButton *)sender {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"buttonClickJump" object:nil userInfo:@{@"jump":[[NSNumber alloc]initWithInteger:_index]}];
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    [super setHighlighted:NO animated:animated];
}


/**
 *  初始设置文字
 */
-(void)setIndex:(NSInteger)index{
    _index = index;
    switch (index) {
        case 0:
            self.titleLbl.text = @"请选择疾病类型";
            break;
        case 1:
            self.titleLbl.text = @"请选择并发症(可多选)";
            break;
        case 4:
            self.titleLbl.text = @"请选择治疗方式";
            break;
        default:
            break;
    }
}
/**
 *  通知方法
 *
 *  @param notification 通知参数
 */
-(void)labelTextChange:(NSNotification *)notification{
    if (notification.userInfo[@"key"]!=nil && _index == 0) {
        
        self.titleLbl.text = notification.userInfo[@"key"];
        self.titleLbl.textColor = [UIColor blackColor];
        //开启其余cell的用户交互
        _cellInterEnable = YES;
        [[NSNotificationCenter defaultCenter]postNotificationName:@"cellInter" object:nil userInfo:@{@"inter":[NSNumber numberWithBool:_cellInterEnable],@"info":notification.userInfo[@"key"]}];
    }else if (notification.userInfo[@"arr"]!=nil && _index == 1 ){
        NSArray * arr = notification.userInfo[@"arr"];
        
        NSString * part2 =[NSString stringWithFormat:@"[共%zd项]",arr.count];
        self.titleLbl.textColor = [UIColor blackColor];
        NSString *all = [NSString stringWithFormat:@"%@%@",[arr componentsJoinedByString:@","],part2];
        NSMutableAttributedString * mastr = [[NSMutableAttributedString alloc]initWithString:all];
        NSRange range = [all rangeOfString:part2];
        [mastr addAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} range:range];
        self.titleLbl.attributedText = mastr;
    }else if (notification.userInfo[@"method"]!=nil && _index ==4){
        
        self.titleLbl.text = notification.userInfo[@"method"];
        self.titleLbl.textColor = [UIColor blackColor];
    }
}
/**
 *  移除通知
 */
-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:deseaseNotificationKey object:nil];
}

-(void)setCellInterEnable:(BOOL)cellInterEnable{
    
    _cellInterEnable = cellInterEnable;
}
@end
