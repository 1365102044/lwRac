//
//  LWJpush.h
//  HaoYuClient
//
//  Created by 刘文强 on 2018/10/23.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import <Foundation/Foundation.h>
// 引入 JPush 功能所需头文件
#import "JPUSHService.h"
// iOS10 注册 APNs 所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

@interface LWJpushManager : NSObject<JPUSHRegisterDelegate>
+ (instancetype)share;
/**
 初始化 APNs 代码 / 初始化 JPush 代码
 */
- (void)lw_registerJpushWithOptions:(NSDictionary *)launchOptions;
/**
 Required - 注册 DeviceToken
 */
- (void)lw_registerDeviceTokenFotJpushWithDeviceToken:(NSData *)deviceToken;
/**
 Optional - 注册推送失败
 */
- (void)lw_registerFailForRemoteNotificationsWithError:(NSError *)error;

@end
