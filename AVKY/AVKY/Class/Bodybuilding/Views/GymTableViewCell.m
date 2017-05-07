//
//  GymTableViewCell.m
//  AVKY
//
//  Created by rayChow on 16/8/9.
//  Copyright © 2016年 杰. All rights reserved.
//

#import "GymTableViewCell.h"
#import "GymNewsModel.h"
#import "UIButton+WebCache.h"

@interface GymTableViewCell ()

/**
 *  图片
 */
@property (nonatomic, weak) IBOutlet UIButton *iconBtn;
/**
 *  标题
 */
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
/**
 *  摘要
 */
@property (nonatomic, weak) IBOutlet UILabel *digestLabel;
/**
 *  跟帖数
 */
@property (nonatomic, weak) IBOutlet UILabel *replyCountLabel;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *imgextraBtns;

@end

@implementation GymTableViewCell

- (void)setNewsModel:(GymNewsModel *)newsModel {
    _newsModel = newsModel;
    [self.iconBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:newsModel.imgsrc] forState:UIControlStateNormal];
    self.titleLabel.text = newsModel.title;
    self.digestLabel.text = newsModel.digest;
    self.replyCountLabel.text = [NSString stringWithFormat:@"%@跟帖",newsModel.replyCount];
    [newsModel.imgextra enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *iconBtn = self.imgextraBtns[idx];
        [iconBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:obj[@"imgsrc"]] forState:UIControlStateNormal];
    }];
}

+ (CGFloat)rowHeigth:(GymNewsModel *)newsModel {
    if (newsModel.imgextra) {
        return 110;
    }else if (newsModel.imgType) {
        return 150;
    }else {
        return 90;
    }
}

+ (NSString *)identifierWithNew:(GymNewsModel *)newsModel {
    if(newsModel.imgextra) {
        return @"threeImageCell";
    } else if(newsModel.imgType){
        return @"bigImageCell";
    } else{
        return @"news";
    }
}

@end
