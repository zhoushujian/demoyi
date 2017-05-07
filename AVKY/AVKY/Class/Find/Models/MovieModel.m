//
//  MovieModel.m
//  AVKY
//
//  Created by 杰 on 16/8/7.
//  Copyright © 2016年 杰. All rights reserved.
//

#import "MovieModel.h"
#import "YZNetworkTool.h"
@implementation MovieModel
-(instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
    
    
    
    
}


-(void)setValue:(id)value forUndefinedKey:(NSString *)key{}

+(instancetype)ModelWithDict:(NSDictionary *)dict{
    
    return [[self alloc]initWithDict:dict];
}
+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{@"creator" : [MovieCreatorModel class]};
    
}


+(void)GetModelUrl:(NSString *)url Paramer:(id)paramer Success:(SuccessBlock)successBlock failError:(failBlock)error{
    
    [[YZNetworkTool sharedManager] request:url type:NetworkToolTypeGet Paramer:paramer callBack:^(id responseBody) {
        if([responseBody isKindOfClass:[NSError class]]) {
            
            [SVProgressHUD showErrorWithStatus:@"网络出错"];
            delay(1.5);
            
            return;
        }

        NSArray *lives = responseBody[@"lives"];
        NSMutableArray *temp = [NSMutableArray array];
        
        [lives enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            [temp addObject:[MovieModel yy_modelWithJSON:obj]];
            
        }];

        successBlock(temp);
    }];
    
    
    
}
@end
