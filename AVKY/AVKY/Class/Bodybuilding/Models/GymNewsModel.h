//
//  GymNewsModel.h
//  AVKY
//
//  Created by rayChow on 16/8/9.
//  Copyright © 2016年 杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GymNewsModel : NSObject

/**
 *  新闻标题
 */
@property (nonatomic, copy) NSString *title;
/**
 *  新闻图片
 */
@property (nonatomic, copy) NSString *imgsrc;
/**
 *  新闻摘要
 */
@property (nonatomic, copy) NSString *digest;
/**
 *  跟帖数
 */
@property (nonatomic, copy) NSString *replyCount;
/**
 *  多图标记
 */
@property (nonatomic, strong) NSArray *imgextra;
/**
 *  大图标记
 */
@property (nonatomic, assign) BOOL imgType;
/**
 *  加载新闻详情要使用的id
 */
@property (nonatomic, copy) NSString *docid;
/**
 *  加载新闻详情使用的URL字符串
 */
@property (nonatomic, copy) NSString *detailURLString;

+ (instancetype)gymNewsWithDic:(NSDictionary *)dic;

///  加载新闻数据
///
///  @param URLString 新闻的 url
///  @param success    成功回调
///  @param failed    失败回调
+ (void)loadNewsWithURLString:(NSString *)URLString success:(void (^)(NSArray *news))success failed:(void (^)(NSError *error))failed ;
@end
