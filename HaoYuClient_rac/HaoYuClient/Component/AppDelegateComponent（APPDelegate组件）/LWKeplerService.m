//
//  LWKeplerService.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/11/5.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "LWKeplerService.h"
#import "HYKeplerManager.h"

@implementation LWKeplerService

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    [HYKeplerManager asyncInitSdk:KEPLER_APP_KEY
                        secretKey:KEPLER_APP_SECRET
                   sucessCallback:^{
                       LWLog(@"+++++++++kepler注册成功！");
                   } failedCallback:^(id sender) {
                       LWLog(@"+++++++++kepler注册失败！error:%@",sender);
                   }];
    [HYKeplerManager setIsOpenByH5:YES];
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    if([url.absoluteString containsString:[NSString stringWithFormat:@"sdkback%@",KEPLER_APP_KEY]])
    {
        [HYKeplerManager handleOpenURL:url];
    }
    return YES;
}

// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    if([url.absoluteString containsString:[NSString stringWithFormat:@"sdkback%@",KEPLER_APP_KEY]])
    {
        [HYKeplerManager handleOpenURL:url];
    }
    return YES;
}

- (void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    BOOL haveJDKeplerServiceNewContent = NO;
    [self fetchJDKeplerService:&haveJDKeplerServiceNewContent];
    if (haveJDKeplerServiceNewContent){
        completionHandler(UIBackgroundFetchResultNewData);
    } else {
        completionHandler(UIBackgroundFetchResultNoData);
    }
}

//（可选）
- (void)fetchJDKeplerService:(BOOL *)paramFetchedJDKeplerNewContent {
    [[KeplerApiManager sharedKPService] checkUpdate]; //检测更新
}
@end
