//
//  GYHTybeillnessController.h
//  AVKY
//
//  Created by Marcello on 16/8/5.
//  Copyright © 2016年 杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GYHTybeillnessController : UIViewController

/**
 *  获取回调选中的字符串
 */
@property (nonatomic, copy) void(^getTypeString)(NSString *string,NSInteger index);

@end
