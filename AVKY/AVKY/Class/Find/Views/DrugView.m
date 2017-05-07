//
//  DrugView.m
//  AVKY
//
//  Created by 杰 on 16/8/7.
//  Copyright © 2016年 杰. All rights reserved.
//

#import "DrugView.h"

#import "DYWebViewController.h"
#import "ICSDrawerController.h"
@interface DrugView ()

@property (weak, nonatomic) IBOutlet UIButton *ImageBtn1;
@property (weak, nonatomic) IBOutlet UIButton *imageBtn2;
@property (weak, nonatomic) IBOutlet UIButton *imageBtn3;

@property (nonatomic, strong) NSArray *urlString;


@end

@implementation DrugView

- (IBAction)didClickBtn2:(id)sender {
    
    
    int randomNumber = arc4random_uniform(20);
    
    NSString *urlString = self.urlString[randomNumber];
    
    DYWebViewController *web = [[DYWebViewController alloc] initWithUrlString:urlString];
    
    ICSDrawerController *icsDrawController = (ICSDrawerController *)[self getCurrentRootViewController];
    
    UITabBarController *tab =(UITabBarController*)icsDrawController.centerViewController;
    UINavigationController *nav = tab.selectedViewController;
    [nav popViewControllerAnimated:NO];
    
    [nav pushViewController:web animated:NO];
    
}

/**
 *  获取当前View的控制器
 *
 *  @return <#return value description#>
 */
-(UIViewController *)getCurrentRootViewController {
    
    
    UIViewController *result;
    // Try to find the root view controller programmically
    // Find the top window (that is not an alert view or other window)
    UIWindow *topWindow = [[UIApplication sharedApplication] keyWindow];
    
    if (topWindow.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(topWindow in windows)
        {
            if (topWindow.windowLevel == UIWindowLevelNormal)
                break;
        }
    }
    UIView *rootView = [[topWindow subviews] objectAtIndex:0];
    id nextResponder = [rootView nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else if ([topWindow respondsToSelector:@selector(rootViewController)] && topWindow.rootViewController != nil)
        result = topWindow.rootViewController;
    else
        NSAssert(NO, @"ShareKit: Could not find a root view controller.  You can assign one manually by calling [[SHK currentHelper] setRootViewController:YOURROOTVIEWCONTROLLER].");
    return result;
    
    
}



- (NSArray *)urlString{
    
    if (!_urlString) {
        
        _urlString = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"GirlList" ofType:@"plist"]];
    }
    
    return _urlString;
}

@end
