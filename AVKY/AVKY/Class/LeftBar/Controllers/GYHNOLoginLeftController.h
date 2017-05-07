//
//  GYHNOLoginLeftController.h
//  AVKY
//
//  Created by Marcello on 16/8/5.
//  Copyright © 2016年 杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ICSDrawerController.h"
@interface GYHNOLoginLeftController : UIViewController<ICSDrawerControllerChild,ICSDrawerControllerPresenting>

/**
 *  抽屉窗口
 */
@property(nonatomic, weak) ICSDrawerController *drawer;

@end
