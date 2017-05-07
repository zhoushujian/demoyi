//
//  RuntimeBtn.m
//  AVKY
//
//  Created by 杰 on 16/8/10.
//  Copyright © 2016年 杰. All rights reserved.
//

#import "RuntimeBtn.h"


static const  NSTimeInterval defarationTime =3.0;

static BOOL _isInterVal = NO;

static void regatios(){
    _isInterVal = NO;
}

@implementation RuntimeBtn


-(void)sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event{
    _Time = _Time == 0 ? defarationTime : _Time;
    
    if (_isInterVal) {
        return;
    }else if( _Time > 0 ){
        _isInterVal = YES;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(_Time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            regatios();
        });
    }
    [super sendAction:action to:target forEvent:event];
    
    
    
}


@end
