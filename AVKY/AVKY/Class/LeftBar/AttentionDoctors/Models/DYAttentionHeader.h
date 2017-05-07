//
//  DYAttentionHeader.h
//  AVKY
//
//  Created by Yangdongwu on 16/8/8.
//  Copyright © 2016年 杰. All rights reserved.
//

#ifndef DYAttentionHeader_h
#define DYAttentionHeader_h

/**
 枚举:用来判断是从哪里跳到这里来的
 */
typedef enum {
    /**
     *  从关注医生
     */
    DYPushFromAttentionDoctor = 2,
    /**
     *  从就诊申请
     */
    DYPushFromSickCall = 3,
    
} DYPushFrom;


#endif /* DYAttentionHeader_h */
