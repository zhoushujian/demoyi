//
//  ZYASearchView.m
//  AVKY
//
//  Created by zheng on 16/8/7.
//  Copyright © 2016年 杰. All rights reserved.
//

#import "ZYASearchView.h"
#import "SearchModel.h"
#define reuseID @"view"

@implementation ZYASearchView

+ (instancetype)searchViewWithAnnotation:(SearchModel *)searchAnnotation inMapView:(BMKMapView *)mapView {
    ZYASearchView *searchView = (ZYASearchView*)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseID];
    if (searchView == nil) {
        searchView = [[ZYASearchView alloc] initWithAnnotation:searchAnnotation reuseIdentifier:reuseID];
        searchView.image = [UIImage imageNamed:@"chatBar_colorMore_locationSelected"];
        searchView.canShowCallout =YES;
    }
    //跟新模型
    searchView.annotation = searchAnnotation;
    return searchView;
}

@end
