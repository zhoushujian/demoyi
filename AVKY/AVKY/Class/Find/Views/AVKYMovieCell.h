//
//  AVKYMovieCell.h
//  AVKY
//
//  Created by 杰 on 16/8/7.
//  Copyright © 2016年 杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieModel.h"
@interface AVKYMovieCell : UITableViewCell
//头像
@property(nonatomic,strong)UIImageView *HeadImage;
//主播姓名
@property(nonatomic,strong)UILabel *nameLb;
//城市
@property(nonatomic,strong)UIButton *cityBtn;
//观看人数
@property(nonatomic,strong)UILabel *watchNum;
//封面
@property(nonatomic,strong)UIImageView *personImage;
//下标题
@property(nonatomic,strong)UILabel *titleLb;

@property(nonatomic,strong)MovieModel *model;

+(instancetype)tableViewCell:(UITableView *)tableView;

@end
