//
//  GYHRecordPictureView.m
//  AVKY
//
//  Created by Marcello on 16/8/5.
//  Copyright © 2016年 杰. All rights reserved.
//

#import "GYHRecordPictureView.h"
#import "HMImagePickerController.h"


#define pictureKEY @"images"

#define selectedKEY @"selectedAssets"

@interface GYHRecordPictureView ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,HMImagePickerControllerDelegate>


/// 选中照片数组
@property (nonatomic) NSMutableArray *images;
/// 选中资源素材数组，用于定位已经选择的照片
@property (nonatomic) NSMutableArray *selectedAssets;

/**
 *  根据identityfi 获取NSSaet
 */
@property (nonatomic, copy) NSString *localIdentifier;

/**
 *  存储标识数组
 */
@property (nonatomic, strong) NSMutableArray *localIdentifiArray;

/**
 *  描述Lable
 */
@property (nonatomic, strong) UILabel *descLable;

/**
 *  增加按钮
 */
@property (nonatomic, strong) UIButton *addButton;

/**
 *  增加按钮
 */
@property (nonatomic, strong) UIButton *addButton1;

/**
 *  增加按钮
 */
@property (nonatomic, strong) UIButton *addButton2;



@property (nonatomic, strong) NSArray *addImageViewArr;
/**
 *  底部黑线
 */
@property (nonatomic, strong) UIView *lineView;

/**
 *  缓存要显示的图片
 */
//@property (nonatomic, strong) NSMutableArray *tempImageArray;

/**
 *  默认加号图片
 */
@property (nonatomic, strong) UIImage *addImage;

/**
 *  图片View
 */
@property (nonatomic, strong) UIImageView *imageView1;

/**
 *  图片View
 */
@property (nonatomic, strong) UIImageView *imageView2;
/**
 *  图片View
 */
@property (nonatomic, strong) UIImageView *imageView3;

/**
 *  删除button
 */
@property (nonatomic, strong) UIButton *deleteButton;

@property (nonatomic, strong) HMImagePickerController *pickerImageController;



@end

@implementation GYHRecordPictureView

- (instancetype)init{
    
    if (self = [super init]) {
        [self setUPUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        [self setUPUI];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    if (self = [super initWithCoder:aDecoder]) {
        [self setUPUI];
    }
    
    return self;
}

/**
 *  初始化UI
 */
- (void)setUPUI{
    
    [self addSubview:self.descLable];

    
    [self addSubview:self.imageView1];
    
    [self addSubview:self.imageView2];
    
    [self addSubview:self.imageView3];
    
    [self addSubview:self.lineView];
    
    CGFloat width = (screenW - 6 *10)/3;
    
    self.addImageViewArr = @[self.imageView1,self.imageView2,self.imageView3];
    
    [self.descLable mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.mas_left).offset(10);
        make.top.mas_equalTo(self.mas_top).offset(10);
        
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.mas_equalTo(self.mas_bottom);
        make.left.mas_equalTo(self.mas_left).offset(10);
        make.size.mas_equalTo(CGSizeMake(screenW, 1));
    }];
    
    [self.imageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
                make.top.mas_equalTo(self.descLable.mas_bottom).offset(10);
                make.left.mas_equalTo(self.mas_left).offset(10);
                //make.width.mas_equalTo(width);
                //make.height.mas_equalTo(self.lineView.mas_top).offset(-5);
        
                make.size.mas_equalTo(CGSizeMake(width, width));
        
    }];
//    
    [self.imageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
            make.top.mas_equalTo(self.descLable.mas_bottom).offset(10);
                make.left.mas_equalTo(self.imageView1.mas_right).offset(10);
               // make.width.mas_equalTo(width);
                 //make.height.mas_equalTo(self.lineView.mas_top).offset(-5);
                make.size.mas_equalTo(CGSizeMake(width, width));

        
    }];

    [self.imageView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        
                make.top.mas_equalTo(self.descLable.mas_bottom).offset(10);
                make.left.mas_equalTo(self.imageView2.mas_right).offset(10);
                //make.width.mas_equalTo(width);
                //make.height.mas_equalTo(self.lineView.mas_top).offset(-5);
                make.size.mas_equalTo(CGSizeMake(width, width));
        
        //        make.size.height.mas_equalTo(self.lineView.mas_top).offset(-5);
        //        make.size.width.mas_equalTo(width);
        
    }];
    
    
    
}


#pragma mark - 懒加载

/**
 *  描述Lable
 *
 *  @return <#return value description#>
 */
- (UILabel *)descLable{
    
    if (!_descLable) {
        
        _descLable = [[UILabel alloc] init];
        _descLable.text = @"病历图片:";
    }
    
    return _descLable;
}


/*88888888888888888888*****************/

- (UIImageView *)imageView1{
    
    if (!_imageView1) {
        CGFloat width = (screenW - 6 *10)/3;
//        UILongPressGestureRecognizer *longGesture = [[UILongPressGestureRecognizer alloc] init];
//        
//        [longGesture addTarget:self action:@selector(deleteRecordPicture:)];
        //点击手势
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addRecordPicture:)];
        _imageView1.tag = 0;
        _imageView1 = [[UIImageView alloc] init];
        _imageView1.userInteractionEnabled = YES;
        [_imageView1 addGestureRecognizer:tapGesture];
        // [_imageView1 addGestureRecognizer:longGesture];
        
        _imageView1.image = self.addImage;
        UIButton *button = [[UIButton alloc] init];
        [button setImage:[UIImage imageNamed:@"compose_photo_close"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(deleteRecordPicture:) forControlEvents:UIControlEventTouchUpInside];
        button.frame = CGRectMake(width - 35, 0, 35, 35);
        button.tag = 0;
        button.hidden = YES;
        [_imageView1 addSubview:button];
    }
    
    return _imageView1;
}

- (UIImageView *)imageView2{
    
    if (!_imageView2) {
        //点击手势
        CGFloat width = (screenW - 6 *10)/3;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addRecordPicture:)];
        _imageView2 = [[UIImageView alloc] init];
       _imageView2.tag = 1;
           [_imageView2 addGestureRecognizer:tapGesture];
        UIButton *button = [[UIButton alloc] init];
        [button setImage:[UIImage imageNamed:@"compose_photo_close"] forState:UIControlStateNormal];
                [button addTarget:self action:@selector(deleteRecordPicture:) forControlEvents:UIControlEventTouchUpInside];
        button.frame = CGRectMake(width - 35, 0, 35, 35);
        button.tag = 1;
        button.hidden = YES;
        [_imageView2 addSubview:button];
    }
    
    return _imageView2;
}

- (UIImageView *)imageView3{
    
    if (!_imageView3) {
        CGFloat width = (screenW - 6 *10)/3;

        //点击手势
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addRecordPicture:)];

        _imageView3 = [[UIImageView alloc] init];
        _imageView3.tag = 2;
            [_imageView3 addGestureRecognizer:tapGesture];

        UIButton *button = [[UIButton alloc] init];
        [button setImage:[UIImage imageNamed:@"compose_photo_close"] forState:UIControlStateNormal];
                [button addTarget:self action:@selector(deleteRecordPicture:) forControlEvents:UIControlEventTouchUpInside];
        button.frame = CGRectMake(width - 35, 0, 35, 35);
        button.tag = 2;
        button.hidden = YES;
        [_imageView3 addSubview:button];
    }
    
    return _imageView3;
}


/*88888888888888888888*****************/

/**
 *  要显示的图片的数组
 *
 *  @return <#return value description#>
 */
- (NSMutableArray *)tempImageArray{
    
    if (!_tempImageArray) {
        
        _tempImageArray = [NSMutableArray arrayWithObjects:self.addImage, nil];
    }
    return _tempImageArray;
}

/**
 *  默认加号 图片
 *
 *  @return <#return value description#>
 */
- (UIImage *)addImage{
    
    if (!_addImage) {
        _addImage = [UIImage imageNamed:@"AddPic"];
    }
    return _addImage;
}

/**
 *  删除按钮
 *
 *  @return <#return value description#>
 */
- (UIButton *)deleteButton{
    
    if (!_deleteButton ) {
        _deleteButton = [[UIButton alloc] init];
        [_deleteButton setImage:[UIImage imageNamed:@"compose_photo_close"] forState:UIControlStateNormal];
        _deleteButton.frame = CGRectMake(1, 0, 35, 35);
    }
    
    return _deleteButton;
}

/**
 *  底部分割线
 *
 *  @return <#return value description#>
 */
- (UIView *)lineView{
    
    if (!_lineView) {
        
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = [UIColor clearColor];
    }
    return _lineView;
}


#pragma mark - 响应方法

- (void)addRecordPicture:(UIImageView *)view{
    
    HMImagePickerController *picker = [[HMImagePickerController alloc] initWithSelectedAssets:self.selectedAssets];
    
    self.pickerImageController = picker ;
    
    // 设置图像选择代理
    picker.pickerDelegate = self;
    // 设置目标图片尺寸
    picker.targetSize = CGSizeMake(600, 600);
    // 设置最大选择照片数量
    picker.maxPickerCount = 3;
    
    [[self getCurrentRootViewController]  presentViewController:picker animated:YES completion:nil];

}

/**
 *  响应长按手势  删除手势
 *
 *  @param imageView <#imageView description#>
 */
- (void)deleteRecordPicture:(UIButton *)button{
    
    //NSLog(@"tag = %zd",button.tag);
    
    [self.images removeObjectAtIndex:button.tag];
    
    [self.selectedAssets removeObjectAtIndex:button.tag];
    
    [self.tempImageArray removeObjectAtIndex:button.tag];
    
    [self imagePickerController:self.pickerImageController didFinishSelectedImages: self.images selectedAssets:self.selectedAssets];

    
}




#pragma mark - HMImagePickerControllerDelegate
- (void)imagePickerController:(HMImagePickerController *)picker
      didFinishSelectedImages:(NSMutableArray<UIImage *> *)images
               selectedAssets:(NSMutableArray<PHAsset *> *)selectedAssets {
    
    // 记录图像，方便在 CollectionView 显示
    self.images = images;
    // 记录选中资源集合，方便再次选择照片定位
    self.selectedAssets = selectedAssets;

        //清除默认图片
        [self.tempImageArray removeAllObjects];
        
        [self.images enumerateObjectsUsingBlock:^(UIImage * obj, NSUInteger idx, BOOL * _Nonnull stop) {

            //添加选中的图片
            [self.tempImageArray addObject:obj];
            
        }];
    
    //添加默认图片,,将默认图片放在最后
      [self.tempImageArray addObject:self.addImage];
    
    //遍历按钮数组
    [self.addImageViewArr enumerateObjectsUsingBlock:^(UIImageView * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        //关闭所有图片的USerinterFace
        
        obj.userInteractionEnabled = NO;
        
        //隐藏所有的删除的黑按钮
        [obj.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull ob, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([ob isKindOfClass:[UIButton class]]) {
                ob.hidden = YES;
            }
        }];
        
        if (idx == self.tempImageArray.count) {
           UIImageView *iamgeView = self.addImageViewArr[idx];
            iamgeView.image = nil;
            return ;
        }

        //当只剩下默认的图片的时候 直接返回,不再添加图片
        if (idx ==2 && self.tempImageArray.count ==1) {
            
            UIImageView *iamgeView = self.addImageViewArr[idx];
            iamgeView.image = nil;
            
            return;
        }
        //赋值图片
        obj.image = self.tempImageArray[idx];
        
        obj.userInteractionEnabled = YES;
        //将所有的有新图片的删除按钮  显示出来
        if (idx < self.tempImageArray.count-1) {
            [obj.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull ob, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([ob isKindOfClass:[UIButton class]]) {
                    
                    ob.hidden = NO;;
                    
                }
            }];
        }

    }];

    if (self.callBackImageArray) {
        self.callBackImageArray(self.tempImageArray);
    }
    if (self.images !=nil && self.selectedAssets!= nil) {
        [self.selectedAssets enumerateObjectsUsingBlock:^(PHAsset * obj, NSUInteger idx, BOOL * _Nonnull stop) {
            //储存identifi
            [self.localIdentifiArray addObject:obj.localIdentifier];
            
        }];
        
        _pictureDict = @{pictureKEY:self.images,selectedKEY:self.localIdentifiArray};
    }
    if (self.callBackPictureDict) {
        self.callBackPictureDict(self.pictureDict);
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}


/**
 *  设置相册需要的参数
 *
 *  @param pictureDict <#pictureDict description#>
 */
- (void)setPictureDict:(NSDictionary *)pictureDict{
    _pictureDict = pictureDict;
    self.images = pictureDict[pictureKEY];
    
    self.localIdentifiArray = pictureDict[selectedKEY];
    
      PHFetchResult *allPhotos;
    
    allPhotos  = [PHAsset fetchAssetsWithLocalIdentifiers:self.localIdentifiArray options:nil];
    
    for (PHAsset *asset in allPhotos) {
        
        [self.selectedAssets addObject:asset];
    }

    [self imagePickerController:self.pickerImageController didFinishSelectedImages: self.images selectedAssets:self.selectedAssets];
    
}


- (NSMutableArray *)selectedAssets{
    
    if (_selectedAssets ==nil) {
        _selectedAssets = [NSMutableArray array];
    }
    return _selectedAssets;
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


- (NSMutableArray *)localIdentifiArray{
    
    if (_localIdentifiArray == nil) {
        _localIdentifiArray = [NSMutableArray array];
    }
    
    return _localIdentifiArray;
}



@end
