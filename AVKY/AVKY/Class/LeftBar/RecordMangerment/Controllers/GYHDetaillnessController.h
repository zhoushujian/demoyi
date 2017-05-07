//
//  GYHDetaillnessController.h
//  AVKY
//
//  Created by Marcello on 16/8/5.
//  Copyright © 2016年 杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GYHDetaillnessController : UIViewController

/**
 *  疾病的类型
 */
@property (nonatomic,assign) NSInteger illnessIndex;

@property (nonatomic, strong) void(^getInessString)(NSString *illnessString,NSInteger index);

@end
