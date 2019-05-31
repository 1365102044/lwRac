//
//  DecimalNumberTool.m
//  TestDemo
//
//  Created by 刘文强 on 2017/8/4.
//  Copyright © 2017年 LWQ. All rights reserved.
//

#import "DecimalNumberTool.h"

@implementation DecimalNumberTool

+ (instancetype)share
{
    static dispatch_once_t onceToken;
    static DecimalNumberTool *instance;
    dispatch_once(&onceToken, ^{
        instance  = [[DecimalNumberTool alloc]init];
    });
    return instance;
}

- (NSDecimalNumber *)DecimalNumberWithfromStr:(NSString *)Str
{
    return [NSDecimalNumber decimalNumberWithString:Str];
}

- (NSString *)StrWithfromDecimalNumber:(NSDecimalNumber *)DecimalNumber
{
    return [NSString stringWithFormat:@"%@",DecimalNumber];
}


/**
 相加
 */
- (NSString *)SumWithStr1:(NSString *)str1 Str2:(NSString *)str2
{
    str1 = [self isEffectiveParam:str1];
    str2 = [self isEffectiveParam:str2];
    NSDecimalNumber *decimal1 = [self DecimalNumberWithfromStr:str1];
    NSDecimalNumber *decimal2 = [self DecimalNumberWithfromStr:str2];
    
    NSDecimalNumber *sumdecimal = [decimal1 decimalNumberByAdding:decimal2];
    return [self StrWithfromDecimalNumber:sumdecimal];
}

/**
 相减
 */
- (NSString *)SubtracWithStr1:(NSString *)str1 Str2:(NSString *)str2
{
    str1 = [self isEffectiveParam:str1];
    str2 = [self isEffectiveParam:str2];
    NSDecimalNumber *decimal1 = [self DecimalNumberWithfromStr:str1];
    NSDecimalNumber *decimal2 = [self DecimalNumberWithfromStr:str2];
    
    NSDecimalNumber *sumdecimal = [decimal1 decimalNumberBySubtracting:decimal2];
    return [self StrWithfromDecimalNumber:sumdecimal];
}

/**
 相乘
 */
- (NSString *)MultiplyWithStr1:(NSString *)str1 Str2:(NSString *)str2
{
    str1 = [self isEffectiveParam:str1];
    str2 = [self isEffectiveParam:str2];
    NSDecimalNumber *decimal1 = [self DecimalNumberWithfromStr:str1];
    NSDecimalNumber *decimal2 = [self DecimalNumberWithfromStr:str2];
    
    NSDecimalNumber *sumdecimal = [decimal1 decimalNumberByMultiplyingBy:decimal2];
    return [self StrWithfromDecimalNumber:sumdecimal];
}

/**
 相除
 */
- (NSString *)DividWithStr1:(NSString *)str1 Str2:(NSString *)str2
{
    str1 = [self isEffectiveParam:str1];
    str2 = [self isEffectiveParam:str2];
    NSDecimalNumber *decimal1 = [self DecimalNumberWithfromStr:str1];
    NSDecimalNumber *decimal2 = [self DecimalNumberWithfromStr:str2];
    
    NSDecimalNumber *sumdecimal = [decimal1 decimalNumberByDividingBy:decimal2];
    return [self StrWithfromDecimalNumber:sumdecimal];
}

/**
 检查参数 是否可用
 */
- (NSString *)isEffectiveParam:(NSString *)param
{
    if (param) {
        if (![param isKindOfClass:[NSString class]]) {
            param = [NSString stringWithFormat:@"%@",param];
        }
        if (![param isEqualToString:@""] &&
            ![param isEqualToString:@"(null)"] &&
            [param isKindOfClass:[NSString class]]) {
            return param;
        }
        return @"0";
    }
    return @"0";
}

@end
