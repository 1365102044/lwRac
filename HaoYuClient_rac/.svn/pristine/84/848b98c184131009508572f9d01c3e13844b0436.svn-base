//
//  LWJpush.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/10/23.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "LWJpushManager.h"
/**
 *  是否是线上环境
 */
#ifdef DEBUG
BOOL isProduction = NO;
#else
BOOL isProduction = YES;
#endif

@implementation LWJpushManager

+ (instancetype)share
{
    static LWJpushManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[LWJpushManager alloc] init];
    });
    return instance;
}

/**
 初始化 APNs 代码 / 初始化 JPush 代码
 */
- (void)lw_registerJpushWithOptions:(NSDictionary *)launchOptions
{
    /**
     初始化 APNs 代码
     */
    //notice: 3.0.0 及以后版本注册可以这样写，也可以继续用之前的注册方式
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert | JPAuthorizationOptionBadge | JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义 categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    /**
     初始化 JPush 代码
     */
    // Required
    // init Push
    [JPUSHService setupWithOption:launchOptions
                           appKey:STYTEM_THIRD_JUPSH_APPKEY
                          channel:STYTEM_THIRD_JUPSH_CHANNEL
                 apsForProduction:isProduction
            advertisingIdentifier:nil];
    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
        if (resCode==0) {
            LWLog(@"*******获取registrationID成功    %@", registrationID);
        }else{
            LWLog(@"*******获取registrationID失败");
        }
    }];
}

/**
  Required - 注册 DeviceToken
 */
- (void)lw_registerDeviceTokenFotJpushWithDeviceToken:(NSData *)deviceToken {
    [JPUSHService registerDeviceToken:deviceToken];
}

/**
 Optional - 注册推送失败
 */
- (void)lw_registerFailForRemoteNotificationsWithError:(NSError *)error {
    LWLog(@"*******did Fail To Register For Remote Notifications With Error: %@", error);
}

#pragma mark- JPUSHRegisterDelegate

// iOS 12 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center openSettingsForNotification:(UNNotification *)notification{
    if (notification && [notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //从通知界面直接进入应用
    }else{
        //从通知设置界面进入应用
    }
    [JPUSHService resetBadge];
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        [JPUSHService resetBadge];
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有 Badge、Sound、Alert 三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        [JPUSHService resetBadge];
    }
    completionHandler();  // 系统要求执行这个方法
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    [JPUSHService resetBadge];
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required, For systems with less than or equal to iOS 6
    [JPUSHService handleRemoteNotification:userInfo];
}

@end
