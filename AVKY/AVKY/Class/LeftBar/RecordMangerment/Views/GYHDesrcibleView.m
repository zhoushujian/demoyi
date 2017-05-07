//
//  GYHDesrcibleView.m
//  AVKY
//
//  Created by Marcello on 16/8/5.
//  Copyright © 2016年 杰. All rights reserved.
//

#import "GYHDesrcibleView.h"
#import <Masonry.h>
#import "GYHDescListController.h"

#import "GYHEdgeInsetsLabel.h"



@interface GYHDesrcibleView ()<UITextViewDelegate>

/**
 *  疾病描述标签
 */
@property (nonatomic, strong) UILabel *descLable;

/**
 *  添加描述标签
 */
@property (nonatomic, strong) UIButton *addDescButton;

/**
 *  底部黑线View
 */
@property (nonatomic, strong) UIView *lineView;

/**
 *  加号图片
 */
@property (nonatomic, strong) UIButton * addPictureView;

/**
 *  疾病文本输入框
 */
@property (nonatomic, strong) UITextView *descTextVeiw;

//@property (nonatomic, assign) CGFloat sum;

/**
 *  装载默认的描述
 */
@property (nonatomic, strong) UIView *containtView;

@property (nonatomic, strong) UILabel *stringLable;

/**
 *  下一个Lable的frame
 */
@property (nonatomic, assign) CGRect lastFrame;

/**
 *  判断是否第二行Lable
 */
@property (nonatomic, assign) BOOL isSecondLable;

@property (nonatomic, strong) MASConstraint *heightConstraint;

@end

@implementation GYHDesrcibleView


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


- (void)setUPUI{
    

    
    self.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:self.descLable];
    [self addSubview:self.addPictureView];
    [self addSubview:self.lineView];
    [self addSubview:self.addDescButton];
    [self addSubview:self.descTextVeiw];
    [self addSubview:self.containtView];
    [self.descTextVeiw addSubview:self.stringLable];
    
    //设置子控件
    
    //布局子控件
    [self.descLable mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.mas_left).offset(10);
        make.top.mas_equalTo(self.mas_top).offset(10);
        
    }];
    
    [self.addPictureView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(self.mas_right).offset(-10);
        
        make.top.mas_equalTo(self.mas_top).offset(7);
        
    }];
    
    [self.addDescButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(self.addPictureView.mas_left).offset(-5);
        make.top.mas_equalTo(self.descLable.mas_top).offset(-8);
    }];
    
    [self.containtView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(20);
        make.right.mas_equalTo(self.mas_right).offset(-20);
        make.top.mas_equalTo(self.descLable.mas_bottom).offset(10);
        self.heightConstraint = make.height.mas_equalTo(0);
        
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.mas_left).offset(10);
        make.bottom.mas_equalTo(self.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(screenW, 1));
    }];
    
    [self.descTextVeiw mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.mas_left).offset(20);
        make.right.mas_equalTo(self.mas_right).offset(-20);
        make.top.mas_equalTo(self.containtView.mas_bottom).offset(15);
        make.bottom.mas_equalTo(self.lineView.mas_top).offset(-10);
    
    }];
    
}


- (void)setStringArray:(NSMutableArray *)stringArray{
    
    _stringArray = stringArray;
    
    self.isSecondLable = NO;
    //没有选中时
    if (_stringArray.count == 0) {
        
       
        [self.heightConstraint uninstall];
        [self.containtView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
            
        }];
    }
    self.lastFrame = CGRectZero;
    [self.containtView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [obj removeFromSuperview];
    }];
    
    [_stringArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
//        NSLog(@"========string = %@",obj);
        
        GYHEdgeInsetsLabel *lable = [[GYHEdgeInsetsLabel alloc] init];
        
        typeof(lable) weakLable = lable;
        lable.edgeInsets = UIEdgeInsetsMake(5, 5, 5, 5); // 设置内边距
        lable.font= [UIFont fontWithName:@"HelveticaNeue-Thin" size:20];
        [lable setDeleteFromSuperView:^(NSString *text) {
            //判断属性是否添加还是删除
            
            if (weakLable.isDeleted) {
                
               [self.stringArray removeObject:text];
                
            }else{
                
                [self.stringArray addObject:text];
            }
            
            
        }];
        
        lable.textColor = globalColor;
        lable.text = obj;
        
        [lable sizeToFit];
        lable.layer.borderColor = globalColor.CGColor;
        lable.layer.borderWidth = 3;
        
        CGFloat Width = lable.frame.size.width;
        CGFloat height = lable.frame.size.height;
        
        CGFloat tempHeight = 0;
        
        //第二行改变高度
        if (self.isSecondLable) {
            
            tempHeight = height * 2 + 10;
        }
        else{
            
            tempHeight = height;
        }

        //更改约束
        [self.heightConstraint uninstall];
        [self.containtView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(tempHeight);
            }];

        lable.frame = CGRectMake(self.lastFrame.size.width+self.lastFrame.origin.x +20 , tempHeight - height, Width, height);
        
        [self.containtView addSubview:lable];
        
        self.lastFrame = lable.frame;
        
        if (self.lastFrame.origin.x+ lable.frame.size.width +20 > screenW) {
            
            lable.frame = CGRectMake(0+20 , tempHeight +10                                                                                                             , Width, height);
            self.lastFrame = lable.frame;
            
            self.isSecondLable = YES;
    
            //更改约束
            [self.heightConstraint uninstall];
            [self.containtView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo((height+10) *2);
            }];
        }
        
        
    }];
    
}

- (void)setDesText:(NSString *)desText{
    _desText = desText;
    self.descTextVeiw.text = desText;
    self.stringLable.text = @"";
}

#pragma mark - 响应事件

/**
 *  点击添加病历描述标签
 *
 *  @param button <#button description#>
 */
- (void)didClickAddDescButton:(UIButton *)button{

    
    if (self.didClickButton) {
        
        self.didClickButton(self.stringArray);
    }
    


}

#pragma mark - 代理方法 

- (void)textViewDidChange:(UITextView *)textView{
    
   self.stringLable.text =  self.descTextVeiw.text.length == 0 ? @"请输入你的病历情况":@"";
    
    if (textView.text.length >0) {
        
        if (self.callBackTextString) {
            
            self.callBackTextString(textView.text);
        }
    }
    
    
    if (textView.text.length ==0) {
        textView.text = nil;
    }
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


#pragma  mark - 懒加载

/**
 *  描述Lable
 *
 *  @return <#return value description#>
 */
- (UILabel *)descLable{
    
    if (!_descLable) {
        _descLable = [[UILabel alloc] init];
        _descLable.text = @"疾病描述";
    }
    return _descLable;
}

/**
 *  添加描述LAble
 *
 *  @return <#return value description#>
 */
- (UIButton *)addDescButton{
    
    if (!_addDescButton) {
        
        _addDescButton = [[UIButton alloc] init];
        _addDescButton.titleLabel.numberOfLines = 0;
        _addDescButton.titleLabel.textAlignment = NSTextAlignmentRight;
        [_addDescButton addTarget:self action:@selector(didClickAddDescButton:) forControlEvents:UIControlEventTouchUpInside];
        [_addDescButton setTitle:@"添加病症描述标签" forState:UIControlStateNormal];
        [_addDescButton setTitleColor:globalColor forState:UIControlStateNormal];
    }
    
    return _addDescButton;
}

/**
 *  小加号图片按钮
 *
 *  @return <#return value description#>
 */
- (UIButton *)addPictureView{
    
    if (!_addPictureView) {
        
        _addPictureView = [[UIButton alloc] init];
        [_addPictureView setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
        [_addPictureView addTarget:self action:@selector(didClickAddDescButton:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _addPictureView;
}

/**
 *  底部分割线
 *
 *  @return <#return value description#>
 */
- (UIView *)lineView{
    
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return _lineView;
}

/**
 *  输入框
 *
 *  @return <#return value description#>
 */
- (UITextView *)descTextVeiw{
    
    if (!_descTextVeiw) {
        _descTextVeiw = [[UITextView alloc] init];
        _descTextVeiw.delegate = self;
        _descTextVeiw.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    
    return _descTextVeiw;
}

/**
 *  装载标签栏
 *
 *  @return <#return value description#>
 */
- (UIView *)containtView{
    
    if (!_containtView) {
        
        _containtView = [[UIView alloc] init];
       // _containtView.backgroundColor = [UIColor brownColor];
    }
    
    return _containtView;
}

/**
 *  占位Lable
 *
 *  @return <#return value description#>
 */
- (UILabel *)stringLable{
    
    if(!_stringLable){
        
        _stringLable = [[UILabel alloc] init];
        _stringLable.frame = CGRectMake(5, 5, 200, 20);
        _stringLable.text = @"请输入你的病历情况";
        _stringLable.font = [UIFont systemFontOfSize:15];
        _stringLable.textColor = [UIColor darkGrayColor];
        [_stringLable sizeToFit];
    }
    return _stringLable;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.descTextVeiw resignFirstResponder ];
}

@end
