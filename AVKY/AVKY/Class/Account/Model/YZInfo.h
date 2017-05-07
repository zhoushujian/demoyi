/*
  用来储存个人信息,和账号对应,
 */

#import <Foundation/Foundation.h>

@interface YZInfo : NSObject

/**
 *  信息类别
 */
@property (nonatomic, copy) NSString *infoCategory;


/**
 *  信息内容
 */
@property (nonatomic, copy) NSString *infoText;

-(instancetype)initWithDic:(NSDictionary *)dic;

+(instancetype)infoWithDic:(NSDictionary *)dic;

@end
