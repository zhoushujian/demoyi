//
//  ZYASearchView.h
//  AVKY
//
//  Created by zheng on 16/8/7.
//  Copyright © 2016年 杰. All rights reserved.
//

#import <BaiduMapAPI_Map/BMKMapComponent.h>
@class SearchModel;

@interface ZYASearchView : BMKAnnotationView

+ (instancetype)searchViewWithAnnotation:(SearchModel *)searchAnnotation inMapView:(BMKMapView *)mapView;

@end
