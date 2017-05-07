//
//  DYSickCallController.m
//  AVKY
//
//  Created by Yangdongwu on 16/8/9.
//  Copyright © 2016年 杰. All rights reserved.
//

#import "DYSickCallController.h"
#import "GYHRecordMangerController.h"
#import "KYNavigationController.h"

@interface DYSickCallController ()

/**
 *  病历管理modal的navigationController
 */
@property (nonatomic, strong) KYNavigationController *navC;

@end

@implementation DYSickCallController


- (void)dismiss {
    NSLog(@"%@",self.navC);
    
    [self.navC dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)chackCaseOfIllness:(UIButton *)sender {
    
    GYHRecordMangerController *recordController = [[GYHRecordMangerController alloc] init];
    recordController.navigationItem.title = @"病历管理";
    
    KYNavigationController *navC = [[KYNavigationController alloc] initWithRootViewController:recordController];
    
    self.navC = navC;
    
    //[self.navigationController pushViewController:recordController animated:YES];
    
    [self presentViewController:navC animated:YES completion:^{
    
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"back" style:UIBarButtonItemStylePlain target:self action:@selector(dismiss)];
        
        recordController.navigationItem.leftBarButtonItem = backItem;
        
    }];
    
}

- (IBAction)symptomButtonClick:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    
}

- (IBAction)sickHistoryButtonClick:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
