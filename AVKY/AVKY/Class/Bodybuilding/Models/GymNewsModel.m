//
//  GymNewsModel.m
//  AVKY
//
//  Created by rayChow on 16/8/9.
//  Copyright © 2016年 杰. All rights reserved.
//

#import "GymNewsModel.h"
#import "YZNetworkTool.h"

@implementation GymNewsModel

+ (instancetype)gymNewsWithDic:(NSDictionary *)dic{
    GymNewsModel *model = [[self alloc]init];
    [model setValuesForKeysWithDictionary:dic];
    return model;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{}

- (void)setDocid:(NSString *)docid {
    _docid = [docid copy];
    _detailURLString = [NSString stringWithFormat:@"http://c.m.163.com/nc/article/%@/full.html",self.docid];
}

+ (void)loadNewsWithURLString:(NSString *)URLString success:(void (^)(NSArray *))success failed:(void (^)(NSError *))failed {
    [[YZNetworkTool sharedManager] request:URLString type:NetworkToolTypeGet Paramer:nil callBack:^(NSDictionary * responseBody) {
        

        ///  判断当前网络
        if([responseBody isKindOfClass:[NSError class]] || [responseBody[@"data"] isKindOfClass:[NSNull class]] || responseBody == nil) {
            [SVProgressHUD showErrorWithStatus:@"请检查您的网络"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
            
            return;
        }

        ///  获得字典第一个 key
        NSString *rootKey = responseBody.keyEnumerator.nextObject;
        ///  获得新闻数组
        NSArray *newsArray = responseBody[rootKey];
        
        NSMutableArray *news = [NSMutableArray array];
        [newsArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            ///  字典转模型
            GymNewsModel *model = [GymNewsModel gymNewsWithDic:obj];
            [news addObject:model];
        }];
        success(news.copy);
    }];
}
@end
