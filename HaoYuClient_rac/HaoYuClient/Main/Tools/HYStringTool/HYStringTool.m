//
//  HYStringTool.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/5/18.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYStringTool.h"
#import <sys/utsname.h>
#import <sys/socket.h>

#import <sys/sockio.h>

#import <sys/ioctl.h>

#import <net/if.h>

#import <arpa/inet.h>

@implementation HYStringTool

+ (instancetype)share
{
    static dispatch_once_t onceToken;
    static HYStringTool *instance;
    dispatch_once(&onceToken, ^{
        instance = [[HYStringTool alloc]init];
    });
    return instance;
}

/**
 金额 逗号 分割(内部 分->元) 2位小数
 */
-(NSString*)strmethodCommaWith:(NSString *)price
{
    NSString *tempricestr;
    if (price==nil) return nil;
    if ([price isKindOfClass:[NSString class]]) {
        tempricestr = [NSString stringWithFormat:@"%.2f",[price doubleValue]/100];
    }else {
        tempricestr = [NSString stringWithFormat:@"%.2f",[[NSString stringWithFormat:@"%@",price] doubleValue]/100] ;
    }
    NSMutableString *pricestr = tempricestr.mutableCopy;
    NSRange range = [pricestr rangeOfString:@"."];
    NSInteger index = 0;
    if (range.length >0) {
        
        index = range.location;
    }else{
        
        index = pricestr.length;
    }
    while ((index-3) > 0) {
        index-=3;
        [pricestr insertString:@"," atIndex:index];
    }
    return pricestr;
}

/**
 金额 逗号 分割(内部 分->元) 没有小数
 */
-(NSString*)strmethodIntCommaWith:(NSString *)price
{
    NSString *tempricestr;
    if (price==nil) return nil;
    if ([price isKindOfClass:[NSString class]]) {
        tempricestr = [NSString stringWithFormat:@"%.0f",[price floatValue]];
    }else {
        tempricestr = [NSString stringWithFormat:@"%@",price];
    }
    NSMutableString *pricestr = tempricestr.mutableCopy;
    NSRange range = [pricestr rangeOfString:@"."];
    NSInteger index = 0;
    if (range.length >0) {
        
        index = range.location;
    }else{
        
        index = pricestr.length;
    }
    while ((index-3) > 0) {
        index-=3;
        [pricestr insertString:@"," atIndex:index];
    }
    return pricestr;
}

/**
 金额 逗号 分割(内部 元->元) 2位小数
 */
-(NSString*)strmethodYUANCommaWith:(NSString *)price
{
    NSString *tempricestr;
    if (price==nil) return nil;
    if ([price isKindOfClass:[NSString class]]) {
        tempricestr = [NSString stringWithFormat:@"%.2f",[price doubleValue]];
    }else {
        tempricestr = [NSString stringWithFormat:@"%@",price];
    }
    NSMutableString *pricestr = tempricestr.mutableCopy;
    NSRange range = [pricestr rangeOfString:@"."];
    NSInteger index = 0;
    if (range.length >0) {
        
        index = range.location;
    }else{
        
        index = pricestr.length;
    }
    while ((index-3) > 0) {
        index-=3;
        [pricestr insertString:@"," atIndex:index];
    }
    return pricestr;
}

/**
 打电话
 */
+(void)CallPhoneWith:(UIView*)backview phone:(NSString *)phone
{
    NSString *callPhone = [NSString stringWithFormat:@"telprompt://%@", phone];
    NSComparisonResult compare = [[UIDevice currentDevice].systemVersion compare:@"10.0"];
    if (compare == NSOrderedDescending || compare == NSOrderedSame) {
        /// 大于等于10.0系统使用此openURL方法
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone] options:@{} completionHandler:nil];
        } else {
            // Fallback on earlier versions
        }
    } else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone]];
    }
}


/**
 获取到的毫秒->需要到时间格式
 timestyle 时间格式 字符 @“yyyy-MM-dd hh:mm”
 */
- (NSString *)returnTimeStrformeTimestr:(NSString *)str timestyle:(NSString *)timestyle
{
    NSDate *timedate = [NSDate dateWithTimeIntervalSince1970:([str doubleValue] / 1000.0)];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateStyle:NSDateFormatterShortStyle];
    [formatter setTimeStyle:NSDateFormatterNoStyle];
    [formatter setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"]];
    [formatter setDateFormat:timestyle];
    NSString *time = [formatter stringFromDate:timedate];
    return time;
}

/**
 过滤 HTML标签
 */
-(NSString *)filterHTML:(NSString *)html
{
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        [scanner scanUpToString:@"<" intoString:nil];
        [scanner scanUpToString:@">" intoString:&text];
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    return html;
}

/**
 倒计时展示
 */
- (NSString *)getTimeStrWithDifftime:(NSString *)diffTime
{
    if ([diffTime integerValue] == 0) {
        return @"";
    }
    
    NSDate *now                 = [NSDate date];
    NSCalendar *calendar        = [NSCalendar currentCalendar];
    
    /**
     *  比较时间
     */
    NSCalendarUnit unit         = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitHour |
    NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *cmps      = [calendar components:unit
                                              fromDate:[NSDate dateWithTimeIntervalSinceNow:diffTime.doubleValue]
                                                toDate:now
                                               options:0];
    
    /**
     *  判断是否有天
     */
    if (cmps.day != 0) {
        return [NSString stringWithFormat:@"%02ld天%02ld时%02ld分",
                (long)diffTime.longLongValue/86400,
                (long)diffTime.longLongValue%86400/3600,
                (long)diffTime.longLongValue%3600/60];
    }else{
        
        /**
         *  判断是否有小时
         */
        if (cmps.hour != 0) {
            return [NSString stringWithFormat:@"%02ld时%02ld分",
                    (long)diffTime.longLongValue%86400/3600,
                    (long)diffTime.longLongValue%3600/60];
        }else{
            
            /**
             *  判断是否有分钟
             */
            if (cmps.minute != 0) {
                return [NSString stringWithFormat:@"%02ld分%02ld秒",
                        (long)diffTime.longLongValue%3600/60,
                        (long)diffTime.longLongValue%60];
            }else{
                return [NSString stringWithFormat:@"%02ld秒",
                        (long)diffTime.longLongValue%60];
            }
        }
    }
}

- (NSString*)iphoneType {
    
    //需要导入头文件：#import <sys/utsname.h>
    
    struct utsname systemInfo;
    
    uname(&systemInfo);
    
    NSString*platform = [NSString stringWithCString: systemInfo.machine encoding:NSASCIIStringEncoding];

    
    return platform;
    
}

//获取某个字符串或者汉字的首字母.

- (NSString *)firstCharactorWithString:(NSString *)string
{
    NSMutableString *str = [NSMutableString stringWithString:string];
    
    CFStringTransform((CFMutableStringRef) str, NULL, kCFStringTransformMandarinLatin, NO);
    
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformStripDiacritics, NO);
    
    NSString *pinYin = [str capitalizedString];
    
    return [pinYin substringToIndex:1];
    
}

/**
 检查字符串是否为空，空：返回@“”，
 */
+ (NSString *)checkString:(NSString *)str
{
    if (!str || str == nil) {
        return @"";
    }
    return  [str isNullToString];
}

+ (BOOL)isNull:(NSString *)str
{
    if (str == nil) {
        return YES;
    }
    return  [str isNull];
    return NO;
}

/**
 *  时间算法
 *  @param year  计算年=》加1年：1；减1年：-1
 *  @param month 计算月=》加1月：1；减1月：-1
 *  @param day   计算天=》加一周：7；减一周：-7
 *  @param date  要计算的时间
 *
 *  @return 计算好的时间
 */
- (NSDate *)datejishuangYear:(int)year Month:(int)month Day:(int)day withData:(NSDate *)date {
    if (!date) {
        return nil;
    }
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    //NSCalendarIdentifierGregorian:iOS8之前用NSGregorianCalendar
    NSDateComponents *comps = nil;
    
    comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date];
    //NSCalendarUnitYear:iOS8之前用NSYearCalendarUnit,NSCalendarUnitMonth,NSCalendarUnitDay同理
    
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    
    [adcomps setYear:year];
    
    [adcomps setMonth:month];
    
    [adcomps setDay:day];
    
    return [calendar dateByAddingComponents:adcomps toDate:date options:0];
}

/**
 *  修改 8小时差的date  (2018-07-30 14:13:43 +0000)
 */
+ (NSDate *)ex_getCurrentDate
{
    NSDate *date = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
    return localeDate;
}



#pragma mark---------getipadress
+(NSString *)getDeviceIPAddresses {
    
    int sockfd = socket(AF_INET, SOCK_DGRAM, 0);
    
    NSMutableArray *ips = [NSMutableArray array];
    
    int BUFFERSIZE = 4096;
    
    struct ifconf ifc;
    
    char buffer[BUFFERSIZE], *ptr, lastname[IFNAMSIZ], *cptr;
    
    struct ifreq *ifr, ifrcopy;
    
    ifc.ifc_len = BUFFERSIZE;
    
    ifc.ifc_buf = buffer;
    
    if (ioctl(sockfd, SIOCGIFCONF, &ifc) >= 0){
        
        for (ptr = buffer; ptr < buffer + ifc.ifc_len; ){
            
            ifr = (struct ifreq *)ptr;
            
            int len = sizeof(struct sockaddr);
            
            if (ifr->ifr_addr.sa_len > len) {
                
                len = ifr->ifr_addr.sa_len;
                
            }
            
            
            
            ptr += sizeof(ifr->ifr_name) + len;
            
            if (ifr->ifr_addr.sa_family != AF_INET) continue;
            
            if ((cptr = (char *)strchr(ifr->ifr_name, ':')) != NULL) *cptr = 0;
            
            if (strncmp(lastname, ifr->ifr_name, IFNAMSIZ) == 0) continue;
            
            
            
            memcpy(lastname, ifr->ifr_name, IFNAMSIZ);
            
            ifrcopy = *ifr;
            
            ioctl(sockfd, SIOCGIFFLAGS, &ifrcopy);
            
            if ((ifrcopy.ifr_flags & IFF_UP) == 0) continue;
            
            NSString *ip = [NSString  stringWithFormat:@"%s", inet_ntoa(((struct sockaddr_in *)&ifr->ifr_addr)->sin_addr)];
            
            [ips addObject:ip];
            
        }
        
    }
    
    　 close(sockfd);
    
    NSString *deviceIP = @"";
    
    for (int i=0; i < ips.count; i++) {
        
        if (ips.count > 0) {
            
            deviceIP = [NSString stringWithFormat:@"%@",ips.lastObject];
            
        }
        
    }
    
    return deviceIP;
}
/**
 是否超出长度
 */
+ (BOOL)lengthGreaterThanWith:(NSString *)Str limitLent:(NSInteger)limitLent
{
    if (Str) {
        return  Str.length > limitLent;
    }
    return NO;
}

@end
