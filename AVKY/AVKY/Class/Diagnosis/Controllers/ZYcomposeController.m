//
//  ZYcomposeController.m
//  AVKY
//
//  Created by 周勇 on 16/8/10.
//  Copyright © 2016年 杰. All rights reserved.
//

#import "ZYcomposeController.h"
#import "ZYfirstStageDisease.h"
#import "ZYcomposeCell.h"

@interface ZYcomposeController ()
@property (nonatomic, strong) UILongPressGestureRecognizer *longPress;
@end

@implementation ZYcomposeController

-(void)viewDidLoad{
    
    [super viewDidLoad];
    [self setup];
    [self addNoti];
}
/**
 *  注册cell
 */
-(void)setup{
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ZYcomposeCell" bundle:nil] forCellReuseIdentifier:@"compose"];
    
}

/**
 *  添加通知
 */
-(void)addNoti{
    
    //composeCell
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(conpose:) name:@"composeCell" object:nil];
}
/**
 *  通知方法
 */
-(void)conpose:(NSNotification * )notification{
    
    if (notification.userInfo[@"delete"] != nil) {
        ZYfirstStageDisease * fd = notification.userInfo[@"delete"];
        [_dataArr removeObject:fd];
        [self.tableView reloadData];
    }else if (notification.userInfo[@"top"] != nil){
        
        ZYfirstStageDisease * fd = notification.userInfo[@"top"];
        [_dataArr removeObject:fd];
        [_dataArr insertObject:fd atIndex:0];
        [self.tableView reloadData];
    }else if (notification.userInfo[@"move"] != nil){
        [self longPressRecognizer];
    }
    
}
/**
 *  长按手势
 */
-(void)longPressRecognizer{
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressRecognizer:)];
    self.longPress = longPress;
    longPress.minimumPressDuration = 1.0;
    [self.tableView addGestureRecognizer:longPress];
    
}

#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ZYcomposeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"compose"];
    ZYfirstStageDisease * fd = _dataArr[indexPath.row];
    cell.fd = fd;
    return cell;
}

-(void)setDataArr:(NSMutableArray *)dataArr{
    
    _dataArr = dataArr;
}
/**
 *  移除通知
 */
-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"composeCell" object:nil];
}

//cell长按拖动排序
- (void)longPressRecognizer:(UILongPressGestureRecognizer *)longPress{
    //获取长按的点及cell
    CGPoint location = [longPress locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:location];
    UIGestureRecognizerState state = longPress.state;
    
    static UIView *snapView = nil;
    static NSIndexPath *sourceIndex = nil;
    /**
     *  对手势状态进行判断
     */
    switch (state) {
        case UIGestureRecognizerStateBegan:{
            if (indexPath) {
                sourceIndex = indexPath;
                ZYcomposeCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                snapView = [self customViewWithTargetView:cell];
                
                __block CGPoint center = cell.center;
                snapView.center = center;
                snapView.alpha = 0.0;
                [self.tableView addSubview:snapView];
                
                [UIView animateWithDuration:0.1 animations:^{
                    center.y = location.y;
                    snapView.center = center;
                    snapView.transform = CGAffineTransformMakeScale(1.05, 1.05);
                    snapView.alpha = 0.5;
                    snapView.backgroundColor = [UIColor darkGrayColor];
                    cell.alpha = 0.0;
                }];
            }
        }
            break;
            
        case UIGestureRecognizerStateChanged:{
            CGPoint center = snapView.center;
            center.y = location.y;
            snapView.center = center;
            
            ZYcomposeCell *cell = [self.tableView cellForRowAtIndexPath:sourceIndex];
            cell.alpha = 0.0;
            
            if (indexPath && ![indexPath isEqual:sourceIndex]) {
                
                [_dataArr exchangeObjectAtIndex:indexPath.row withObjectAtIndex:sourceIndex.row];
                
                [self.tableView moveRowAtIndexPath:sourceIndex toIndexPath:indexPath];
                
                sourceIndex = indexPath;
            }
            
        }
            break;
            
        default:{
            UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:sourceIndex];
            
            [UIView animateWithDuration:0.25 animations:^{
                snapView.center = cell.center;
                snapView.transform = CGAffineTransformIdentity;
                snapView.alpha = 0.0;
                
                cell.alpha = 1.0;
            } completion:^(BOOL finished) {
                [snapView removeFromSuperview];
                snapView = nil;
            }];
            sourceIndex = nil;
        }
            break;
    }
}

//截取选中cell
- (UIView *)customViewWithTargetView:(UIView *)target{
    UIGraphicsBeginImageContextWithOptions(target.bounds.size, NO, 0);
    [target.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIView *snapshot = [[UIImageView alloc] initWithImage:image];
    snapshot.layer.masksToBounds = NO;
    snapshot.layer.cornerRadius = 0.0;
    snapshot.layer.shadowOffset = CGSizeMake(-5.0, 0.0);
    snapshot.layer.shadowRadius = 5.0;
    snapshot.layer.shadowOpacity = 0.4;
    
    return snapshot;
}
@end
