//
//  GYHInformationView.m
//  AVKY
//
//  Created by Marcello on 16/8/4.
//  Copyright © 2016年 杰. All rights reserved.
//

#import "GYHInformationView.h"
#import <Masonry.h>

@interface GYHInformationView ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
/*
*  头像
*/
@property (nonatomic, strong) UIImageView *AvatarView;

/**
 *  名称
 */
@property (nonatomic, strong) UIButton *nameLable;

/**
 *  基本信息
 */
@property (nonatomic, strong) UIButton *informationLable;

/**
 *  身份证Lable
 */
@property (nonatomic, strong) UIButton *identifiLable;

@end

@implementation GYHInformationView

- (instancetype)init{
    
    if (self = [super init]) {
        
        [self setUpUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
         [self setUpUI];
        
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    if (self = [super initWithCoder:aDecoder]) {
         [self setUpUI];
    }
    return self;
}
/**
 *  初始化UI
 */

- (void)setUpUI{
    
    [self addSubview:self.AvatarView];
    
    [self addSubview:self.nameLable];
    
    [self addSubview:self.informationLable];
    
    [self addSubview:self.identifiLable];
    
    //设置UI
    
    [self.nameLable setTitle:@"  独孤求败" forState:UIControlStateNormal];;
    
    [self.informationLable setTitle:@"  你的个人资料信息" forState:UIControlStateNormal];;

    [ self.identifiLable setTitle:@"身份证号码" forState:UIControlStateNormal];;
    

    _identifiLable.titleLabel.font = [UIFont systemFontOfSize:14];
     _informationLable.titleLabel.font = [UIFont systemFontOfSize:14];
     _nameLable.titleLabel.font = [UIFont systemFontOfSize:14];
    //布局子控件
    
   UIImage *image = [[UserAccount sharedUserAccount] getDocumentImage];
    
    if (image == nil) {
        self.AvatarView.image = [UIImage imageNamed:@"head.jpeg"];
    }else{
        self.AvatarView.image = image;
    }
    
    
    
    self.AvatarView.layer.cornerRadius = 50;
    
    self.AvatarView.layer.masksToBounds = YES;
    
    //布局子UI
    
    [self.AvatarView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(25);
        
        make.top.equalTo(self).offset(25);
        
        make.size.mas_equalTo(CGSizeMake(100, 100));
        
    }];
    
    [self.nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.AvatarView.mas_right).offset(20);
        make.top.mas_equalTo(self.AvatarView.mas_top);
        
    }];
    
    [self.informationLable mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.AvatarView.mas_right).offset(20);
        
        make.bottom.mas_equalTo(self.AvatarView.mas_bottom);
        
    }];
    
    [self.identifiLable mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.AvatarView.mas_right).offset(20);
        
        make.centerY.mas_equalTo (self.AvatarView.mas_centerY);
    }];
    
    
    [self changeuserNamed];
    
    [self changAvatarView];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changAvatarView) name:userIconNotification object:nil];
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeuserNamed) name:userNameNotification object:nil];
    
    
}
#pragma mark - x响应事件

/**
 *  改变头像
 */
- (void)changAvatarView{
    
    UIImage *image = [[UserAccount sharedUserAccount] getDocumentImage];
    
    if (image == nil) {
        
        self.AvatarView.image = [UIImage imageNamed:@"head.jpeg"];
    }else{
        
        self.AvatarView.image =image;
    }

}

/**
 *  g改变用户名
 */
- (void)changeuserNamed{
    
    NSString *string = [AVUserDefaultsTool objetForKey:userName_Key];
    
    if (string == nil) {
        
        string = @"意外";
    }else{
        
        [self.nameLable setTitle:string forState:UIControlStateNormal];
    }

}

/**
 *  添加图片
 */
- (void) addPicEvent
{
    //先设定sourceType为相机，然后判断相机是否可用（ipod）没相机，不可用将sourceType设定为相片库
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = sourceType;
    [[self getCurrentRootViewController] presentViewController:picker animated:YES completion:nil];
}
- (void)saveImage:(UIImage *)image {
    NSLog(@"保存");
}

#pragma mark Camera View Delegate Methods
- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    NSLog(@"======%@",info[UIImagePickerControllerEditedImage]);
    
    self.AvatarView.image = info[UIImagePickerControllerEditedImage];
    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
   // [picker dismissModalViewControllerAnimated:YES];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 懒加载

- (UIImageView *)AvatarView{
    
    if (!_AvatarView) {
        _AvatarView = [[UIImageView alloc] init];
        _AvatarView.userInteractionEnabled = YES;
        
//        UITapGestureRecognizer *tap  = [[UITapGestureRecognizer alloc] init];
//        
//        [tap addTarget:self action:@selector(addPicEvent)];
        
        //[_AvatarView addGestureRecognizer:tap];
        
    }
    return _AvatarView;
}

- (UIButton *)nameLable{
    
    if (!_nameLable) {
        
        _nameLable = [[UIButton alloc] init];
        [_nameLable setImage:[UIImage imageNamed:@"0"] forState:UIControlStateNormal];
        [_nameLable setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _nameLable;
}


- (UIButton *)informationLable{
    
    if (!_informationLable) {
        _informationLable = [[UIButton alloc] init];
         [_informationLable setImage:[UIImage imageNamed:@"login_phone"] forState:UIControlStateNormal];
        [_informationLable setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

    }
    return _informationLable;
}


- (UIButton *)identifiLable{
    
    if (!_identifiLable) {
        
        _identifiLable = [[UIButton alloc] init];
        
        [_identifiLable setImage:[UIImage imageNamed:@"id"] forState:UIControlStateNormal];
        [_identifiLable setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
    }
    
    return _identifiLable;
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




@end
