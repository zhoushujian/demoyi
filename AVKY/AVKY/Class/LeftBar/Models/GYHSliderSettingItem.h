//
//  GYHSliderSettingItem.h
//  AVKY
//
//  Created by Marcello on 16/8/4.
//  Copyright © 2016年 杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GYHSliderSettingItem : NSObject


typedef void (^OperationBlock)();


// 图标
@property(nonatomic,copy) NSString *icon;
// 标题
@property(nonatomic,copy) NSString *title;
// 子标题
@property(nonatomic,copy) NSString *subTitle;
// 点击 cell 要执行的操作
@property(nonatomic,copy) OperationBlock operationBlock;
//@property(nonatomic,assign) CZItemType  itemType;
+(instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon;

+(instancetype)itemWithTitle:(NSString *)title subTitle:(NSString *)subTitle;

+(instancetype)itemWithTitle:(NSString *)title;

@end
