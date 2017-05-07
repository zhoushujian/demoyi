//
//  GYHDescListController.h
//  AVKY
//
//  Created by Marcello on 16/8/7.
//  Copyright © 2016年 杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GYHDescListController : UIViewController

@property (nonatomic, copy) void(^getStringArr)(NSMutableArray *stringArray);

@property (nonatomic, strong) NSMutableArray *cacheStringArray;

@end
