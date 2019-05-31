//
//  RemotePushService.h
//  HaoYuClient
//
//  Created by 刘文强 on 2018/11/5.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "LWAppDelegateComponentBaseService.h"
// 引入 JPush 功能所需头文件
//#import "JPUSHService.h"
// iOS10 注册 APNs 所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
#import "XGPush.h"
@interface LWRemotePushService : NSObject<UIApplicationDelegate,XGPushDelegate>

@end