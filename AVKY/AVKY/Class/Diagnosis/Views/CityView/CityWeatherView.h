//
//  CityWeatherView.h
//  AVKY
//
//  Created by 杰 on 16/8/4.
//  Copyright © 2016年 杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CityWeatherDelegate <NSObject>

- (void)pushToCityControllerWith:(UIButton *)button block:(void (^)(NSString *, NSString *, NSString *, NSString *))weatherblock;

@end

@interface CityWeatherView : UIView

@property (nonatomic, weak) id <CityWeatherDelegate> delegate;

///  位置
@property (nonatomic, strong) UIButton *locationBtn;
///  天气图标
@property (nonatomic, strong) UIImageView *weatherImg;

///  天气文字
@property (nonatomic, strong) UILabel *weatherLabel;


///  温度
@property (nonatomic, strong) UILabel *temperatureLabel;

///  日期
@property (nonatomic, strong) UILabel *dateLabel;


///  根据回调的城市,设置城市按钮的文字,天气,温度,日期
- (void)setLocationTitle:(NSString *)cityName andWeatherImg: (UIImage *)weatherImage andWeatherTitle: (NSString *)weatherTitle andTemperature: (NSString *)tempStr andDate: (NSString *)dateStr;


@end
