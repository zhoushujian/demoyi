//
//  GYHRecordPictureView.h
//  AVKY
//
//  Created by Marcello on 16/8/5.
//  Copyright © 2016年 杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GYHRecordPictureView : UIView

/**
 *  图片数组回调
 */
@property (nonatomic, copy) void(^callBackImageArray)(NSMutableArray *iamge);


/**
 *  图片数组回调
 */
@property (nonatomic, copy) void(^callBackPictureDict)(NSDictionary *dict);

/**
 *  设置图片数组
 */
@property (nonatomic, strong) NSMutableArray *ImageArray;


/**
 *  缓存要显示的图片
 */
@property (nonatomic, strong) NSMutableArray *tempImageArray;


@property (nonatomic, strong)  NSDictionary* pictureDict;



@end
