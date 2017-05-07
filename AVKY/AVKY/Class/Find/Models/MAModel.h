//
//  MAModel.h
//  AVKY
//
//  Created by 杰 on 16/8/6.
//  Copyright © 2016年 杰. All rights reserved.
//

#import <Foundation/Foundation.h>


#import "ProductsModel.h"
typedef void(^SuccessBlock)(id responseBody);
typedef void(^failBlock)(NSError *error);

@interface MAModel : NSObject

//@property(nonatomic,strong)NSArray *products;
//
@property(nonatomic,assign)float height;

@property(nonatomic,assign)float width;

@property(nonatomic,copy)NSString *name;

@property(nonatomic,copy)NSString *danPinImg;

//没优惠价
@property(nonatomic,assign)int price;
//优惠价
@property(nonatomic,assign)int payPrice;


//
//@property(nonatomic,copy)NSString *img;

@property(nonatomic,strong)NSMutableArray *category;

+(void)GetModelUrl:(NSString *)url Paramer:(id)paramer Success:(SuccessBlock)successBlock failError:(failBlock)error;
@end
