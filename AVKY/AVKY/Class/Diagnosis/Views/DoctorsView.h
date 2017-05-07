//
//  DoctorsView.h
//  AVKY
//
//  Created by 杰 on 16/8/4.
//  Copyright © 2016年 杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol famosDocButtonDelegete <NSObject>

-(void)buttonClickWith:(NSInteger)index;

@end

@interface DoctorsView : UIView

@property (nonatomic, weak) id<famosDocButtonDelegete> delegate;

@end
