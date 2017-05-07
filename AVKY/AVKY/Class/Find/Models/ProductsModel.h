//
//  ProductsModel.h
//  AVKY
//
//  Created by 杰 on 16/8/7.
//  Copyright © 2016年 杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductsModel : NSObject

@property(nonatomic,copy)NSString *name;

@property(nonatomic,copy)NSString *image;

//没优惠价
@property(nonatomic,assign)int price;
//优惠价
@property(nonatomic,assign)int payPrice;

@end
