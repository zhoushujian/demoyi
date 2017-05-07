//
//  ZYselectCell.m
//  AVKY
//
//  Created by 周勇 on 16/8/5.
//  Copyright © 2016年 杰. All rights reserved.
//

#import "ZYselectCell.h"

@interface ZYselectCell ()
@property (weak, nonatomic) IBOutlet UILabel *titlelbl;
@property (weak, nonatomic) IBOutlet UIButton *DifineButton;
@property (weak, nonatomic) IBOutlet UIButton *LikeButton;
@property (nonatomic, strong) UIButton *selectedButton;
@property (nonatomic, assign) BOOL clickEnable;
@end

@implementation ZYselectCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}
- (IBAction)buttonClick:(UIButton *)sender {
    
    self.selectedButton.selected = NO;
    sender.selected = YES;
    self.selectedButton = sender;
    if (sender.selected == YES && sender.tag == 1) {
        _showCell = YES;
    }else{
        _showCell = NO;
    }
    if (_index == 3) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"show" object:nil userInfo:@{@"show":[NSNumber numberWithBool:_showCell]}];
    }
    
    if (sender.tag == 2 && sender.selected == YES && _index == 3) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"showBottom" object:nil userInfo:@{@"bottom":@0}];
        
    }

    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(void)setIndex:(NSInteger)index{
    
    _index = index;
    
    switch (index) {
        case 2:
            self.titlelbl.text = @"是否确诊";
            break;
        case 3:
            self.titlelbl.text = @"是否接受过治疗";
            [self.DifineButton setTitle:@"已接受" forState:UIControlStateNormal];
            [self.LikeButton setTitle:@"未接受过" forState:UIControlStateNormal];
            break;
        default:
            break;
    }
}

-(void)setShowCell:(BOOL)showCell
{
    _showCell = showCell;
}

@end
