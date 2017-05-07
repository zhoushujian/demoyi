//
//  YZUserinfoController.m
//  AVKY
//
//  Created by EZ on 16/8/6.
//  Copyright © 2016年 杰. All rights reserved.
//

#import "YZUserinfoController.h"
#import "YZInfoCell.h"
#import "YZInfo.h"
#import "YZProvincePicker.h"
#import "YZWeightPicker.h"


static NSString *reuseIdentifier = @"infoCell";

@interface YZUserinfoController ()<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
/**
 *  姓名
 */
@property (nonatomic, strong) UIView  *provinceView;

@property (nonatomic, strong) UITableView *tableView;

/**
 *  信息类别 数组
 */
@property (nonatomic, strong) NSArray *infoCategory;
/**
 *  图像
 */
@property (nonatomic, weak) UIImageView *icon;

@end

@implementation YZUserinfoController

#pragma mark - viewDidLoad 方法
-(void)viewDidLoad {
    [super viewDidLoad];
//    "Pinformation" = "Personal Information";
    NSString *name = NSLocalizedString(@"Pinformation", nil);
    
    self.title = name;
    [self.view addSubview:self.tableView];
    //加入headerView
    [self createHeaderView];
    //注册cell
    [self.tableView registerClass:[YZInfoCell class] forCellReuseIdentifier:reuseIdentifier];
    self.tableView.rowHeight = 40;
    
    self.tableView.backgroundColor = COLOR(230, 230, 230);
}

#pragma mark - 设置UI

/**
 *  创建 tableView 的 headerView
 */
-(void)createHeaderView {
    //适配
    CGFloat height;
    if (is4inch) {
        height = 130;
    }else if(is47inch || is55inch) {
        height = 150;
    }
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, height)];
    //添加背景层
    UIImageView *backgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"07"]];
    //图像
    UIImageView *icon = [[UIImageView alloc] init];
    //判断沙盒中是否有缓存图片
    UIImage *image = [[UserAccount sharedUserAccount] getDocumentImage];
    if (image) {
        icon.image = image;
    }else {
        icon.image = [UIImage imageNamed:@"icon_bb"];
    }
    
    self.icon = icon;
    //设置 图像允许交互事件
    icon.userInteractionEnabled = YES;
    [icon addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeIcon)]];
    [headerView addSubview:backgroundImage];
    [headerView addSubview:icon];
    
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(headerView.mas_centerX);
        make.bottom.mas_equalTo(headerView.mas_bottom).offset(-10);
        make.size.mas_equalTo(CGSizeMake(70, 70));
    }];
    [backgroundImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(headerView);
    }];
    
    //切圆形图像
    icon.layer.masksToBounds = YES;
    icon.layer.cornerRadius = 35;
    
    self.tableView.tableHeaderView = headerView;
}

/**
 *  设置当前控制器的背景图片
 */
-(void)setupViewBackGround {
    UIImageView *backgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pic_hd_3"]];
    backgroundImage.frame = self.view.bounds;
    [self.view addSubview:backgroundImage];
}


#pragma mark - 响应事件
/**
 *  切换图像
 */
-(void)changeIcon {
    //弹窗提示 相册或相机
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    __weak typeof(self) weakself = self;
    //添加拍照选项
    [alertController addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:nil]];
    //添加相册选项
    [alertController addAction:[UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //创建图片选择器
        UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
        //设置控制器选择的资源类型 图库
        pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        pickerController.delegate = weakself;
        //允许图片修改
        pickerController.allowsEditing = YES;
        
        [weakself presentViewController:pickerController animated:YES completion:nil];
        
    }]];
    //取消按钮
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}


/**
 *  监听textfield编辑完成
 */
-(void)endediting:(UITextField *)textField  {
    
    //判断是否电话框
    if (textField.tag == 11){
        
        //验证手机号是否合法
        NSString *pattern = @"^((1[358]\\d)|(7[678])|(4[57]))\\d{8}$";
        NSString *phone = textField.text;
        NSString *result = [phone firstStringByRegularWithPattern:pattern];
        if (result == nil) {
            
            textField.tag = 111;
        }
    }
    //证件号码
    else if(textField.tag == 10) {
        
        //正则匹配用户身份证号15或18位  (^\d{15}$)|(^\d{17}([0-9]|X)$)
        NSString *pattern = @"(^[0-9]{15}$)|([0-9]{17}([0-9]|X)$)";
        NSString *phone = textField.text;
        NSString *result = [phone firstStringByRegularWithPattern:pattern];
        if (result == nil) {
            
            textField.tag = 100;
        }
    }
}

#pragma mark - UIImagePickerController 代理方法

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    //获取原始图片
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    self.icon.image = image;
    //保存image 到沙盒
    [[UserAccount sharedUserAccount] saveImageDocuments:image];
    //发送通知 更新图像
    [[NSNotificationCenter defaultCenter] postNotificationName:userIconNotification object:nil];
    [picker dismissViewControllerAnimated:YES completion:nil];
}
//取消时调用
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark -  UIAlertController
-(void)alertActionWithInfo:(YZInfo *)info indexPath:(NSIndexPath *)indexPath{
    
    // self 使用弱指针
    __weak typeof(self) weakself = self;
    // 性别选择
    if (indexPath.row == 1) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
            //2.先从沙盒取数据
            NSArray *infos = [AVUserDefaultsTool objetForKey:[UserAccount sharedUserAccount].loginID];
            NSMutableArray *arrMt = [NSMutableArray array];
            //追加原有数据
            [arrMt addObjectsFromArray:infos];
            //先遍历原有数据的 如修改原有数据 则先从数组删除原有的数据,在添加新数据
            for (NSDictionary *dict in arrMt) {
                //获取字典第一个key
                if ([info.infoCategory isEqualToString:dict.keyEnumerator.nextObject]) {
                    [arrMt removeObject:dict];
                    break;
                }
            }

            NSDictionary *infoText = [NSDictionary dictionaryWithObject:@"女" forKey:info.infoCategory];
            [arrMt addObject:infoText];
            //这里用单例用户 当前登录用户的ID 作为Key
            [AVUserDefaultsTool saveObject:arrMt forKey:[UserAccount sharedUserAccount].loginID];
            
            //2.给数组赋值
            info.infoText = @"女";
            //3.刷新数据行
            [weakself.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    
        }];
        
        UIAlertAction *archiveAction = [UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            //2.先从沙盒取数据
            NSArray *infos = [AVUserDefaultsTool objetForKey:[UserAccount sharedUserAccount].loginID];
            NSMutableArray *arrMt = [NSMutableArray array];
            //追加原有数据
            [arrMt addObjectsFromArray:infos];
            NSDictionary *infoText = [NSDictionary dictionaryWithObject:@"男" forKey:info.infoCategory];
            //先遍历原有数据的 如修改原有数据 则先从数组删除原有的数据,在添加新数据
            for (NSDictionary *dict in arrMt) {
                //获取字典第一个key
                if ([info.infoCategory isEqualToString:dict.keyEnumerator.nextObject]) {
                    [arrMt removeObject:dict];
                    break;
                }
            }
            [arrMt addObject:infoText];
            //这里用单例用户 当前登录用户的ID 作为Key
            [AVUserDefaultsTool saveObject:arrMt forKey:[UserAccount sharedUserAccount].loginID];
            
            //2.给数组赋值
            info.infoText = @"男";
            //3.刷新数据行
            [weakself.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        }];
        [alertController addAction:cancelAction];
        [alertController addAction:deleteAction];
        [alertController addAction:archiveAction];
        
        //弹出UIAlertController
        [self presentViewController:alertController animated:YES completion:nil];
    }
    // 修改内容
    else {
        
        NSString *title = [NSString stringWithFormat:@"修改%@",info.infoCategory];
        
        //创建UIAlertController
        UIAlertController *alertCtrl = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
        __weak UIAlertController *tempAlertCtrl = alertCtrl;
        
        //这就可以添加一个文本框，然后传入的block就是用来配置这个文本框
        [alertCtrl addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            //监听完成事件
            
           [textField addTarget:weakself action:@selector(endediting:) forControlEvents:UIControlEventEditingDidEnd];
            
            textField.placeholder = info.infoCategory;
            textField.textColor = [UIColor blueColor];
            textField.clearButtonMode = UITextFieldViewModeWhileEditing;
            textField.borderStyle = UITextBorderStyleRoundedRect;
            
            if (indexPath.row == 2) {
                textField.tag = 10;
                
            }else if (indexPath.row == 3){
                textField.tag = 11;
                textField.keyboardType = UIKeyboardTypeNumberPad;
            }else if (indexPath.row == 0){
                textField.tag = 20;
            }
        }];
        //
        //添加取消按钮
        UIAlertAction *ac1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alertCtrl addAction:ac1];
        
        
        //添加确定按钮
        
        UIAlertAction *ac2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
            //1.取出文本框
            UITextField *txtName = [tempAlertCtrl.textFields firstObject];
            
            
            if (txtName.tag == 111) {
                [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号!"];
                delay(2);
            }else if (txtName.tag == 100){
                [SVProgressHUD showErrorWithStatus:@"请输入正确的身份证号!"];
                delay(2);
            }else {
                // 判断昵称
                if (txtName.tag == 20){
                    // 保存昵称
                    [AVUserDefaultsTool saveObject:txtName.text forKey:userName_Key];
                    // 发送更改昵称的通知
                    [[NSNotificationCenter defaultCenter] postNotificationName:userNameNotification object:nil];
                }
                
                //2.先从沙盒取数据
                NSArray *infos = [AVUserDefaultsTool objetForKey:[UserAccount sharedUserAccount].loginID];
                NSMutableArray *arrMt = [NSMutableArray array];
                [arrMt addObjectsFromArray:infos];
                
                NSDictionary *infoText = [NSDictionary dictionaryWithObject:txtName.text forKey:info.infoCategory];
                //先遍历原有数据的 如修改原有数据 则先从数组删除原有的数据,在添加新数据
                for (NSDictionary *dict in arrMt) {
                    //获取字典第一个key
                    if ([info.infoCategory isEqualToString:dict.keyEnumerator.nextObject]) {
                        [arrMt removeObject:dict];
                        break;
                    }
                }
                [arrMt addObject:infoText];
                //这里用单例用户 当前登录用户的ID 作为Key
                [AVUserDefaultsTool saveObject:arrMt forKey:[UserAccount sharedUserAccount].loginID];
                
                //3.给数组赋值
                info.infoText = txtName.text;
                //4.刷新数据行
                [weakself.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];

            }
            
            
        }];
        [alertCtrl addAction:ac2];
        //弹出UIAlertController
        [self presentViewController:alertCtrl animated:YES completion:nil];
    }
    
}


-(void)dealloc {
    NSLog(@"销毁");
}

#pragma mark - UITableView 数据源方法和代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.infoCategory.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YZInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    YZInfo * info = [[YZInfo alloc] init];
    
    NSString *str = self.infoCategory[indexPath.row];
    //从沙盒回取数据
    NSString *idt = [UserAccount sharedUserAccount].loginID;
    NSArray *infos = [AVUserDefaultsTool objetForKey:idt];
    //匹配键值
    for (NSDictionary *dict in infos) {
        //获取字典第一个key
        if ([str isEqualToString:dict.keyEnumerator.nextObject]) {
            info.infoText = dict[str];
        }
    }
    
    info.infoCategory = str;
    cell.info = info;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //取消选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //取出模型数据
    YZInfo * info = [[YZInfo alloc] init];
    NSString *str = self.infoCategory[indexPath.row];
    info.infoCategory = str;
    NSInteger index = indexPath.row;
    switch (index) {
        case 0:
        case 1:
        case 2:
        case 3:
            [self alertActionWithInfo:info indexPath:indexPath];
            break;
        case 4:
        case 5:
            [self weight:info indexPath:indexPath];
            break;
        case 6:
        case 7:
            [self provincePickerView:info indexPath:indexPath];
        default:
            break;
    }
}

#pragma mark - PickerView

-(void)weight:(YZInfo *)info indexPath:(NSIndexPath *)indexPath{
    YZWeightPicker *weight = [YZWeightPicker weightPicker];
    weight.nameLabel.text = [NSString stringWithFormat:@"修改%@",info.infoCategory];
    //显示修改视图
    [weight show];
    
    __weak typeof(self) weakself = self;
    weight.pickerViewValueChangeBlock = ^(NSString *numberString){
        
        //1.先判断数字是否符合要求
        if (numberString.intValue < 60 && indexPath.row == 4) {
            [SVProgressHUD showErrorWithStatus:@"请认真身高数据!"];
            delay(1.5);
        } else if (numberString.intValue < 30 && indexPath.row == 5){
            [SVProgressHUD showErrorWithStatus:@"请认真体重数据"];
            delay(1.5);
        } else {
            
            //2.先从沙盒取数据
            NSArray *infos = [AVUserDefaultsTool objetForKey:[UserAccount sharedUserAccount].loginID];
            NSMutableArray *arrMt = [NSMutableArray array];
            [arrMt addObjectsFromArray:infos];
            
            //判断用什么公式
            if (indexPath.row == 4) {
                numberString = [NSString stringWithFormat:@"%@ cm",numberString];
                
            } else if (indexPath.row == 5){
                numberString = [NSString stringWithFormat:@"%@ kg",numberString];
            }
            
            NSDictionary *infoText = [NSDictionary dictionaryWithObject:numberString forKey:info.infoCategory];
            //先遍历原有数据的 如修改原有数据 则先从数组删除原有的数据,在添加新数据
            for (NSDictionary *dict in arrMt) {
                //获取字典第一个key
                if ([info.infoCategory isEqualToString:dict.keyEnumerator.nextObject]) {
                    [arrMt removeObject:dict];
                    break;
                }
            }
            [arrMt addObject:infoText];
            //这里用单例用户 当前登录用户的ID 作为Key
            [AVUserDefaultsTool saveObject:arrMt forKey:[UserAccount sharedUserAccount].loginID];
            
            //刷新数据行
            [weakself.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
            
        }
    };
    
}

-(void)provincePickerView:(YZInfo *)info indexPath:(NSIndexPath *)indexPath {
    YZProvincePicker *pickerView = [YZProvincePicker provincePicker];
    [pickerView show];
    
    __weak typeof(self) weakself = self;
    pickerView.pickerViewValueChangeBlock = ^(NSString *province, NSString *city){
        //2.先从沙盒取数据
        NSArray *infos = [AVUserDefaultsTool objetForKey:[UserAccount sharedUserAccount].loginID];
        NSMutableArray *arrMt = [NSMutableArray array];
        [arrMt addObjectsFromArray:infos];
        //拼接城市
        NSString *provinceCity = [NSString stringWithFormat:@"%@-%@",province,city];
        NSDictionary *infoText = [NSDictionary dictionaryWithObject:provinceCity forKey:info.infoCategory];
        //先遍历原有数据的 如修改原有数据 则先从数组删除原有的数据,在添加新数据
        for (NSDictionary *dict in arrMt) {
            //获取字典第一个key
            if ([info.infoCategory isEqualToString:dict.keyEnumerator.nextObject]) {
                [arrMt removeObject:dict];
                break;
            }
        }
        [arrMt addObject:infoText];
        //这里用单例用户 当前登录用户的ID 作为Key
        [AVUserDefaultsTool saveObject:arrMt forKey:[UserAccount sharedUserAccount].loginID];
        
        //刷新数据行
        [weakself.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    };
}


#pragma mark - 懒加载
/**
 *  tableView
 */
-(UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.frame = CGRectMake(0, 0, screenW, screenH);
    }
    return _tableView;
}

/**
 *  信息类别数组
 */
/**
 *  "Sex" = "sex";//性别
 "papers" = "Papers";//证件号码
 "Phone" = "Phone";//手机号码联系方式
 "Height" = "Height";//身高
 "weight" = "Weight";//体重
 "NativePlace" = "NativPlace";//籍贯
 "Residence" = "Residence";//居住地
 */
-(NSArray *)infoCategory {
    if (_infoCategory == nil) {
        NSString *name = NSLocalizedString(@"ID", nil);
        NSString *Sex = NSLocalizedString(@"Sex", nil);
        NSString *papers = NSLocalizedString(@"papers", nil);
        NSString *Phone = NSLocalizedString(@"Phone", nil);
        NSString *Height = NSLocalizedString(@"Height", nil);
        NSString *weight = NSLocalizedString(@"weight", nil);
        NSString *NativePlace = NSLocalizedString(@"NativePlace", nil);
        NSString *Residence = NSLocalizedString(@"Residence", nil);
//        _infoCategory = [NSArray arrayWithObjects:@"昵称",@"性别",@"证件号码",@"联系方式",@"身高",@"体重",@"籍贯",@"常居地", nil];
         _infoCategory = [NSArray arrayWithObjects:name,Sex,papers,Phone,Height,weight,NativePlace,Residence, nil];
    }
    return _infoCategory;
}


@end
