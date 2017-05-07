//
//  MovieModel.h
//  AVKY
//
//  Created by 杰 on 16/8/7.
//  Copyright © 2016年 杰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MovieCreatorModel.h"
typedef void(^SuccessBlock)(id responseBody);
typedef void(^failBlock)(NSError *error);

@interface MovieModel : NSObject
//城市
@property(nonatomic,copy)NSString *city;

@property(nonatomic,copy)NSString *id;

@property(nonatomic,assign)int online_users;

@property(nonatomic,strong)MovieCreatorModel *creator;

@property(nonatomic,copy)NSString *name;

@property(nonatomic,copy)NSString *stream_addr;

-(instancetype)initWithDict:(NSDictionary *)dict;

+(instancetype)ModelWithDict:(NSDictionary *)dict;



+(void)GetModelUrl:(NSString *)url Paramer:(id)paramer Success:(SuccessBlock)successBlock failError:(failBlock)error;

@end
