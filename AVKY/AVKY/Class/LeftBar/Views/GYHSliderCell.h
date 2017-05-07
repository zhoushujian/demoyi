//
//  GYHSliderCell.h
//  AVKY
//
//  Created by Marcello on 16/8/4.
//  Copyright © 2016年 杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GYHSliderSettingItem.h"

@interface GYHSliderCell : UITableViewCell

+(instancetype)cellWithTabelView:(UITableView *)tableView;

@property(nonatomic,strong) GYHSliderSettingItem *item;
// 是否显示分割线
@property(nonatomic,assign) BOOL  showLineView;

@end
