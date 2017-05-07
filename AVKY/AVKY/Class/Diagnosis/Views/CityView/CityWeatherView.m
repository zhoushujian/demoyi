//
//  CityWeatherView.m
//  AVKY
//
//  Created by 杰 on 16/8/4.
//  Copyright © 2016年 杰. All rights reserved.
//

#import "CityWeatherView.h"
#import "Masonry.h"
#import "YZNetworkTool.h"
#import "TLCityPickerController.h"
#import <CoreLocation/CoreLocation.h>

#define globelColor [UIColor colorWithRed:47/255.0 green:196/255.0 blue:196/255.0 alpha:1]
#define topH self.bounds.size.height
// 百度天气接口
#define kBDWeather_KEY @"17IvzuqmKrK1cGwNL6VQebF9"
#define kGetWeather_URL(city) ([NSString stringWithFormat: @"http://api.map.baidu.com/telematics/v3/weather?location=%@&output=json&ak=%@", city, kBDWeather_KEY])

@interface CityWeatherView ()<CLLocationManagerDelegate>

///  分割线
@property (nonatomic, strong) UIView *seperator;
///  定位单例
@property (nonatomic, strong) CLLocationManager *locationManager;
///  当前城市
@property (nonatomic, strong) NSString *currentCity;
@property (nonatomic, strong) CLGeocoder *geocoder;

@end

@implementation CityWeatherView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
     
        self.backgroundColor = [UIColor colorWithRed:230/255.0 green:246/255.0 blue:249/255.0 alpha:1];
        [self setupLocation];
        [self setupUI];
    }
    return self;
}

#pragma mark - 开启定位
- (void)setupLocation {
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    if (kCLAuthorizationStatusNotDetermined == status) {
        ///  请求定位授权
        [self.locationManager requestWhenInUseAuthorization];
    }
    if ([CLLocationManager locationServicesEnabled]) {
        self.locationManager.delegate = self;
        [self.locationManager startUpdatingLocation];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"home_cannot_locate", comment:@"无法进行定位") message:NSLocalizedString(@"home_cannot_locate_message", comment:@"请检查您的设备是否开启定位功能") delegate:self cancelButtonTitle:NSLocalizedString(@"common_confirm",comment:@"确定") otherButtonTitles:nil, nil];
        [alert show];
    }

}

#pragma mark - CLLocationManagerDelegate {
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    [self.locationManager stopUpdatingLocation];
    ///  获得当前城市最新位置
    CLLocation *currentLocation = [locations lastObject];
    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    
    self.geocoder = geocoder;
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        if (placemarks.count > 0) {
            CLPlacemark *placeMark = placemarks[0];
            self.currentCity = placeMark.locality;
            
            if (!self.currentCity) {
                self.currentCity = placeMark.administrativeArea;
            }else if (self.currentCity) {

                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    dispatch_async(dispatch_get_main_queue(), ^{
                       
                        
                        YZNetworkTool *manager = [YZNetworkTool sharedManager];
                        ///  天气的 key
                        NSString *key = @"17IvzuqmKrK1cGwNL6VQebF9";
                        ///  数据 url
                        NSString *url = @"http://api.map.baidu.com/telematics/v3/weather";
                        ///  参数
                        NSDictionary *parameters = @{@"location":[NSString stringWithFormat:@"%@", self.currentCity],
                                                     @"output":@"json",
                                                     @"ak":key};
                        [manager request:url type:NetworkToolTypeGet Paramer: parameters callBack:^(id responseBody) {
                            
//                            "Date" = "Date";//日期
//                            "weather" = "weather";//温度天气
                            NSString *ddate = NSLocalizedString(@"Date", nil);
                            
                            
                            NSString *date = [NSString stringWithFormat:@"%@: %@",ddate, responseBody[@"date"]];
                            NSArray *results = responseBody[@"results"];
                            NSDictionary *weatherDic = results.lastObject;
                            NSArray *weathers = weatherDic[@"weather_data"];
                            
                            NSDictionary *todayWeather_data = weathers.firstObject;
                            NSString *weather = todayWeather_data[@"weather"];
                            NSString *temperature = todayWeather_data[@"temperature"];
                            
                             [self setLocationTitle:self.currentCity andWeatherImg:nil andWeatherTitle:weather andTemperature:temperature andDate:date];
                        }];

                        [self.locationManager stopUpdatingLocation];
                    });
                });
            } else if (error == nil && placemarks.count == 0) {
                NSLog(@"No location and error returned");
            } else if (error) {
                NSLog(@"Location error: %@", error);
            }
        }
    }];
}



#pragma mark - 设置 UI
- (void)setupUI {
//    "LoadingMedium" = "正在加载中...";//正在加载中...
    NSString *LoadingMedium = NSLocalizedString(@"LoadingMedium", nil);
    //  天气图标
    self.weatherImg = [[UIImageView alloc]init];
    self.weatherImg.image = [UIImage imageNamed:@"sun"];
    
    //  天气标签
    self.weatherLabel = [[UILabel alloc]init];
    self.weatherLabel.text = LoadingMedium;
    self.weatherLabel.textColor = globelColor;
    self.weatherLabel.font = [UIFont systemFontOfSize:15];
    
    //  城市
    self.locationBtn = [[UIButton alloc]init];
    [self.locationBtn setTitle:LoadingMedium forState:(UIControlStateNormal)];
    self.locationBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    self.locationBtn.titleLabel.numberOfLines = 0;
    [self.locationBtn sizeToFit];
    [self.locationBtn setTitleColor:globelColor forState:(UIControlStateNormal)];
    [self.locationBtn addTarget:self action:@selector(clickToPushToCityController:) forControlEvents:UIControlEventTouchUpInside];
    
    //  分割线
    self.seperator = [[UIView alloc]init];
    self.seperator.backgroundColor = [UIColor lightGrayColor];
    
    //  温度
    self.temperatureLabel = [[UILabel alloc]init];
    self.temperatureLabel.text = LoadingMedium;
    self.temperatureLabel.font = [UIFont systemFontOfSize:14];
    self.temperatureLabel.textColor = globelColor;
    
    //  日期
    self.dateLabel = [[UILabel alloc]init];
    self.dateLabel.text = LoadingMedium;
    self.dateLabel.textColor = globelColor;
    self.dateLabel.font = [UIFont systemFontOfSize:14];
    [self setLocationTitle:self.locationBtn.titleLabel.text andWeatherImg:nil andWeatherTitle:self.weatherLabel.text andTemperature:self.temperatureLabel.text andDate:self.dateLabel.text];
    
    [self addSubview:self.weatherImg];
    [self addSubview:self.weatherLabel];
    [self addSubview:self.locationBtn];
    [self addSubview:self.seperator];
    [self addSubview:self.temperatureLabel];
    [self addSubview:self.dateLabel];
}

#pragma mark - 自动布局
- (void)layoutSubviews {
    [super layoutSubviews];
    // 天气图标
    [self.weatherImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(screenW*0.01);
        make.top.equalTo(self).offset(topH*0.15);
        make.bottom.equalTo(self).offset(-topH*0.15);
        make.width.mas_equalTo(screenW * 0.13);
    }];
    
    // 天气标签
    [self.weatherLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.seperator.mas_top);
        make.left.equalTo(self.weatherImg.mas_right).offset(screenW * 0.02);
    }];
    
    // 城市
    [self.locationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.weatherImg.mas_right).offset(screenW * 0.02);
        make.bottom.mas_equalTo(self.seperator.mas_bottom);
    }];
    
    [self.seperator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(screenW*0.01);
        make.bottom.equalTo(self).offset(-screenW*0.01);
        make.width.mas_equalTo(1);
    }];
    
    // 温度
    [self.temperatureLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.seperator);
        make.left.equalTo(self.seperator).offset(screenW*0.01);
    }];
    
    //日期
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.seperator);
        make.left.equalTo(self.temperatureLabel);
    }];
}

-(void)setLocationTitle:(NSString *)cityName andWeatherImg:(UIImage *)weatherImage andWeatherTitle:(NSString *)weatherTitle andTemperature:(NSString *)tempStr andDate:(NSString *)dateStr {
    
    ///  天气图标的获取
    if ([weatherTitle containsString:@"晴"] ) {
        weatherImage = [UIImage imageNamed:@"icon_weather_qing"];
    }else if ([weatherTitle containsString:@"雨"]) {
        weatherImage = [UIImage imageNamed:@"dayu"];
    }else if ([weatherTitle containsString:@"云"]) {
        weatherImage = [UIImage imageNamed:@"icon_weather_duoyun"];
    }else if ([weatherTitle containsString:@"阴"]){
        weatherImage = [UIImage imageNamed:@"yinTOduoyun"];
    }

    self.locationBtn.titleLabel.text = cityName;
    self.weatherImg.image = weatherImage;
    self.weatherLabel.text = weatherTitle;
    NSString *wweather = NSLocalizedString(@"weather", nil);
    self.temperatureLabel.text = [NSString stringWithFormat:@" %@:%@",wweather,tempStr];
    self.dateLabel.text = [NSString stringWithFormat:@"%@",dateStr];
    
    
}

- (void)clickToPushToCityController:(UIButton *)button {
    void (^weatherBlock)(NSString *, NSString *, NSString *, NSString *) = ^(NSString *weatherStr, NSString *locationStr, NSString *date, NSString *temp){
        [self setLocationTitle:locationStr andWeatherImg:nil andWeatherTitle:weatherStr andTemperature:temp andDate:date];
    };
    
    if ([self.delegate respondsToSelector:@selector(pushToCityControllerWith:block:)]) {
        [self.delegate pushToCityControllerWith:button block:weatherBlock];

    }

}

#pragma mark - TLCityPickerDelegate
- (void) cityPickerController:(TLCityPickerController *)cityPickerViewController didSelectCity:(TLCityModel *)city
{
    [self.locationBtn setTitle:city.cityName forState:UIControlStateNormal];
    [cityPickerViewController dismissViewControllerAnimated:YES completion:nil];
    
}

- (void) cityPickerControllerDidCancel:(TLCityPickerController *)cityPickerViewController{
    [cityPickerViewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 懒加载
- (CLLocationManager *)locationManager {
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
    }
    return _locationManager;
}

- (NSString *)currentCity {
    if (!_currentCity) {
        _currentCity = [[NSString alloc]init];
    }
    return _currentCity;
}

@end
