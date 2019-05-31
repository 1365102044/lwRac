//
//  HYBaseNavigationController.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/5/18.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYBaseNavigationController.h"
#import "LWHud.h"
#import "HYMineViewController.h"
@interface HYBaseNavigationController ()<UINavigationControllerDelegate,UIGestureRecognizerDelegate>

@end

@implementation HYBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WEAKSELF(self);
    self.delegate = weakself;
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = weakself;
    }
    
    UINavigationBar *navigationBar                      = [UINavigationBar appearance];
    [navigationBar setTintColor:[UIColor whiteColor]];
    navigationBar.backgroundColor = HYCOLOR.color_c0;
    UIImage *image                                      = [UIImage imageNamed:@"public_back_n"];
    image                                               = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    navigationBar.backIndicatorImage                    = image;
    navigationBar.backIndicatorTransitionMaskImage      = image;

    /**
     解决iOS11崩溃问题 2018年12月05日16:13:14
     */
    if(@available(iOS 11, *)) {
        [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor clearColor]} forState:UIControlStateNormal];
        [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor clearColor]} forState:UIControlStateHighlighted];
    } else {
        //去掉返回按钮文字
        [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(-500, 0) forBarMetrics:UIBarMetricsDefault];
    }
    

}

- (void)navigationController:(UINavigationController *)navigationController
      willShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated
{
    UIViewController *root = navigationController.viewControllers[0];
    if (root != viewController) {
        viewController.hidesBottomBarWhenPushed = YES;
    }else{
        viewController.hidesBottomBarWhenPushed = NO;
    }
    
    BOOL isHiddenNaviBar = [viewController isKindOfClass:[HYMineViewController class]];
    [viewController.navigationController setNavigationBarHidden:isHiddenNaviBar animated:YES];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    [super pushViewController:viewController animated:animated];
}

- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated
{
    if ([navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//    });
    [LWHud dismiss];
}

/**
 1、底部Tabbar隐藏、显示调用频繁，或者重复调用
 2、右划返回手势冲突
 一级页面跳转到二级页面,Tabbar卡死
 */
-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer == self.interactivePopGestureRecognizer) {
        
        if (self.viewControllers.count < 2) {
            return NO;
        }
    }
    return YES;
}

@end
