//
//  UITabBar+badge.h
//  inborn
//
//  Created by YX on 2017/8/4.
//  Copyright © 2017年 inborn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (badge)
- (void)showBadgeOnItemIndex:(int)index;   //显示小红点

- (void)hideBadgeOnItemIndex:(int)index; //隐藏小红点
@end
