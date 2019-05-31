//
//  LWPayMentService.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/11/5.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "LWPayMentService.h"
#import "WXApi.h"
#import "HYPayMentManager.h"
#import <AlipaySDK/AlipaySDK.h>

@implementation LWPayMentService

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"支付结果result = %@",resultDic);
            POST_NOTI(@"getAlipayResultNotiName", resultDic);
        }];
        
        // 授权跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            //解析 auth code
            NSString *result = resultDic[@"result"];
            NSString *authCode = nil;
            if (result.length>0) {
                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                for (NSString *subResult in resultArr) {
                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                        authCode = [subResult substringFromIndex:10];
                        break;
                    }
                }
            }
            POST_NOTI(@"getAlipayResultNotiName", resultDic);
            NSLog(@"授权结果 authCode = %@", authCode?:@"");
        }];
        
    }else if ([url.host isEqualToString:@"pay"]) {
        // 处理微信的支付结果
        [WXApi handleOpenURL:url delegate:[HYPayMentManager shareManager]];
    }
    return YES;
}

// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"支付结果result = %@",resultDic);
            POST_NOTI(@"getAlipayResultNotiName", resultDic);
        }];
        
        // 授权跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            // 解析 auth code
            NSString *result = resultDic[@"result"];
            NSString *authCode = nil;
            if (result.length>0) {
                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                for (NSString *subResult in resultArr) {
                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                        authCode = [subResult substringFromIndex:10];
                        break;
                    }
                }
            }
            POST_NOTI(@"getAlipayResultNotiName", resultDic);
            NSLog(@"授权结果 authCode = %@", authCode?:@"");
        }];
    }else if ([url.host isEqualToString:@"pay"]) {
        // 处理微信的支付结果
        [WXApi handleOpenURL:url delegate:[HYPayMentManager shareManager]];
    }
    return YES;
}

@end
