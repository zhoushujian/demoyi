//
//  GYHLoginView.h
//  AVKY
//
//  Created by Marcello on 16/8/7.
//  Copyright © 2016年 杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GYHLoginView : UIView

/**
 *  登录回调
 */
@property (nonatomic, copy) void(^goToLogin)();

/**
 *  注册回调
 */
@property (nonatomic, copy) void (^goToRegister)();

@end
