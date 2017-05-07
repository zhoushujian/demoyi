//
//  GYHDesrcibleView.h
//  AVKY
//
//  Created by Marcello on 16/8/5.
//  Copyright © 2016年 杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GYHDesrcibleView : UIView

@property (nonatomic, copy) NSString *typeString;

@property (nonatomic, copy) void(^didClickButton)(NSMutableArray *tempDesArray);

/**
 *  字符串数组
 */
@property (nonatomic, strong) NSMutableArray *stringArray;

/**
 *  标签 数组回调
 */
@property (nonatomic, copy) void(^callBackDesString)(NSMutableArray *desStringArray);
/**
 *  详情字符数组回调
 */
@property (nonatomic, copy) void(^callBackTextString)(NSString *textString);

/**
 *  病历详情
 */
@property (nonatomic, strong) NSString * desText;

@end
