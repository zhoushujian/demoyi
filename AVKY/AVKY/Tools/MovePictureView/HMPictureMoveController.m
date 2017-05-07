//
//  ViewController.m
//  MoveButton
//
//  Created by fuzheng on 16-5-26.
//  Copyright © 2016年 付正. All rights reserved.
//

#import "HMPictureMoveController.h"
#import "CustomGrid.h"
#import "MoreViewController.h"
#import "PTSingletonManager.h"
#import "HMImagePickerController.h"

#define identifi @"添加病历图片"

#define pictureKEY @"images"

#define selectedKEY @"selectedAssets"

#define ridListArrayKEY @"gridListArray"
#define showGridArrayKEY @"showGridArray"
#define showGridImageArrayKEY @"showGridImageArray"
#define showGridImageArrayKEY @"showGridImageArray"
#define showGridIDArrayKEY @"showGridIDArray"

//self.gridListArray = [[NSMutableArray alloc] initWithCapacity:12];
//
//self.showGridArray = [[NSMutableArray alloc] initWithCapacity:12];
//self.showGridImageArray = [[NSMutableArray alloc] initWithCapacity:12];
//self.showGridIDArray = [[NSMutableArray alloc] initWithCapacity:12];

//self.moreGridIdArray = [[NSMutableArray alloc] initWithCapacity:12];
//self.moreGridTitleArray = [[NSMutableArray alloc]initWithCapacity:12];
//self.moreGridImageArray = [[NSMutableArray alloc]initWithCapacity:12];


@interface HMPictureMoveController ()<CustomGridDelegate,UIScrollViewDelegate,HMImagePickerControllerDelegate>
{
    BOOL isSelected;
    BOOL contain;
    //是否可跳转应用对应的详细页面
    BOOL isSkip;
    UIScrollView * myScrollView;
    
    //选中格子的起始位置
    CGPoint startPoint;
    //选中格子的起始坐标位置
    CGPoint originPoint;
    
    UIImage *normalImage;
    UIImage *highlightedImage;
    UIImage *deleteIconImage;
}
/**
 *  加号图片
 */
@property (nonatomic, strong) UIImage *addImage;

/// 选中照片数组
@property (nonatomic) NSMutableArray *images;
/// 选中资源素材数组，用于定位已经选择的照片
@property (nonatomic) NSMutableArray *selectedAssets;

@property (nonatomic, strong) HMImagePickerController *pickerImageController ;

///**
// *  缓存要显示的图片
// */
//@property (nonatomic, strong) NSMutableArray *tempImageArray;

/**
 *  图片在数组的索引
 */
@property (nonatomic, assign) NSUInteger imageIndex;

/**
 *  是否删除
 */
@property (nonatomic, assign)BOOL isDelected ;

@end

@implementation HMPictureMoveController

- (instancetype)init
{
    if (self = [super init]) {
        
        self.gridListArray = [[NSMutableArray alloc] initWithCapacity:12];
        
        self.showGridArray = [[NSMutableArray alloc] initWithCapacity:12];
        self.showGridImageArray = [[NSMutableArray alloc] initWithCapacity:12];
        self.showGridIDArray = [[NSMutableArray alloc] initWithCapacity:12];

    }
    return self;
}

#pragma mark - 计算返回高度

- (void)calculateHeightAndCallBack {
    CGFloat height;
    if (self.images.count < 9) {
        height = (self.images.count / PerRowGridCount + 1) * (GridHeight + PaddingY) + PaddingY;
    }
    else {
        height = (self.images.count / PerRowGridCount) * (GridHeight + PaddingY) + PaddingY;
    }
    //完成回调
    if (self.completeBlock) {
        self.completeBlock(height);
    }
}


#pragma mark - 响应事件

//- (void)didClickPicture:(UIButton *)button{
//    
//    HMImagePickerController *picker = [[HMImagePickerController alloc] initWithSelectedAssets:self.selectedAssets];
//    
////    self.pickerImageController = picker ;
//    
//    // 设置图像选择代理
//    picker.pickerDelegate = self;
//    // 设置目标图片尺寸
//    picker.targetSize = CGSizeMake(600, 600);
//    // 设置最大选择照片数量
//    picker.maxPickerCount = 9;
//    
//    [ self presentViewController:picker animated:YES completion:nil];
//}

- (void)imagePickerController:(HMImagePickerController *)picker didFinishSelectedImages:(NSMutableArray<UIImage *> *)images selectedAssets:(NSMutableArray<PHAsset *> *)selectedAssets{
    
    self.images = images;
    //计算高度并回调
    [self calculateHeightAndCallBack];
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
    
    
    // Home按钮数组 体验账号
    [PTSingletonManager shareInstance].showGridArray = [[NSMutableArray alloc]initWithCapacity:12];
    [PTSingletonManager shareInstance].showImageGridArray = [[NSMutableArray alloc]initWithCapacity:12];
    
    NSMutableArray *mtu = [NSMutableArray array];

    [self.tempImageArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (idx == self.tempImageArray.count -1) {
            [mtu addObject:identifi];
        }else{
            
            [mtu addObject:@""];
        }
    }];

    [PTSingletonManager shareInstance].showGridArray = [NSMutableArray arrayWithArray:mtu];
    
    [PTSingletonManager shareInstance].showImageGridArray =
    [NSMutableArray arrayWithArray:self.tempImageArray];

    [PTSingletonManager shareInstance].showGridIDArray =
    [NSMutableArray arrayWithObjects:
     @"1000",@"1001", @"1002",
     @"1003",@"1004",@"1005" ,@"1006",
     @"1007",@"1008", @"1009",
     @"1010",@"1011",@"1012" ,
     @"1013" , @"1014",@"1015",@"0", nil];

    
    isSelected = NO;
    
    NSMutableArray *titleArr = [PTSingletonManager shareInstance].showGridArray;
    NSMutableArray *imageArr = [PTSingletonManager shareInstance].showImageGridArray;
    NSMutableArray *idArr = [PTSingletonManager shareInstance].showGridIDArray;
    _showGridArray = [[NSMutableArray alloc]initWithArray:titleArr];
    _showGridImageArray = [[NSMutableArray alloc]initWithArray:self.tempImageArray];
    _showGridIDArray = [[NSMutableArray alloc]initWithArray:idArr];
    
    [myScrollView removeFromSuperview];
    [self creatMyScrollView];
    
    if (self.callBackImageArray) {
        
        self.callBackImageArray(self.tempImageArray);
    }
    
    if (self.images !=nil && self.selectedAssets!= nil) {
        _pictureDict = @{pictureKEY:self.images,selectedKEY:self.selectedAssets};
    }
    
    
    
    
    if (self.callBackPictureDict) {
        
        self.callBackPictureDict(self.pictureDict);
    }
    
    if (self.callBackGirdDict) {
        
        self.callBackGirdDict(self.girdDict);
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIBarButtonItem *rightItem =[[ UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(didClickPicture:)];
    
    self.navigationItem.rightBarButtonItem = rightItem;
    self.navigationItem.title = @"移动格子";
    self.view.backgroundColor = [UIColor lightGrayColor];

    // Home按钮数组 体验账号
    [PTSingletonManager shareInstance].showGridArray = [[NSMutableArray alloc]initWithCapacity:12];
    [PTSingletonManager shareInstance].showImageGridArray = [[NSMutableArray alloc]initWithCapacity:12];
    
    NSMutableArray *mtu = [NSMutableArray array];
    
    [self.tempImageArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (idx == self.tempImageArray.count -1) {
          
              [mtu addObject:identifi];
        }else{
            
            [mtu addObject:@""];
        }

    }];
    
    
    [PTSingletonManager shareInstance].showGridArray = [NSMutableArray arrayWithArray:mtu];
    
    [PTSingletonManager shareInstance].showImageGridArray =
    [NSMutableArray arrayWithArray:self.tempImageArray];
    
    [PTSingletonManager shareInstance].showGridIDArray =
    [NSMutableArray arrayWithObjects:@"0", nil];
    
    
    isSelected = NO;
    
    NSMutableArray *titleArr = [PTSingletonManager shareInstance].showGridArray;
    NSMutableArray *imageArr = [PTSingletonManager shareInstance].showImageGridArray;
    NSMutableArray *idArr = [PTSingletonManager shareInstance].showGridIDArray;
    _showGridArray = [[NSMutableArray alloc]initWithArray:titleArr];
    _showGridImageArray = [[NSMutableArray alloc]initWithArray:self.images];
    _showGridIDArray = [[NSMutableArray alloc]initWithArray:idArr];
    
    [myScrollView removeFromSuperview];
    [self creatMyScrollView];
}


- (void)creatMyScrollView
{
#pragma mark - 可拖动的按钮
    normalImage = [UIImage imageNamed:@"app_item_bg"];
    highlightedImage = [UIImage imageNamed:@"app_item_bg"];
    deleteIconImage = [UIImage imageNamed:@"app_item_plus"];
    
    myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64)];
    myScrollView.contentInset = UIEdgeInsetsMake(0, 0, ScreenHeight*2, 0);
    myScrollView.backgroundColor = [UIColor clearColor];
    myScrollView.delegate = self;
    [self.view addSubview:myScrollView];
    
    _gridListView = [[UIView alloc] init];
    [_gridListView setFrame:CGRectMake(0, 0, ScreenWidth, GridHeight * PerColumGridCount)];
    [_gridListView setBackgroundColor:[UIColor whiteColor]];
    
    [myScrollView addSubview:_gridListView];
    
    [self.gridListArray removeAllObjects];
    for (NSInteger index = 0; index < [_showGridArray count]; index++)
    {
        NSString *gridTitle = _showGridArray[index];
        UIImage *gridImage = _showGridImageArray[index];
        NSInteger gridID = [self.showGridIDArray[index] integerValue];
        BOOL isAddDelete = YES;
        if ([gridTitle isEqualToString:identifi]) {
            isAddDelete = NO;
//            isSkip = NO;
        }
        CustomGrid *gridItem = [[CustomGrid alloc] initWithFrame:CGRectZero title:gridTitle normalImage:normalImage highlightedImage:highlightedImage gridId:gridID atIndex:index isAddDelete:isAddDelete deleteIcon:deleteIconImage  withIconImage:gridImage];
        gridItem.delegate = self;
        gridItem.gridTitle = gridTitle;
        gridItem.gridImageString = gridImage;
        gridItem.gridId = gridID;
        
        [self.gridListView addSubview:gridItem];
        [self.gridListArray addObject:gridItem];
        
    }
    
    //for test print out
    for (NSInteger i = 0; i < _gridListArray.count; i++) {
        CustomGrid *gridItem = _gridListArray[i];
        gridItem.gridCenterPoint = gridItem.center;
    }
    
    NSInteger gridHeight;
    gridHeight = 123 * self.showGridArray.count/3;
    
    myScrollView.contentInset = UIEdgeInsetsMake(0, 0, gridHeight, 0);
}

#pragma mark - 可拖动按钮
#pragma mark - 点击格子
- (void)gridItemDidClicked:(CustomGrid *)gridItem
{
    NSLog(@"您点击的格子Tag是：%ld", (long)gridItem.gridId);
    isSkip = YES;
//    
//    /**
//     *  加号按钮
//     */
//    if ((long)gridItem.gridId == 0) {
//        
//        HMImagePickerController *picker = [[HMImagePickerController alloc] initWithSelectedAssets:self.selectedAssets];
//        
//        self.pickerImageController = picker ;
//        
//        // 设置图像选择代理
//        picker.pickerDelegate = self;
//        // 设置目标图片尺寸
//        picker.targetSize = CGSizeMake(600, 600);
//        // 设置最大选择照片数量
//        picker.maxPickerCount = 9;
//        
//        [self presentViewController:picker animated:YES completion:nil];
//    }
    
    //查看是否有选中的格子，并且比较点击的格子是否就是选中的格子
    for (NSInteger i = 0; i < [_gridListArray count]; i++) {
        CustomGrid *item = _gridListArray[i];
        if (item.isChecked && item.gridId != gridItem.gridId) {
            item.isChecked = NO;
            item.isMove = NO;
            isSelected = NO;
            isSkip = NO;
            
            //隐藏删除图标
            UIButton *removeBtn = (UIButton *)[self.gridListView viewWithTag:item.gridId];
            removeBtn.hidden = YES;
            [item setBackgroundImage:normalImage forState:UIControlStateNormal];
            
            if (gridItem.gridId == 0) {
                isSkip = YES;
            }
            break;
        }
    }
    
    if (isSkip) {
        
        [self itemAction:gridItem.gridTitle];
    }
}

#pragma mark - 删除格子
- (void)gridItemDidDeleteClicked:(UIButton *)deleteButton
{
    NSLog(@"您删除的格子是GridId：%ld", (long)deleteButton.tag);
    
//    图片回传有bug 未解决
    [self.images enumerateObjectsUsingBlock:^(id  _Nonnull image1, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [deleteButton.superview.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull image2, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if (image1 == image2) {
                
                [self.images removeObject:image1];

                self.imageIndex = idx;

            }
        }];
        
    }];
    
    [self.images removeObjectAtIndex:self.imageIndex];
    
    [self.selectedAssets removeObjectAtIndex:self.imageIndex];
    
    [self.tempImageArray removeObjectAtIndex:self.imageIndex];

    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self imagePickerController:self.pickerImageController didFinishSelectedImages:self.images selectedAssets:self.selectedAssets];
    });


    NSLog(@"=======================imageIndex = %zd",self.imageIndex);
    
    //计算高度并回调
    [self calculateHeightAndCallBack];
    
    for (NSInteger i = 0; i < _gridListArray.count; i++) {
        CustomGrid *removeGrid = _gridListArray[i];
        if (removeGrid.gridId == deleteButton.tag) {
            [removeGrid removeFromSuperview];
            NSInteger count = _gridListArray.count - 1;
            for (NSInteger index = removeGrid.gridIndex; index < count; index++) {
                CustomGrid *preGrid = _gridListArray[index];
                CustomGrid *nextGrid = _gridListArray[index+1];
                [UIView animateWithDuration:0.5 animations:^{
                    nextGrid.center = preGrid.gridCenterPoint;
                }];
                nextGrid.gridIndex = index;
            }
            //排列格子顺序和更新格子坐标信息
            [self sortGridList];
            
            [_gridListArray removeObjectAtIndex:removeGrid.gridIndex];
            
            NSString *gridTitle = removeGrid.gridTitle;
            UIImage *gridImage = removeGrid.gridImageString;
            NSString *gridID = [NSString stringWithFormat:@"%ld", (long)removeGrid.gridId];
            //删除的应用添加到更多应用数组
            [_moreGridTitleArray addObject:gridTitle];
            [_moreGridImageArray addObject:gridImage];
            [_moreGridIdArray addObject:gridID];
            
            [_showGridArray removeObject:gridTitle];
            [_showGridImageArray removeObject:gridImage];
            [_showGridIDArray removeObject:gridID];
        }
    }
    // 保存更新后数组
    [self saveArray];
}

#pragma mark - 长按格子
- (void)pressGestureStateBegan:(UILongPressGestureRecognizer *)longPressGesture withGridItem:(CustomGrid *) grid
{
    NSLog(@"长按.........");
    NSLog(@"isSelected: %d", isSelected);
    
    //判断格子是否已经被选中并且是否可移动状态,如果选中就加一个放大的特效
    if (isSelected && grid.isChecked) {
        grid.transform = CGAffineTransformMakeScale(1.1, 1.1);
    }
    
    //没有一个格子选中的时候
    if (!isSelected) {
        
        NSLog(@"没有一个格子选中............");
        grid.isChecked = YES;
        grid.isMove = YES;
        isSelected = YES;
        
        //选中格子的时候显示删除图标
        UIButton *removeBtn = (UIButton *)[longPressGesture.view viewWithTag:grid.gridId];
        removeBtn.hidden = NO;
        
        //获取移动格子的起始位置
        startPoint = [longPressGesture locationInView:longPressGesture.view];
        //获取移动格子的起始位置中心点
        originPoint = grid.center;
        
        //给选中的格子添加放大的特效
        [UIView animateWithDuration:0.5 animations:^{
            grid.transform = CGAffineTransformMakeScale(1.1, 1.1);
            grid.alpha = 1;
            [grid setBackgroundImage:highlightedImage forState:UIControlStateNormal];
        }];
    }
}

#pragma mark --- 拖动位置
- (void)pressGestureStateChangedWithPoint:(CGPoint) gridPoint gridItem:(CustomGrid *) gridItem
{
    if (isSelected && gridItem.isChecked) {
        //        NSLog(@"UIGestureRecognizerStateChanged.........");
        
        [_gridListView bringSubviewToFront:gridItem];
        //应用移动后的X坐标
        CGFloat deltaX = gridPoint.x - startPoint.x;
        //应用移动后的Y坐标
        CGFloat deltaY = gridPoint.y - startPoint.y;
        //拖动的应用跟随手势移动
        gridItem.center = CGPointMake(gridItem.center.x + deltaX, gridItem.center.y + deltaY);
        
        //移动的格子索引下标
        NSInteger fromIndex = gridItem.gridIndex;
        //移动到目标格子的索引下标
        NSInteger toIndex = [CustomGrid indexOfPoint:gridItem.center withButton:gridItem gridArray:_gridListArray];
        
        NSInteger borderIndex = [_showGridIDArray indexOfObject:@"0"];
        NSLog(@"borderIndex: %ld", (long)borderIndex);
        
        if (toIndex < 0 || toIndex >= borderIndex) {
            contain = NO;
        }else{
            //获取移动到目标格子
            CustomGrid *targetGrid = _gridListArray[toIndex];
            gridItem.center = targetGrid.gridCenterPoint;
            originPoint = targetGrid.gridCenterPoint;
            gridItem.gridIndex = toIndex;
            
            //判断格子的移动方向，是从后往前还是从前往后拖动
            if ((fromIndex - toIndex) > 0) {
                //                NSLog(@"从后往前拖动格子.......");
                //从移动格子的位置开始，始终获取最后一个格子的索引位置
                NSInteger lastGridIndex = fromIndex;
                for (NSInteger i = toIndex; i < fromIndex; i++) {
                    CustomGrid *lastGrid = _gridListArray[lastGridIndex];
                    CustomGrid *preGrid = _gridListArray[lastGridIndex-1];
                    [UIView animateWithDuration:0.5 animations:^{
                        preGrid.center = lastGrid.gridCenterPoint;
                    }];
                    //实时更新格子的索引下标
                    preGrid.gridIndex = lastGridIndex;
                    lastGridIndex--;
                }
                //排列格子顺序和更新格子坐标信息
                [self sortGridList];
                
            }else if((fromIndex - toIndex) < 0){
                //从前往后拖动格子
                //                NSLog(@"从前往后拖动格子.......");
                //从移动格子到目标格子之间的所有格子向前移动一格
                for (NSInteger i = fromIndex; i < toIndex; i++) {
                    CustomGrid *topOneGrid = _gridListArray[i];
                    CustomGrid *nextGrid = _gridListArray[i+1];
                    //实时更新格子的索引下标
                    nextGrid.gridIndex = i;
                    [UIView animateWithDuration:0.5 animations:^{
                        nextGrid.center = topOneGrid.gridCenterPoint;
                    }];
                }
                //排列格子顺序和更新格子坐标信息
                [self sortGridList];
            }
        }
    }
}

#pragma mark - 拖动格子结束
- (void)pressGestureStateEnded:(CustomGrid *) gridItem
{
    //    NSLog(@"拖动格子结束.........");
    if (isSelected && gridItem.isChecked) {
        //撤销格子的放大特效
        [UIView animateWithDuration:0.5 animations:^{
            gridItem.transform = CGAffineTransformIdentity;
            gridItem.alpha = 1.0;
            isSelected = NO;
            if (!contain) {
                gridItem.center = originPoint;
            }
        }];
        
        //排列格子顺序和更新格子坐标信息
        [self sortGridList];
    }
}

- (void)sortGridList
{
    //重新排列数组中存放的格子顺序
    [_gridListArray sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        CustomGrid *tempGrid1 = (CustomGrid *)obj1;
        CustomGrid *tempGrid2 = (CustomGrid *)obj2;
        return tempGrid1.gridIndex > tempGrid2.gridIndex;
    }];
    
    //更新所有格子的中心点坐标信息
    for (NSInteger i = 0; i < _gridListArray.count; i++) {
        CustomGrid *gridItem = _gridListArray[i];
        gridItem.gridCenterPoint = gridItem.center;
    }
    
    // 保存更新后数组
    [self saveArray];
}

#pragma mark - 保存更新后数组
-(void)saveArray
{
    // 保存更新后数组
    NSMutableArray * array1 = [[NSMutableArray alloc]init];
    NSMutableArray * array2 = [[NSMutableArray alloc]init];
    NSMutableArray * array3 = [[NSMutableArray alloc]init];
    for (int i = 0; i < _gridListArray.count; i++) {
        CustomGrid * grid = _gridListArray[i];
        [array1 addObject:grid.gridTitle];
        [array2 addObject:grid.gridImageString];
        [array3 addObject:[NSString stringWithFormat:@"%ld",(long)grid.gridId]];
    }
    NSArray * titleArray = [array1 copy];
    NSArray * imageArray = [array2 copy];
    NSArray * idArray = [array3 copy];
    
    [PTSingletonManager shareInstance].showGridArray = [[NSMutableArray alloc]initWithArray:titleArray];
    [PTSingletonManager shareInstance].showImageGridArray = [[NSMutableArray alloc]initWithArray:imageArray];
    [PTSingletonManager shareInstance].showGridIDArray = [[NSMutableArray alloc]initWithArray:idArray];


    //更多页面中的版块存储
    // 保存更新后数组
    NSMutableArray * moreTitleArray = [PTSingletonManager shareInstance].moreshowGridArray;
    NSMutableArray * moreImageArray = [PTSingletonManager shareInstance].moreshowImageGridArray;
    NSMutableArray * moreIdArray = [PTSingletonManager shareInstance].moreshowGridIDArray;
    for (int i = 0; i < self.moreGridTitleArray.count; i++) {
        [moreTitleArray addObject:self.moreGridTitleArray[i]];
        [moreImageArray addObject:self.moreGridImageArray[i]];
        [moreIdArray addObject:self.moreGridIdArray[i]];
    }
    [self.moreGridTitleArray removeAllObjects];
    [self.moreGridImageArray removeAllObjects];
    [self.moreGridIdArray removeAllObjects];
    
    [PTSingletonManager shareInstance].moreshowGridArray = [[NSMutableArray alloc]initWithArray:moreTitleArray];
    [PTSingletonManager shareInstance].moreshowImageGridArray = [[NSMutableArray alloc]initWithArray:moreImageArray];
    [PTSingletonManager shareInstance].moreshowGridIDArray = [[NSMutableArray alloc]initWithArray:moreIdArray];

    
    NSLog(@"更新后titleArray = %@",titleArray);
    NSLog(@"更新后imageArray = %@",imageArray);
    
    NSInteger gridHeight;
    if (self.showGridArray.count % 3 == 0) {
        gridHeight = 123 * self.showGridArray.count/3;
    }
    else{
        gridHeight = 123 * (self.showGridArray.count/3+1);
    }
    myScrollView.contentInset = UIEdgeInsetsMake(0, 0, gridHeight + 150, 0);
}

#pragma mark 点击 按钮
- (void)itemAction:(NSString *)title
{
    if ([title isEqualToString:identifi])
    {

        HMImagePickerController *picker = [[HMImagePickerController alloc] initWithSelectedAssets:self.selectedAssets];
        
        self.pickerImageController = picker ;
        
        // 设置图像选择代理
        picker.pickerDelegate = self;
        // 设置目标图片尺寸
        picker.targetSize = CGSizeMake(600, 600);
        // 设置最大选择照片数量
        picker.maxPickerCount = 9;
        
        [self presentViewController:picker animated:YES completion:nil];

    }
    else {
        
        NSLog(@"你点击了 = %@",title);

    }
}

- (NSMutableArray *)images{
    
    if (_images == nil) {
        _images = [NSMutableArray arrayWithArray:@[self.addImage]];
    }
    return _images;
}

- (UIImage *)addImage{
    
    if (_addImage ==nil) {
        
        _addImage = [UIImage imageNamed:@"AddPic"];
    }
    return _addImage;
}


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



- (void)setPictureDict:(NSDictionary *)pictureDict{
    _pictureDict = pictureDict;
    self.images = pictureDict[pictureKEY];
    
    self.selectedAssets = pictureDict[selectedKEY];
    
    [self imagePickerController:self.pickerImageController didFinishSelectedImages: self.images selectedAssets:self.selectedAssets];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
