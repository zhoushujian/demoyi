//
//  UserAccount.h
//  AVKY
//
//  Created by EZ on 16/8/5.
//  Copyright © 2016年 杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserAccount : NSObject

/**
 *  令牌,请求数据
 */
@property (nonatomic, copy) NSString *access_token;

/**
 *  从用户授权成功的那一刻到access_token过期的秒数
 */
@property (nonatomic, assign) NSTimeInterval expires_in;

/**
 *  过期日期
 */
@property (nonatomic, strong) NSDate *expires_date;

/**
 *  登录用户的id
 */
@property (nonatomic, copy) NSString *uid;

/**
 *  用户昵称
 */
@property (nonatomic, copy) NSString *screen_name;

/**
 *  用户头像
 */
@property (nonatomic, copy) NSString *avatar_large;

/**
 *  是否过期
 */
@property (nonatomic, assign) BOOL isExpired;

/**
 *  判断是否登录
 */
@property (nonatomic, assign) BOOL isLogin;

/**
 *  当前登录的ID
 */
@property (nonatomic, copy) NSString *loginID;

/**
 *  创建单例
 *
 *  @return 单例用户对象
 */
+ (instancetype)sharedUserAccount;

/**
 *  保存用户数据
 *
 *  @param userDict 字典参数
 */
- (void)saveUserAccount:(NSDictionary *)userDict;
/**
 *  注销用户
 */
- (void)removeOAuthKey;

/**
 *  吧image存进沙盒
 *
 *  @param image image
 */
-(void)saveImageDocuments:(UIImage *)image;
/**
 *  从沙盒中获取图片
 *
 *  @return 返回一个image
 */
-(UIImage *)getDocumentImage;

@end

















