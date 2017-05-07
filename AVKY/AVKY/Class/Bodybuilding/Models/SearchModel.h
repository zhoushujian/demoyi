//
//  SearchModel.h
//  AVKY
//
//  Created by zheng on 16/8/7.
//  Copyright © 2016年 杰. All rights reserved.
/*
 NSString* _name;			///<POI名称
 NSString* _uid;
	NSString* _address;		///<POI地址
	NSString* _city;			///<POI所在城市
	NSString* _phone;		///<POI电话号码
	NSString* _postcode;		///<POI邮编
	int		  _epoitype;		///<POI类型，0:普通点 1:公交站 2:公交线路 3:地铁站 4:地铁线路
	CLLocationCoordinate2D _pt;	///<POI坐标
 */

#import <Foundation/Foundation.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>

@interface SearchModel : NSObject <BMKAnnotation>

//协议规定必须实现
@property(nonatomic,assign)CLLocationCoordinate2D coordinate;

/**
 *  自定义属性
 */
@property(nonatomic,copy)NSString *phoneNumer;

@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *uid;
@property(nonatomic,copy)NSString *address;
@property(nonatomic,copy)NSString *city;
@property(nonatomic,copy)NSString *phone;
@property(nonatomic,copy)NSString *postcode;
@property(nonatomic,assign)int epoitype;
@property(nonatomic,assign)CLLocationCoordinate2D pt;
@end
