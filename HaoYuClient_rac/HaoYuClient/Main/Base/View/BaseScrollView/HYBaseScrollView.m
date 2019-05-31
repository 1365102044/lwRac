//
//  HYBaseScrollView.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/5/23.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYBaseScrollView.h"

@implementation HYBaseScrollView

#pragma mark - First.通知

#pragma mark - Second.赋值

#pragma mark - Third.点击事件
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self endEditing:YES];
}

#pragma mark - Fourth.代理方法

#pragma mark - Fifth.视图生命周期

- (instancetype)init
{
    if (self = [super init]) {
        self.backgroundColor = HYCOLOR.color_c0;
    }
    return self;
}

#pragma mark - Sixth.界面配置

#pragma mark - Seventh.懒加载

@end
