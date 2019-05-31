//
//  HYADLaunchImageManager.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/5/23.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYADLaunchImageManager.h"
#import "HYADLaunchImageView.h"
#import "HYBaseNavigationController.h"
#import "HYBaseTabBarController.h"

@implementation HYADLaunchImageManager

+ (instancetype)share{
    static HYADLaunchImageManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[HYADLaunchImageManager alloc] init];
    });
    return instance;
}

/**
 加载网络图片
 */
- (void)loadURLADLaunchImage {
    
//    // Ad(广告) FadeAnimation
//    HYADLaunchImageView *adLaunchImageView = [[HYADLaunchImageView alloc]initWithImage:[UIImage ty_getLaunchImage]];
//    adLaunchImageView.URLString = @"http://img1.126.net/channel6/2015/020002/2.jpg?dpi=6401136";
//
//    // 显示imageView
//    [adLaunchImageView showInWindowWithAnimation:[TYLaunchFadeScaleAnimation fadeAnimationWithDelay:5.0] completion:^(BOOL finished) {
//
//        [[UIApplication sharedApplication] setStatusBarHidden:NO];
//        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
//        NSLog(@"finished");
//    }];
//
//    __typeof (self) __weak weakSelf = self;
//    // 点击广告block
//    [adLaunchImageView setClickedImageURLHandle:^(NSString *URLString) {
//        [[UIApplication sharedApplication] setStatusBarHidden:NO];
//        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
//        [weakSelf pushAdViewCntroller];
//        NSLog(@"clickedImageURLHandle");
//    }];

}

/**
 加载本地图片
 */
- (void)loadADLaunchImage
{
    HYADLaunchImageView *imageview = [[HYADLaunchImageView alloc]initWithFrame:SCREEN_RECT];
    [imageview setImage:[UIImage imageNamed:@"test_1"]];
    UIWindow * window = [UIApplication sharedApplication].delegate.window;
    [window addSubview:imageview];
    [window bringSubviewToFront:imageview];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:.5 animations:^{
            imageview.transform = CGAffineTransformMakeScale(1.5, 1.5);
            imageview.alpha = 0;
        } completion:^(BOOL finished) {
            [imageview removeFromSuperview];
        }];
    });
    
}

/**
 跳转到AD控制器
 */
- (void)pushAdViewCntroller
{
    // 获取到navVC
    UIWindow *window =  [UIApplication sharedApplication].keyWindow;
    HYBaseTabBarController *tabbBarVC = (HYBaseTabBarController *)window.rootViewController;
    HYBaseNavigationController * navVC = tabbBarVC.viewControllers.firstObject;
    
    // 你要推出的VC
    UIViewController *VC = [[UIViewController alloc]init];
    VC.view.backgroundColor = [UIColor redColor];
    [navVC pushViewController:VC animated:YES];
}

@end
