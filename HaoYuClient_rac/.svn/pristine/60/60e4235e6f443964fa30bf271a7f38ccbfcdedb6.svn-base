//
//  HYKeplerManager.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/10/16.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYKeplerManager.h"

@implementation HYKeplerManager

/**
 *  注册Kepler 服务
 *
 *  @param appKey      注册的appKey
 *  @param appSecret   注册的secretKey
 */
+ (void)asyncInitSdk:(NSString *)appKey
           secretKey:(NSString *)appSecret
      sucessCallback:(initSuccessCallback)sucessCallback
      failedCallback:(initFailedCallback)failedCallback
{
    [[KeplerApiManager sharedKPService] asyncInitSdk:appKey
                                           secretKey:appSecret
                                      sucessCallback:sucessCallback
                                      failedCallback:failedCallback];
}

/**
 *  Kepler处理URL
 *
 *  @param url url
 *
 *  @return 处理结果
 */
+ (BOOL)handleOpenURL:(NSURL*)url
{
    BOOL status = [[KeplerApiManager sharedKPService] handleOpenURL:url];
    //检查登录状态，
//    [[KeplerApiManager sharedKPService] keplerLoginWithSuccess:^{
//
//    } failure:^{
//        ALERT(@"登录授权发生未知错误，请稍后重试！");
//    }];
   return status;
}

/**
 *  打开导航页
 */
+ (void)openNavigationPage:(UIViewController *)sourceController
                  jumpType:(NSInteger)jumpType
              customParams:(NSString *)customParams
{
    [[KeplerApiManager sharedKPService] openNavigationPage:sourceController
                                                  jumpType:jumpType
                                              customParams:customParams];
}

+ (void)setIsOpenByH5:(BOOL)isOpenByH5
{
    [KeplerApiManager sharedKPService].isOpenByH5 = isOpenByH5;
}

/**
 *  通过URL打开Kepler页面
 *
 *  @param url              页面url
 *  @param sourceController 当前显示的UIViewController
 *  @param jumpType         跳转类型(默认 push) 1代表present 2代表push
 *  @param customParams     自定义订单统计参数 不需要可以传nil
 */
+ (void)openKeplerPageWithURL:(NSString *)url sourceController:(UIViewController *)sourceController jumpType:(NSInteger)jumpType customParams:(NSString *)customParams
{
    [KeplerApiManager.sharedKPService openKeplerPageWithURL:url sourceController:sourceController jumpType:jumpType customParams:customParams];
}

@end
