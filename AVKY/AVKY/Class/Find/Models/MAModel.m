//
//  MAModel.m
//  AVKY

//  Created by 杰 on 16/8/6.
//  Copyright © 2016年 杰. All rights reserved.


#import "MAModel.h"
#import "YZNetworkTool.h"

@implementation MAModel

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{@"products":[ProductsModel class]};
    
}

+(void)GetModelUrl:(NSString *)url Paramer:(id)paramer Success:(SuccessBlock)successBlock failError:(failBlock)error{
    
    
    
    [[YZNetworkTool sharedManager] request:url type:NetworkToolTypeGet Paramer:paramer callBack:^(id responseBody) {
        
        
        if([responseBody isKindOfClass:[NSError class]]) {
            
            [SVProgressHUD showErrorWithStatus:@"网络出错"];
            delay(1.5);
            
            return;
        }
        NSDictionary *dict = responseBody[@"data"];

        NSArray *lunbo = dict[@"products"];
        
        NSMutableArray *temp = [[NSMutableArray alloc]init];
        
        
        
        [lunbo enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            [temp addObject:[MAModel yy_modelWithJSON:obj]];
        }];
        successBlock(temp);
    }];
    

    
}


@end
