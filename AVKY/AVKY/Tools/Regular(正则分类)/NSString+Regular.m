//
//  NSString+Regular.m
//  01-正则基本使用
//
//  Created by Zed on 27/1/2016.
//  Copyright © 2016 itcast. All rights reserved.
//

#import "NSString+Regular.h"

@implementation NSString (Regular)

- (NSRange)firstRangeByReuglarWithPattern:(NSString *)pattern
{
    NSTextCheckingResult *result = [self firstMatchWithPattern:pattern];
    if (result == nil) {
        return NSMakeRange(0, 0);
    }
    
    return result.range;
}

- (NSString *)firstStringByRegularWithPattern:(NSString *)pattern
{
    NSTextCheckingResult *result = [self firstMatchWithPattern:pattern];
    if (result == nil) {
        return nil;
    }
    
    return [self substringWithRange:result.range];
}

#pragma mark - 内部方法

- (NSTextCheckingResult *)firstMatchWithPattern:(NSString *)pattern
{
    NSError *error;
    NSRegularExpression *regular = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:&error];
    if (error) {
        return nil;
    }
    
    NSTextCheckingResult *result = [regular firstMatchInString:self options:0 range:NSMakeRange(0, self.length)];
    
    return result;
}

@end
