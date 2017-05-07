//
//  GYHSliderCell.m
//  AVKY
//
//  Created by Marcello on 16/8/4.
//  Copyright © 2016年 杰. All rights reserved.
//

#import "GYHSliderCell.h"
#import "GYHSliderSettingItemSwitch.h"
#import "GYHSliderSettingitemLable.h"
#import "GYHSliderSettingItemArrow.h"

@interface GYHSliderCell()
// 箭头
@property(nonatomic,strong) UIImageView *arrowView;
// 开关
@property(nonatomic,strong) UISwitch *switchView;
// 分割线
@property(nonatomic,strong) UIView *lineView;
// 文本标签
@property(nonatomic,strong) UILabel *labelView;

@end

@implementation GYHSliderCell

- (UILabel *)labelView {
    if (_labelView == nil) {
        _labelView = [[UILabel alloc] init];
        _labelView.font = [UIFont systemFontOfSize:14];
        _labelView.textAlignment = NSTextAlignmentRight;
        _labelView.textColor = [UIColor blueColor];
        _labelView.frame = CGRectMake(0, 0, 80, 20);
    }
    return _labelView;
}

- (UIView *)lineView {
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor blackColor];
        _lineView.alpha = 0.7;
    }
    return _lineView;
}

- (UISwitch *)switchView {
    if (_switchView == nil) {
        _switchView = [[UISwitch alloc] init];
        [_switchView addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _switchView;
}

- (UIImageView *)arrowView {
    if (_arrowView == nil) {
        _arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pic_cell_green_accessory_img"]];
    }
    return _arrowView;
}

+(instancetype)cellWithTabelView:(UITableView *)tableView{
    // 1. 声明一个重用标识
    static NSString *ID = @"setting";
    // 2.从缓冲池取
    GYHSliderCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[GYHSliderCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
    }
    return self;
}

- (void)setup{
    // 设置子控件的字体
    self.textLabel.font = [UIFont fontWithName:@"MicrosoftYaHei" size:14];

    self.textLabel.textColor = [UIColor grayColor];
    
    self.detailTextLabel.textColor = [UIColor blackColor];
    self.detailTextLabel.font = [UIFont fontWithName:@"MicrosoftYaHei" size:11];
    
    // 设置cell的背景
    [self setupCellBgColor];
    
    // 添加分割线
    [self.contentView addSubview:self.lineView];
}

/**
 *  设置cell的背景颜色
 */
- (void)setupCellBgColor{
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = [UIColor whiteColor];
    self.backgroundView = bgView;
    
    UIView *selectedBgView = [[UIView alloc] init];
    selectedBgView.backgroundColor = [UIColor whiteColor];
    self.selectedBackgroundView = selectedBgView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat lineH = 1;
    CGFloat lineY = self.frame.size.height - lineH;
    CGFloat lineX = self.textLabel.frame.origin.x;
    CGFloat lineW = self.frame.size.width - lineX;
    _lineView.frame = CGRectMake(lineX, lineY, lineW, lineH);
}

- (void)setShowLineView:(BOOL)showLineView{
    _showLineView = showLineView;
    self.lineView.hidden = showLineView;
}

- (void)setItem:(GYHSliderSettingItem *)item {
    _item = item;
    // 1.设置子控件数据
    [self settingData];
    // 2.设置cell右边显示的附件
    [self settingRightAccessory];
}

/**
 *  设置子控件数据
 */
- (void)settingData{
    self.textLabel.text = _item.title;
    self.detailTextLabel.text = _item.subTitle;
    if (_item.icon) {
        self.imageView.image = [UIImage imageNamed:_item.icon];
    }
}

/**
 *  设置cell右边显示的附件
 */
- (void)settingRightAccessory{
    //    if (_item.itemType == CZItemTypeArrow) { // 箭头
    //        self.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_right"]];
    //    } else if (_item.itemType == CZItemTypeSwitch) { // 开关
    //        self.accessoryView = [[UISwitch alloc] init];
    //    } else {
    //
    //    }
    self.selectionStyle = ([_item isKindOfClass:[GYHSliderSettingItemSwitch class]]) ? UITableViewCellSelectionStyleNone:UITableViewCellSelectionStyleDefault;
    if ([_item isKindOfClass:[GYHSliderSettingItemArrow class]]) { // 箭头
        self.accessoryView = self.arrowView;
    } else if ([_item isKindOfClass:[GYHSliderSettingItemSwitch class]]) { // 开关
        UISwitch *st = self.switchView;
        GYHSliderSettingItemSwitch *itemSwitch = (GYHSliderSettingItemSwitch *)_item;
        st.on = itemSwitch.on;
        
        self.accessoryView = st;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    } else if ([_item isKindOfClass:[GYHSliderSettingitemLable class]]) { // 标签
        GYHSliderSettingitemLable *labelItem = (GYHSliderSettingitemLable *)_item;
        self.labelView.text = labelItem.value;
        self.accessoryView = self.labelView;
    }else {
        self.accessoryView = nil;
    }
}

/**
 *  监听开关状态的改变
 */
- (void)valueChanged:(UISwitch *)st{
    GYHSliderSettingItemSwitch *itemSwitch = (GYHSliderSettingItemSwitch *)_item;
    itemSwitch.on = st.on;
    if (itemSwitch.switchBlock) {
        itemSwitch.switchBlock(st.on);
    }
}



@end
