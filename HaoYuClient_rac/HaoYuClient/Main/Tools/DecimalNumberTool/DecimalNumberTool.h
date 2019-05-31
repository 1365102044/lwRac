//
//  DecimalNumberTool.h
//  TestDemo
//
//  Created by 刘文强 on 2017/8/4.
//  Copyright © 2017年 LWQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DecimalNumberTool : NSObject

+ (instancetype)share;

/**
 相加
 */
- (NSString *)SumWithStr1:(NSString *)str1 Str2:(NSString *)str2;
/**
 相减
 */
- (NSString *)SubtracWithStr1:(NSString *)str1 Str2:(NSString *)str2;
/**
 相乘
 */
- (NSString *)MultiplyWithStr1:(NSString *)str1 Str2:(NSString *)str2;
/**
 相除
 */
- (NSString *)DividWithStr1:(NSString *)str1 Str2:(NSString *)str2;

@end
