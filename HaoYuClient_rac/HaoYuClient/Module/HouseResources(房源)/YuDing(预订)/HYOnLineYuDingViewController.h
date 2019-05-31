//
//  HYOnLineYuDingViewController.h
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/14.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYBaseViewController.h"

@interface HYOnLineYuDingViewController : HYBaseViewController
/**
 先判断是否登录 在选择跳转
 */
+ (void)onLineYuDingViewControllerFrom:(UIViewController *)sourceVc Extend:(id)extend;

@end
