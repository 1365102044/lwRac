//
//  HYBorderLongButton.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/5/22.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYBorderLongButton.h"

@implementation HYBorderLongButton
/**
 初始化按钮3（规范）- 边框按钮
 
 @param titleStringKey                      titleStringKey
 @param target                              target
 @param selector                            selector
 @return                                    按钮3（规范）- 边框按钮
 */
+ (instancetype)buttonWithTitleStringKey:(NSString *)titleStringKey
                              titleColor:(UIColor *)titleColor
                             borderColor:(UIColor *)borderColor
                               backColor:(UIColor *)backColor
                                  target:(id)target
                                selector:(SEL)selector
{
    HYBorderLongButton *button = [[HYBorderLongButton alloc] init];
    [button setTitle:titleStringKey forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = backColor;
    button.layer.cornerRadius = ADJUST_PERCENT_FLOAT(4.f);
    button.layer.masksToBounds = YES;
    button.layer.borderColor = borderColor.CGColor;
    button.layer.borderWidth = 1;
    return button;
}

@end
