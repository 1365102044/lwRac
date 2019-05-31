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
}

@end
