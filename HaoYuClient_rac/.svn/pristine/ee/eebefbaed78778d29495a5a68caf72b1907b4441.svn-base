//
//  HYThirdManager.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/5/22.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYThirdManager.h"
#import "WXApi.h"
#import <Bugly/Bugly.h>
#import "HYKeplerManager.h"
@interface HYThirdManager()
@property (nonatomic, strong) NSDictionary * launchOptions;

@end
@implementation HYThirdManager
#pragma mark - 注册第三方工具

/**
 *  注册第三方工具
 *
 *  @param launchOptions 启动参数
 */
+ (void)registerThird:(NSDictionary *)launchOptions
{
    HYThirdManager *manager                             = [HYThirdManager new];
    manager.launchOptions                               = launchOptions;
    [manager registerBugly];
    [manager initLocationManger];
}

- (void)initLocationManger
{
    BMKMapManager *mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [mapManager start:APP_KEY_BAIDUMAP_LOCATION_KEY  generalDelegate:nil];
    if (!ret) {
        NSLog(@"baidu_map_manager start failed!");
    }else{
        //        [self initLocation];
    }
}

/**
 Bugly
 */
- (void)registerBugly
{
    BuglyConfig *config = [BuglyConfig new];
    config.debugMode = YES;
    config.blockMonitorEnable = YES;
    config.blockMonitorTimeout = 2.0;
    NSString *channel = @"";
    #ifdef DEGBUG
    channel = @"developer";
    #else
    channel = @"AppStore";
    #endif
    config.channel = channel;
    config.deviceIdentifier =  Bugly.buglyDeviceId;
    config.version = APPVERSION;
    
    [Bugly startWithAppId:BUGLY_APP_ID
#ifdef DEBUG
     developmentDevice:YES
#endif
     config:config];
}

@end
