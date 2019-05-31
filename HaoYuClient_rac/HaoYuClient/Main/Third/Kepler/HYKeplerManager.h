//
//  HYKeplerManager.h
//  HaoYuClient
//
//  Created by 刘文强 on 2018/10/16.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JDKeplerSDK/JDKeplerSDK.h>
/** 初始化成功回调 */
typedef void (^initSuccessCallback)();
/** 初始化失败回调 */
typedef void (^initFailedCallback)(NSError *error);

@interface HYKeplerManager : NSObject
/**
 *  注册Kepler 服务
 *
 *  @param appKey      注册的appKey
 *  @param appSecret   注册的secretKey
 */
+ (void)asyncInitSdk:(NSString *)appKey
           secretKey:(NSString *)appSecret
      sucessCallback:(initSuccessCallback)sucessCallback
      failedCallback:(initFailedCallback)failedCallback;

/**
 *  Kepler处理URL
 *
 *  @param url url
 *
 *  @return 处理结果
 */
+ (BOOL)handleOpenURL:(NSURL*)url;

/**
 是否强制使用H5打开界面 设置为YES时，打开链接时不会跳转到JD APP
 */
+ (void)setIsOpenByH5:(BOOL)isOpenByH5;

/**
 *  打开导航页
 */
+ (void)openNavigationPage:(UIViewController *)sourceController
                  jumpType:(NSInteger)jumpType
              customParams:(NSString *)customParams;

/**
 *  通过URL打开Kepler页面
 *
 *  @param url              页面url
 *  @param sourceController 当前显示的UIViewController
 *  @param jumpType         跳转类型(默认 push) 1代表present 2代表push
 *  @param customParams     自定义订单统计参数 不需要可以传nil
 */
+ (void)openKeplerPageWithURL:(NSString *)url sourceController:(UIViewController *)sourceController jumpType:(NSInteger)jumpType customParams:(NSString *)customParams;

@end
