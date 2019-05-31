//
//  HYDefaultLabel.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/5/22.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYDefaultLabel.h"

@implementation HYDefaultLabel

+ (instancetype)labelWithFont:(UIFont *)font
                         text:(NSString *)text
                    textColor:(UIColor *)textColor
{
    NSString *string            = text;
    HYDefaultLabel *label       = [super labelWithFont:font
                                                  text:string
                                             textColor:textColor];
    label.backgroundColor       = HYCOLOR.color_c0;
    return label;
}

@end
