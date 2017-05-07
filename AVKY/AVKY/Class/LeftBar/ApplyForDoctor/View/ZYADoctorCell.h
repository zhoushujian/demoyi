//
//  ZYADoctorCell.h
//  AVKY
//
//  Created by zheng on 16/8/9.
//  Copyright © 2016年 杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYADoctor.h"

@interface ZYADoctorCell : UITableViewCell

@property(nonatomic,strong)ZYADoctor *doctor;

+(instancetype)doctorCellWithTableView:(UITableView*)tableView;

@end
