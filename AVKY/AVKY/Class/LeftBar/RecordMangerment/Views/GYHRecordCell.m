//
//  GYHRecordCell.m
//  AVKY
//
//  Created by Marcello on 16/8/8.
//  Copyright © 2016年 杰. All rights reserved.
//

#import "GYHRecordCell.h"
#import "GYHRecordModel.h"

@interface GYHRecordCell ()

@property (weak, nonatomic) IBOutlet UILabel *timeLbale;

@property (weak, nonatomic) IBOutlet UILabel *recordNameLable;


@property (weak, nonatomic) IBOutlet UIImageView *recordPicture;


@property (weak, nonatomic) IBOutlet UILabel *desTextLable;

@end

@implementation GYHRecordCell

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    if (self = [super initWithCoder:aDecoder]) {
        
        //self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = globalColor;
        self.selectedBackgroundView = view;
        
        UIView *deleteView = [[UIView alloc] init];
        deleteView.backgroundColor = [UIColor blueColor];
        
        [self.contentView addSubview:deleteView];
    }
    
    return self;
}


- (void)setRecordModel:(GYHRecordModel *)recordModel{
    _recordModel = recordModel;
    self.timeLbale.text = _recordModel.time;
    
    UIImage *image;
    if (recordModel.picArray.count == 1 || recordModel.picArray == nil) {
        image = [UIImage imageNamed:@"patient_defaultphoto_male"];
    }else{
        image= recordModel.picArray[0];
    }
    //病历图片
    self.recordPicture.image = image;
    //病历类型
    self.recordNameLable.text = recordModel.caseCatogory;
    //病历描述
    self.desTextLable.text = recordModel.describe;
    
}

@end
