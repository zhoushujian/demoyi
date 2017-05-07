//
//  DYSickCallController.h
//  AVKY
//
//  Created by Yangdongwu on 16/8/8.
//  Copyright © 2016年 杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DYPatientInfoController : UIViewController

/**
 *  block
 */
@property (nonatomic, copy) void (^patientInfoBlock)();

@end
