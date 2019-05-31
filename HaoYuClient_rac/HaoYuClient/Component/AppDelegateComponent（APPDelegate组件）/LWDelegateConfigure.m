//
//  LWDelegateConfigure.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/11/5.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "LWDelegateConfigure.h"
#import "HYThirdManager.h"
#import "HYBaseTabBarController.h"
#import "YBNewVersionFeaturesViewController.h"
#import "HYRequstGlobalDataTool.h"
@implementation LWDelegateConfigure

+ (void)configureWithLaunchOptions:(NSDictionary *)launchOptions
{
    if (@available(iOS 11.0, *)){
        UITableView.appearance.estimatedRowHeight = 0;
        UITableView.appearance.estimatedSectionFooterHeight = 0;
        UITableView.appearance.estimatedSectionHeaderHeight = 0;
    }
    [HYThirdManager registerThird:launchOptions];
    [[LWDelegateConfigure new] loadRootViewController];
    
}

/**
 *  加载根控制器
 */
- (void)loadRootViewController {
    
    UIWindow * window                                     = [[UIWindow alloc] initWithFrame:SCREEN_RECT];
    HYBaseTabBarController *tabBarController    = [[HYBaseTabBarController alloc] init];
    if ([[HYPublic_LocalData share] isFristInstall]) {
        [window setRootViewController:[[YBNewVersionFeaturesViewController alloc]init]];
    }else{
        [window setRootViewController:tabBarController];
    }
    [window makeKeyAndVisible];
    [[UIApplication sharedApplication] delegate].window = window;
    
    [self handleGlogbalDatas];
}

/**
 删除全局数据
 */
- (void)handleGlogbalDatas
{
    [[HYPublic_LocalData share] deleGlobalDatas];
    HYRequstGlobalDataTool *tool = [[HYRequstGlobalDataTool alloc] init];
    [tool requestCityData];
    
    
    /**
     修改本地优惠券状态
     */
    
    NSString *coupon_key = [NSString stringWithFormat:@"%@_coupon",USERDEFAULTS_GET(USER_INFOR_USERID)];
    NSArray *usecoupons = (NSArray *)USERDEFAULTS_GET(coupon_key);
    if (usecoupons && [usecoupons isKindOfClass:[NSArray class]] && usecoupons.count > 0) {
        PARA_CREART;
        PARA_SET(usecoupons, @"ids");
        LWLog(@"********修改优惠券状态的参数para:%@",para);
        [[HYServiceManager share] postRequestAnWithurl:UPDATE_COUPON_USESTATUS_URL paramters:para successBlock:^(id objc, id requestInfo) {
            LWLog(@"***********更新优惠券状态成功 %@",objc);
            
            USERDEFAULTS_RE(coupon_key);
        } failureBlock:^(id error, id requestInfo) {
           
            LWLog(@"***********更新优惠券状态失败 %@",error);
        }];
    }
}

@end
