//
//  NSString+Extension.h
//  Project
//
//  Created by 郑键 on 17/1/11.
//  Copyright © 2017年 zhengjian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)

/**
 *  比率字符串转换
 *
 *  @return 返回带%字符串 例如：0.1 -> 10%
 */
- (NSString *)ex_ratio;

/**
 *  Escape加密
 *
 *  @return 加密后字符串
 */
- (NSString *)ex_escapeEncode;

/**
 *  Escape解密
 *
 *  @return 解密后字符串
 */
- (NSString *)ex_escapeDecode;

#pragma mark - RSA

///**
// *  RSA MD5 验签
// *
// *  @param string          原串
// *  @param signString      签名串
// *  @return                返回验签结果
// */
//+ (BOOL)verifyMD5String:(NSString *)string withSign:(NSString *)signString;
//
///**
// *  RSA sha1 验签
// *
// *  @param string          原串
// *  @param signString      签名串
// *  @return                返回验签结果
// */
//+ (BOOL)verifySha1String:(NSString *)string withSign:(NSString *)signString;

#pragma mark - Base64Extension

/**
 *  base64编码
 *
 *  @return                 编码后的字符串
 */
- (NSString *)ex_base64Encode;

/**
 *  base64解码
 *
 *  @return                 解码后的字符串
 */
- (NSString *)ex_base64Decode;

#pragma mark - Extension

/**
 *  验证邮箱
 *
 *  @return                 YES or NO
 */
- (BOOL)ex_isEmail;

/**
 *  昵称
 *
 *  @return YES or NO
 */
- (BOOL)ex_isNickName;

/**
 *  验证密码
 *
 *  @return                 YES or NO
 */
- (BOOL)ex_isPassword;

/**
 *  验证数字
 *
 *  @return                 YES or NO
 */
- (BOOL)ex_isRealNumbers;

/**
 *  验证手机号码
 *
 *  @return                 YES or NO
 */
- (BOOL)ex_isMobileNumber;

/**
 *  控制输入不含特殊符号(能够输入汉字、字母、数字)
 *
 *  @return                 YES or NO
 */
- (BOOL)ex_isTrueStr;

/**
 *  验证身份证号
 *
 *  @return                 YES or NO
 */
- (BOOL)ex_validateIdentityCard;

#pragma mark - string

/**
 *  是否包涵子字符串
 *
 *  @param                  subString 传入的字符串
 *
 *  @return                 YES or NO
 */
- (BOOL)ex_isContainSubString:(NSString *)subString;

/**
 *  是否为空
 *
 *  @return YES 空 NO 非空
 */
- (BOOL)ex_isEmpty;

#pragma mark - Hash Md5

/**
 *  md5
 *
 *  @return                 md5后的字符串
 */
- (NSString *)ex_md5String;

/**
 *  sha1
 *
 *  @return                 sha1后的字符串
 */
- (NSString *)ex_sha1String;

/**
 *  sha256
 *
 *  @return                 sha256后的字符串
 */
- (NSString *)ex_sha256String;

/**
 *  sha512
 *
 *  @return                 sha512后的字符串
 */
- (NSString *)ex_sha512String;
/**
 *  验证URL
 *
 *  @return YES or NO
 */
- (BOOL)ex_isUrlStr;

#pragma mark - ToolMethod

/**
 *  计算富文本字体高度
 *
 *  @param lineSpace        行间距
 *  @param font             字体
 *  @param width            字体所占宽度
 *
 *  @return                 富文本高度
 */
-(CGFloat)ex_getSpaceLabelHeightwithSpeace:(CGFloat)lineSpace
                                  withFont:(UIFont*)font
                                 withWidth:(CGFloat)width;

/**
 *  计算label的尺寸
 *
 *  @param label            label
 *
 *  @return                 文字所占的尺寸
 */
+ (CGSize)ex_sizeWithLabel:(UILabel *)label;

/**
 *  文字的内容、字体大小 计算文字所占的尺寸
 *
 *  @param text             文字内容
 *  @param font             文字字体
 *
 *  @return                 文字所占的尺寸
 */
+ (CGSize)ex_sizeWithText:(NSString *)text
                  andFont:(UIFont *)font;

/**
 *  根据文字的内容、字体大小、最大尺寸范围 计算文字所占的尺寸
 *
 *  @param text             文字内容
 *  @param font             文字字体
 *  @param maxSize          最大尺寸范围
 *
 *  @return                 文字所占的尺寸
 */
+ (CGSize)ex_sizeWithText:(NSString *)text
                  andFont:(UIFont *)font
               andMaxSize:(CGSize)maxSize;

/**
 *  将字典、数组 转换为json字符串
 *
 *  @param object           字典、数组
 *
 *  @return                 转换为json字符串
 */
+ (NSString *)ex_jsonStringWithObject:(id)object;

/**
 *  json字典转
 *
 *  @return 字典
 */
- (NSDictionary *)ex_dictionaryToJsonString;

/**
 *  字符串替换
 *
 *  @param stringToBeChanged     要替换的字符串
 *  @param stringToBeChangedWith 替换字符串
 *  @param oldStr                原始字符串
 *
 *  @return 替换后的字符串
 */
+ (NSString *)ex_replaceOldStr:(NSString *)stringToBeChanged
                       withStr:(NSString *)stringToBeChangedWith
                    withString:(NSString *)oldStr;
/**
 计算文件大小
 */
- (long long)fileSize;

/**
 *  替换为标准html
 *
 *  @return return value
 */
- (NSString *)ex_htmlEntityDecode;

/**
 暗文替换
 
 @param replaceString           replaceString
 @param startLocation           startLocation
 @param lenght                  lenght
 @return return
 */
- (NSString *)ex_replaceStringWithReplaceString:(NSString *)replaceString
                                  startLocation:(NSInteger)startLocation
                                         lenght:(NSInteger)lenght;

+(NSString *)getUrlStringFromString:(NSString *)urlStr;

/**
 添加空格
 */
-(NSString *)formatterBankCardNum;

/**
 字符判空 空:@""
 */
- (NSString *)isNullToString;

/**
 是否 为空 BOOL
 */
- (BOOL)isNull;


/**
 四舍五入

 @param str 原字符串
 @param scale 保留小数后的位数
 @return 四舍五入
 */
- (NSString *)ex_roundfWithScale:(NSInteger)scale;

@end
