//
//  FeedbackController.m
//  AVKY
//
//  Created by 杰 on 16/8/8.
//  Copyright © 2016年 杰. All rights reserved.
//

#import "FeedbackController.h"
#import "GYHSliderSettingGroup.h"
#import "GYHSliderSettingItem.h"
#import "GYHSliderSettingItemArrow.h"
#import "GYHSliderSettingitemLable.h"
#import "GYHSliderCell.h"
#import "PodView.h"

#import "RuntimeBtn.h"
#define num 20
@interface FeedbackController ()<UITextViewDelegate,UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITextView *textView;

@property(nonatomic,strong)UILabel *placeHolderLabel;

@property(nonatomic,strong)UILabel *changLb;

@property(nonatomic,strong)RuntimeBtn *btn;

@property(nonatomic,strong)UILabel *TextLabel;

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSMutableArray *groups;

@end

@implementation FeedbackController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"pic_hd_1"]] ;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.btn];
    self.navigationItem.rightBarButtonItem.imageInsets = UIEdgeInsetsMake(0, 0, 0, -10);
    
    [self setUI];
    
}

-(void)setUI{
    [self.view addSubview:self.textView];
    [self.view addSubview:self.changLb];
    [self.textView addSubview:self.placeHolderLabel];

    [self.view addSubview:self.TextLabel];
    
    [self.view addSubview:self.tableView];
    
    /**
     *  Cell模型
     */
    GYHSliderSettingItemArrow *item0 = [GYHSliderSettingItemArrow itemWithTitle:@"联系我们"icon:@"medtronic_phone" destVc:nil];
    item0.operationBlock = ^{

        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://10086"]];
    };
    
    GYHSliderSettingItemArrow *item1 = [GYHSliderSettingItemArrow itemWithTitle:@"用户交流群"icon:@"medtronic_service" destVc:nil];
    
    //触发点击事件---小弹框猴子
    item1.operationBlock = ^{
        PodView *view = [[PodView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        view.fly_h = 100;
        view.fly_w = 100;
        UIImageView *headerImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, view.fly_w, view.fly_h)];
        headerImage.image = [UIImage imageNamed:@"drug_search_place"];
        
        [self.view addSubview:view];
        [view.flyView addSubview:headerImage];
        [view startFly:FlyTypeUToD];
    };
    

    GYHSliderSettingGroup *group1 = [GYHSliderSettingGroup groupWithItems:@[item0,item1]];
    
    self.groups = [NSMutableArray arrayWithObjects:group1, nil];

    
    

    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(0);
        make.right.left.mas_equalTo(self.view);
        make.height.mas_equalTo(screenH/2);
        
    }];
    
    UIView *views = [[UIView alloc]init];
    views.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"pic_hd_1"]];
    [self.textView insertSubview:views atIndex:0];
    views.userInteractionEnabled = NO;
    
    [views mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.textView);
        make.size.equalTo(self.textView);
    }];
    [self.placeHolderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.textView).offset(5);
        make.top.equalTo(self.textView).offset(8);
        
    }];

    [self.changLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.textView.mas_bottom).offset(-25);
        make.right.mas_equalTo(self.view.mas_right);
        make.height.mas_equalTo(25);
        make.width.mas_equalTo(screenW);
        
    }];
    [self.TextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(screenW);
        make.top.mas_equalTo(self.textView.mas_bottom);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.TextLabel.mas_bottom);
        make.height.mas_equalTo(100);
        
    }];
    
    
}


#pragma mark -UITextView代理监听
-(void)textViewDidChange:(UITextView *)textView{
    
    NSInteger Length = num - self.textView.text.length;
    
    self.changLb.text = [NSString stringWithFormat:@"还能输入%ld字",Length];
    
    self.changLb.textColor = Length >=0 ? [UIColor darkGrayColor] : [UIColor redColor];
    self.changLb.text = Length >= 0 ? [NSString stringWithFormat:@"还能输入%ld字",Length] : [NSString stringWithFormat:@"你已经超出字数输入范围%ld",Length];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}
-(UITextView *)textView{
    if(!_textView){
    
        _textView.backgroundColor = [UIColor colorWithRed:221/255.0 green:253/255.0 blue:230/255.0 alpha:1];
        _textView= [[UITextView alloc] initWithFrame:CGRectMake(0, 64, screenW, screenH/2)]; //初始化大小并自动释放
        
        _textView.textColor = [UIColor blackColor];//设置textview里面的字体颜色
        
        _textView.font = [UIFont fontWithName:@"Arial" size:18.0];//设置字体名字和字体大小
        
        //设置它的委托方法
        _textView.delegate = self;
        
        //添加一个回弹的效果
        _textView.alwaysBounceVertical = YES;
        //拖拽时隐藏键盘
        _textView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange:) name:UITextViewTextDidChangeNotification object:nil];
        
        _textView.returnKeyType = UIReturnKeyDefault;//返回键的类型
        
        _textView.keyboardType = UIKeyboardTypeDefault;//键盘类型
        
        _textView.scrollEnabled = NO;//是否可以拖动
        
        _textView.autoresizingMask = UIViewAutoresizingFlexibleHeight;//自适应高度
        
    }
    return _textView;
}



-(void)BtnClick{
    
    if (self.textView.text.length <= num && self.textView.text.length != 0) {
        [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
        [SVProgressHUD show];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [SVProgressHUD showSuccessWithStatus:@"提交成功"];
            delay(1.2);
            self.textView.text = @"";
            [self.navigationController popViewControllerAnimated:YES];

        });
       
    }else if(self.textView.text.length == 0){
        [SVProgressHUD show];
        [SVProgressHUD showErrorWithStatus:@"不能提交空内容喔，亲"];
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
        [SVProgressHUD setBackgroundColor:globalColor];
        [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
        
    }else{
        [SVProgressHUD show];
        [SVProgressHUD showSuccessWithStatus:@"不能提交超出内容"];
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
        [SVProgressHUD setBackgroundColor:globalColor];
        [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    }
    delay(1);

}

#pragma mark - UITextView点击触发的通知
-(void)textDidChange:(NSNotification *)notification{

    self.placeHolderLabel.hidden =self.textView.text.length>0;

}

#pragma mark - TableView数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    GYHSliderSettingGroup *group = self.groups[section];
    return group.items.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    

        GYHSliderCell *cell = [GYHSliderCell cellWithTabelView:tableView];

        cell.showLineView = NO;

        GYHSliderSettingGroup *group = self.groups[indexPath.section];

        cell.item = group.items[indexPath.row];



        return cell;
}

#pragma mark -UItabelView代理

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.0001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    GYHSliderSettingGroup *group = self.groups[indexPath.section];
    GYHSliderSettingItem *item = group.items[indexPath.row];
    
    if (item.operationBlock) {
        item.operationBlock();
        return;
    }

    
}



-(UILabel *)placeHolderLabel{
    if (!_placeHolderLabel) {
        _placeHolderLabel = [[UILabel alloc]init];
        _placeHolderLabel.text = @"请输入您的对我们的宝贵意见";
        _placeHolderLabel.textColor = [UIColor lightGrayColor];
    }
    return _placeHolderLabel;
}

-(void)dealloc{

    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(UILabel *)changLb{
    if (!_changLb) {
        _changLb = [[UILabel alloc]init];
        _changLb.text = @"还能输入20个字";
        _changLb.font = [UIFont systemFontOfSize:14];
        _changLb.textAlignment = NSTextAlignmentRight;

    }
    return _changLb;
}
-(RuntimeBtn *)btn{
    if (!_btn) {
        _btn = [RuntimeBtn buttonWithType:UIButtonTypeCustom];
        [_btn setTitle:@"提交" forState:UIControlStateNormal];
        _btn.frame = CGRectMake(0, 0, 80, 40);
        _btn.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
        [_btn addTarget:self action:@selector(BtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}


-(UILabel *)TextLabel{
    if (!_TextLabel) {
        _TextLabel = [[UILabel alloc]init];
        _TextLabel.backgroundColor = globalColor;
        _TextLabel.text = @"   欢迎联系我们";
    }
    return _TextLabel;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollEnabled = NO;
    }
    return _tableView;
}

-(NSMutableArray *)groups{
    if (!_groups) {
        _groups = [[NSMutableArray alloc]init];
    }
    return _groups;
}


@end
