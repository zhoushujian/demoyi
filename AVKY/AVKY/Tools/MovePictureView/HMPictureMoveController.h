//
//  ViewController.h
//  MoveButton
//
//  Created by fuzheng on 16-5-26.
//  Copyright © 2016年 付正. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMPictureMoveController : UIViewController

@property(nonatomic, strong)NSMutableArray *addGridTitleArray;//接收更多标签页面传过来的值
@property(nonatomic, strong)NSMutableArray *addGridImageArray;//image
@property(nonatomic, strong)NSMutableArray *addGridIDArray;//gridId

@property(nonatomic, strong)NSMutableArray *gridListArray;

@property(nonatomic, strong)NSMutableArray *showGridArray; //title
@property(nonatomic, strong)NSMutableArray *showGridImageArray;//image
@property(nonatomic, strong)NSMutableArray *showGridIDArray;//gridId

//更多页面显示应用
@property(nonatomic, strong)NSMutableArray *moreGridTitleArray;
@property(nonatomic, strong)NSMutableArray *moreGridIdArray;
@property(nonatomic, strong)NSMutableArray *moreGridImageArray;//image

@property(nonatomic, strong)UIView  *gridListView;

/**
 *  完成回调,返回图片个数
 */
@property (nonatomic, copy) void (^completeBlock)(CGFloat height);


/**
 *  图片数组回调
 */
@property (nonatomic, copy) void(^callBackImageArray)(NSMutableArray *iamge);


/**
 *  图片数组回调
 */
@property (nonatomic, copy) void(^callBackPictureDict)(NSDictionary *dict);

/**
 *  移动格子数组回调
 */
@property (nonatomic, copy) void(^callBackGirdDict)(NSDictionary *dict);

/**
 *  设置图片数组
 */
@property (nonatomic, strong) NSMutableArray *ImageArray;


/**
 *  缓存要显示的图片
 */
@property (nonatomic, strong) NSMutableArray *tempImageArray;

/**
 *  图片框架需要的参数
 */
@property (nonatomic, strong)  NSDictionary* pictureDict;


/**
 *  移动框架需要的参数
 */
@property (nonatomic, strong) NSDictionary *girdDict;

@end

