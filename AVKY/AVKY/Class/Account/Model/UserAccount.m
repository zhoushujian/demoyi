//
//  UserAccount.m
//  AVKY
//
//  Created by EZ on 16/8/5.
//  Copyright © 2016年 杰. All rights reserved.
//

#import "UserAccount.h"

@implementation UserAccount

//单例对象工厂方法
+(instancetype)sharedUserAccount {
    static id instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

-(instancetype)init{
    if (self = [super init]) {
        //加载数据
        [self loadUserAccount];
    }
    return self;
}

/**
 *  读取用户信息
 */
-(void)loadUserAccount {
    //从沙盒中获取数据
    NSDictionary *userDict = [AVUserDefaultsTool objetForKey:userAccount];
    
    //判断是否有值,如果有就给属性赋值
    if (userDict) {
        [self setValuesForKeysWithDictionary:userDict];
    }
    
    //如果过期,令牌为nil
    if (self.isExpired) {
        self.access_token = nil;
    }
}

/**
 *  保存用户信息
 *
 *  @param userDict 字典参数
 */
-(void)saveUserAccount:(NSDictionary *)dict {
    //给属性赋值
    [self setValuesForKeysWithDictionary:dict];
    
    //模型转字典
    NSDictionary *userDict = [self dictionaryWithValuesForKeys:@[@"access_token", @"expires_date", @"uid", @"screen_name", @"avatar_large"]];
    
    //保存偏好设置
    [AVUserDefaultsTool saveObject:userDict forKey:userAccount];
}

//注销用户 
-(void)removeOAuthKey {
    [AVUserDefaultsTool saveObject:nil forKey:userAccount];
    self.access_token = nil;
}

#pragma mark - 保存图片 获取图片
//保存图片
-(void)saveImageDocuments:(UIImage *)image{
    //拿到图片
    UIImage *imagesave = image;
    NSString *path_sandox = NSHomeDirectory();
    //设置一个图片的存储路径 并且以当前登录ID 为图片名称
    NSString *pathID = [NSString stringWithFormat:@"/Documents/%@.png",self.loginID];
    NSString *imagePath = [path_sandox stringByAppendingString:pathID];
    //把图片直接保存到指定的路径（同时应该把图片的路径imagePath存起来，下次就可以直接用来取）
    [UIImagePNGRepresentation(imagesave) writeToFile:imagePath atomically:YES];
}
// 从沙盒获取图片
-(UIImage *)getDocumentImage{
    // 读取沙盒路径图片
    NSString *aPath=[NSString stringWithFormat:@"%@/Documents/%@.png",NSHomeDirectory(),self.loginID];
    // 拿到沙盒路径图片
    UIImage *imgFromUrl=[[UIImage alloc]initWithContentsOfFile:aPath];
    
    return imgFromUrl;
}

#pragma mark - setter && getter 方法
-(void)setExpires_in:(NSTimeInterval)expires_in {
    _expires_in = expires_in;
    //计算过期日期
    self.expires_date = [NSDate dateWithTimeIntervalSinceNow:expires_in];
}

// account_token 是否过期
-(BOOL)isExpired {
    NSDate *currentDate = [NSDate dateWithTimeIntervalSinceNow:0];

    return ([self.expires_date compare:currentDate] == NSOrderedAscending);
}

-(void)setUid:(NSString *)uid {
    _uid = uid;
    if (uid) {
        self.loginID = uid;
        [AVUserDefaultsTool saveObject:uid forKey:currentLoginID];
    }
}


- (BOOL)isLogin{
    
    return self.access_token != nil && !self.isExpired;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{}


@end
