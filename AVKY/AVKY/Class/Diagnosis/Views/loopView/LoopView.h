//
//  LoopView.h
//  AVKY
//
//  Created by 杰 on 16/8/4.
//  Copyright © 2016年 杰. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MyBlock)();

@interface LoopView : UIView

@property(nonatomic,copy)MyBlock myBlock;

@end
