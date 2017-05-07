//
//  ZYcomposeCell.m
//  AVKY
//
//  Created by 周勇 on 16/8/10.
//  Copyright © 2016年 杰. All rights reserved.
//

#import "ZYcomposeCell.h"

@interface ZYcomposeCell ()
@property (weak, nonatomic) IBOutlet UILabel *lbltext;

@end

@implementation ZYcomposeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

-(void)setFd:(ZYfirstStageDisease *)fd{
    _fd = fd;
    self.lbltext.text = fd.ci3_name;
}
- (IBAction)compose:(UIButton *)sender {
//    NSLog(@"%zd",sender.tag);
    NSMutableDictionary * dict = [[NSMutableDictionary alloc]init]; ;
    switch (sender.tag) {
        case 10:
            dict = [[NSMutableDictionary alloc]initWithDictionary:@{@"delete":_fd}];
            break;
        case 20:
            dict = [[NSMutableDictionary alloc]initWithDictionary:@{@"top":_fd}];
            break;
        case 30:
            dict = [[NSMutableDictionary alloc]initWithDictionary:@{@"move":_fd}];
            break;
            
        default:
            break;
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"composeCell" object:nil userInfo:dict];
}

@end
