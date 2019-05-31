//
//  HYFillLongButton.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/5/22.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYFillLongButton.h"

@implementation HYFillLongButton

- (void)awakeFromNib
{
    [super awakeFromNib];

    [self setBackgroundImage:[UIImage imageWithColor:HYCOLOR.color_c3]
                          forState:UIControlStateNormal];
    [self setBackgroundImage:[UIImage imageWithColor:HYCOLOR.color_c3]
                          forState:UIControlStateHighlighted];
    [self setBackgroundImage:[UIImage imageWithColor:HYCOLOR.color_c3]
                          forState:UIControlStateSelected];
    [self setBackgroundImage:[UIImage imageWithColor:[UIColor lightGrayColor]]
                          forState:UIControlStateDisabled];
//    [self sizeToFit];
}
/**
 初始化按钮1（规范）- 填充带禁用长按钮
 
 @param titleStringKey                      titleStringKey
 @param target                              target
 @param selector                            selector
 @return                                    按钮1（规范）- 填充带禁用长按钮
 */
+ (instancetype)buttonCorWithTitleStringKey:(NSString *)titleStringKey
                                  target:(id)target
                                selector:(SEL)selector
{
    
    HYFillLongButton *button = [HYFillLongButton buttonNorWithTitleStringKey:titleStringKey
                                                               target:target
                                                             selector:selector];
    button.layer.cornerRadius = ADJUST_PERCENT_FLOAT(4.f);
    button.layer.masksToBounds = YES;
    return (HYFillLongButton *)button;
}

/**
 初始化按钮1（规范）- 填充带禁用长按钮--  没有切角
 
 @param titleStringKey                      titleStringKey
 @param target                              target
 @param selector                            selector
 @return                                    按钮1（规范）- 填充带禁用长按钮
 */
+(instancetype)buttonNorWithTitleStringKey:(NSString *)titleStringKey
                                    target:(id)target
                                  selector:(SEL)selector
{
    HYBaseButton *button = [super buttonWithTitleStringKey:titleStringKey
                                                titleColor:HYCOLOR.color_c0
                                                 titleFont:SYSTEM_MEDIUMFONT(14.f)
                                        backgroundImageNor:[UIImage imageWithColor:HYCOLOR.color_c3]
                                        backgroundImageDis:[UIImage imageWithColor:[UIColor lightGrayColor]]
                                        backgroundImageHig:[UIImage imageWithColor:HYCOLOR.color_c3]
                                                    target:target
                                                  selector:selector];
    return (HYFillLongButton *)button;
}
@end
