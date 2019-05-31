//
//  HYBaseAlert.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/5/23.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYBaseAlert.h"

@implementation HYBaseAlert

#pragma mark - First.通知

#pragma mark - Second.赋值

#pragma mark - Third.点击事件

#pragma mark - Fourth.代理方法

#pragma mark - Fifth.视图生命周期

/**
 获取单利对象
 
 @return alert对象
 */
+ (instancetype)sharedAlert
{
    static id alertInstance                 = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        alertInstance                       = [[self alloc] initWithFrame:SCREEN_RECT];
    });
    return alertInstance;
}

#pragma mark - Sixth.界面配置

- (void)setupCustomUI
{
    
}

#pragma mark - Seventh.懒加载

#pragma mark - Eigth.Other

/**
 展示弹窗
 */
- (void)showAlert
{
    [self makeKeyWindow];
    self.hidden = NO;
}

/**
 隐藏Alert
 */
- (void)hiddenAlert
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self resignKeyWindow];
        self.hidden = YES;
    });
}

@end

