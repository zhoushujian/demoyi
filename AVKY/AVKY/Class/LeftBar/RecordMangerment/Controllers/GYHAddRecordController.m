//
//  GYHAddRecordController.m
//  AVKY
//
//  Created by Marcello on 16/8/5.
//  Copyright © 2016年 杰. All rights reserved.
//

#import "GYHAddRecordController.h"
#import "GYHillnessView.h"
#import "GYHTybeillnessController.h"
#import "GYHDetaillnessController.h"
#import "GYHDesrcibleView.h"
#import "GYHRecordPictureView.h"
#import "GYHDescListController.h"
#import "GYHRecordModel.h"
#import "HMPictureMoveController.h"

@interface GYHAddRecordController ()

/**
 *  疾病类型
 */
@property (nonatomic, strong) GYHillnessView *typeView;

/**
 *  疾病细分
 */
@property (nonatomic, strong) GYHillnessView *detailedView;


/**
 *  病历描述View
 */
@property (nonatomic, strong) GYHDesrcibleView *descView;

/**
 *  病历图片View
 */
@property (nonatomic, strong) GYHRecordPictureView *recordView;
/**
 *  记录是哪一种疾病
 */
@property (nonatomic, assign) NSInteger index;

/**
 *  滚动的View
 */
@property (nonatomic, strong) UIScrollView *myScrollowView;


/**
 *  相册选择控制器
 */
@property (nonatomic, strong) HMPictureMoveController *movePictureController;

@property (nonatomic, strong) GYHDetaillnessController  *detailInllnessController;

@end

@implementation GYHAddRecordController

@synthesize recordModel = _recordModel;


- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self setNavgationBar];
    [self.view addSubview:self.typeView];
    
    [self.view addSubview:self.detailedView];
    
    [self.view addSubview:self.descView];
    
    [self.view addSubview:self.recordView];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
}


/**
 *  设置navgationBar
 */
- (void)setNavgationBar{

    UIButton *button = [[UIButton alloc] init];
    button.frame = CGRectMake(0, 0, 50, 40);
    [button setImage:[UIImage imageNamed:@"home_nav_button_back"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(didBackButton:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    
    UIButton *rightButton = [[UIButton alloc] init];
    rightButton.frame = CGRectMake(0, 0, 50, 40);
    [rightButton setTitle:@"确定" forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(didClickSureButton:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *sureitem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    
    UIButton *deleteButton = [[UIButton alloc] init];
    deleteButton.frame = CGRectMake(0, 0, 50, 40);
    [deleteButton setTitle:@"删除" forState:UIControlStateNormal];
    [deleteButton addTarget:self action:@selector(didClickDeleteButton:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *deletedItem = [[UIBarButtonItem alloc] initWithCustomView:deleteButton];
    
    //判断是修改病历,还是添加病历
    if ([self.navigationItem.title isEqualToString:@"修改病历"]) {
        self.navigationItem.rightBarButtonItems = @[sureitem,deletedItem];
    }else{
        self.navigationItem.rightBarButtonItems = @[sureitem];
    }
}


#pragma mark - 懒加载

- (GYHillnessView *)typeView{
    
    if (!_typeView) {
        
        //点击手势
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickTybeView:)];
        
        _typeView = [[GYHillnessView alloc] init];
        _typeView.frame = CGRectMake(0, 64, screenW, 40);
        _typeView.typeString = @"疾病类型";
        [_typeView addGestureRecognizer: tapGesture];
    }
    return _typeView;
}


- (GYHillnessView *)detailedView{
    
    if (!_detailedView ) {
        //点击手势
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickDetailView:)];
        
        _detailedView = [[GYHillnessView alloc] init];
         _detailedView.frame = CGRectMake(0, 104, screenW, 40);
        _detailedView.typeString = @"疾病细分";
        [_detailedView addGestureRecognizer:tapGesture];
    }
    
    return _detailedView;
}

- (GYHDesrcibleView *)descView{
    
    if (!_descView) {
        
        typeof(self)  _weakSelf = self;
       
        _descView = [[GYHDesrcibleView alloc] init];
      
        //获取详细病情字符
        [_descView setCallBackTextString:^(NSString *text) {
            
            _weakSelf.recordModel.describe = text;
        }];
        
         typeof(_descView) weakDescView = _descView;
        //回调获取标签数组
        [_descView setDidClickButton:^(NSMutableArray *tempStringArray) {
            
        GYHDescListController *descList = [[GYHDescListController alloc] init];
            
            //设置上一次选中的标签数组
            descList.cacheStringArray = tempStringArray;
            
            //回调选中的标签数组
            [descList setGetStringArr:^(NSMutableArray *stringArray) {
                
                //给dexView设置选中的标签
                weakDescView.stringArray = stringArray;
                
                //将选中的标签数组写入到病历模型里面
                _weakSelf.recordModel.desArray = stringArray;
                
            }];
            
            
        [_weakSelf.navigationController pushViewController:descList animated:YES];
            
        }];
        
        _descView.frame = CGRectMake(0, 164, screenW, 200);
        
    }
    return _descView;
}

/**
 *  lanjiaz图片View 可以获取图片数组 
 *
 *  @return <#return value description#>
 */
- (GYHRecordPictureView *)recordView{
    
    if (!_recordView) {
        
        //创建添加图片的View
        _recordView = [[GYHRecordPictureView alloc] init];
        
        typeof(self) weakSelf = self;
        //返回图片的数组
        [_recordView setCallBackImageArray:^(NSMutableArray *imageArr) {
            weakSelf.recordModel.picArray = imageArr;
        }];
        //返回HMimagePicker框架需要保存的信息
        [_recordView setCallBackPictureDict:^(NSDictionary *dict) {
            
            weakSelf.recordModel.pictureDict = dict;
            
        }];

        _recordView.frame = CGRectMake(0, 364, screenW, 150);
    }
    return _recordView;
}

//病历模型
- (GYHRecordModel*)recordModel{
    
    if (!_recordModel) {
        _recordModel = [[GYHRecordModel alloc] init];
    }
    
    return _recordModel;
}



#pragma mark - 响应事件 

/**
 *  返回按钮
 *
 *  @param button <#button description#>
 */
- (void)didBackButton:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 *  点击确定按钮
 *
 *  @param button <#button description#>
 */
- (void)didClickSureButton:(UIButton *)button{
    
    //判断病历模型是否已经建好
    
    if ([self.typeView.illnessString isEqualToString:@"请选择"]) {
        
        [SVProgressHUD showErrorWithStatus:@"确定选择病历前,请先选择类型"];
        delay(1);
        
        return;
    }
    
    NSDateFormatter *formater = [[NSDateFormatter alloc]init];
    [formater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *time = [formater stringFromDate:[NSDate date]];

    //设置病历的创建时间
    self.recordModel.time = time;

    GYHRecordModel *model = self.recordModel;
    //回传block
    if (self.callbackModel) {
        
        self.callbackModel(model);
    }
    [self.navigationController popViewControllerAnimated:YES];
}


/**
 *  点击删除按钮
 *
 *  @param button <#button description#>
 */
- (void)didClickDeleteButton:(UIButton *)button{
    
    GYHRecordModel *model = self.recordModel;
    if (self.callbackDeletedModel) {
        
        self.callbackDeletedModel(model);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 *  点击疾病类型View
 *
 *  @param view <#view description#>
 */
- (void)didClickTybeView:(UIView *)view{
    
    GYHTybeillnessController *tybeIllnessController = [[GYHTybeillnessController alloc] init];
    
    [tybeIllnessController setGetTypeString:^(NSString *typeString,NSInteger index) {
        
        //获取疾病类型
        self.typeView.illnessString = typeString;
        self.index = index;
        self.recordModel.caseCatogory = typeString;
        
    }];
    
    [self.navigationController pushViewController:tybeIllnessController animated:YES];
}

/**
 *  点击疾病细分按钮
 *
 *  @param view <#view description#>
 */
- (void)didClickDetailView:(UIView*)view {
    
    if (![self.typeView.illnessString isEqualToString:@"请选择"]) {
        
        GYHDetaillnessController *detailController = [[GYHDetaillnessController alloc] init];
        [detailController setGetInessString:^(NSString *String
                                              , NSInteger index) {
            
            self.detailedView.illnessString = String;
            self.recordModel.caseDetail = String;
            self.recordModel.catogoryIndex = index;
            
        }];
        
        detailController.illnessIndex = self.index;
        [self.navigationController pushViewController:detailController animated:YES];
        
    }else{
        [SVProgressHUD showErrorWithStatus:@"🐷🐷请选择疾病类型 🐷🐷"];
        delay(1);
        
    }
}

/**
 * 从病历模型里面读取数据
 *
 *  @param recordModel <#recordModel description#>
 */
- (void)setRecordModel:(GYHRecordModel *)recordModel{
    
    _recordModel = recordModel;
    
    self.typeView.illnessString = recordModel.caseCatogory;
    
    self.detailedView.illnessString = recordModel.caseDetail;
    
    self.recordView.pictureDict = recordModel.pictureDict;
    
    self.descView.stringArray = recordModel.desArray;
    
    self.descView.desText = recordModel.describe;
    
    self.index = recordModel.catogoryIndex;
    
}

@end
