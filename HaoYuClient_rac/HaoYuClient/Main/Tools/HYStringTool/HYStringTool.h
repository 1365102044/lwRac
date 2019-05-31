//
//  HYStringTool.h
//  HaoYuClient
//
//  Created by 刘文强 on 2018/5/18.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYStringTool : NSObject

+ (instancetype)share;

/**
 金额 逗号 分割(内部 分->元) 2位小数
 */
-(NSString*)strmethodCommaWith:(NSString *)price;

/**
 金额 逗号 分割(内部 分->元) 没有小数
 */
-(NSString*)strmethodIntCommaWith:(NSString *)price;
/**
 金额 逗号 分割(内部 元->元) 2位小数
 */
-(NSString*)strmethodYUANCommaWith:(NSString *)price;

/**
 打电话
 */
+(void)CallPhoneWith:(UIView*)backview phone:(NSString *)phone;

/**
 获取到的毫秒->需要到时间格式
 timestyle 时间格式 字符 @“yyyy-MM-dd hh:mm”
 */
- (NSString *)returnTimeStrformeTimestr:(NSString *)str timestyle:(NSString *)timestyle;

/**
 过滤 HTML标签
 */
-(NSString *)filterHTML:(NSString *)html;

/**
 倒计时展示
 */
- (NSString *)getTimeStrWithDifftime:(NSString *)diffTime;

- (NSString*)iphoneType;

//获取某个字符串或者汉字的首字母.
- (NSString *)firstCharactorWithString:(NSString *)string;
/**
 检查字符串是否为空，空：返回@“”，
 */
+ (NSString *)checkString:(NSString *)str;

+ (BOOL)isNull:(NSString *)str;
/**
 *  时间算法
 *  @param year  计算年=》加1年：1；减1年：-1
 *  @param month 计算月=》加1月：1；减1月：-1
 *  @param day   计算天=》加一周：7；减一周：-7
 *  @param date  要计算的时间
 *
 *  @return 计算好的时间
 */
- (NSDate *)datejishuangYear:(int)year Month:(int)month Day:(int)day withData:(NSDate *)date;


/**
 *  修改 8小时差的date  (2018-07-30 14:13:43 +0000)
 */
+ (NSDate *)ex_getCurrentDate;

/**
 获取手机的IP
 */
+(NSString *)getDeviceIPAddresses;

/**
 是否超出长度
 */
+ (BOOL)lengthGreaterThanWith:(NSString *)Str limitLent:(NSInteger)limitLent;

@end
