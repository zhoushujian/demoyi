//
//  NSString+Regular.h
//  01-正则基本使用
//
//  Created by Zed on 27/1/2016.
//  Copyright © 2016 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Regular)

/**
 * 根据正则语句, 返回第一个匹配的字符串
 */
- (NSString *)firstStringByRegularWithPattern:(NSString *)pattern;

/**
 *  根据正则语句, 返回第一个匹配的结果的范围
 */
- (NSRange)firstRangeByReuglarWithPattern:(NSString *)pattern;

@end
