//
//  HYDefaultTextField.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/8.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYDefaultTextField.h"

@implementation HYDefaultTextField

+ (instancetype)creatDefaultTextField:(NSString *)placeHolder font:(UIFont *)font textColor:(UIColor *)textColor
{
    HYDefaultTextField *instance = [[HYDefaultTextField alloc] init];
    [instance setUI];
    instance.textFiled.placeholder = placeHolder;
    instance.textFiled.font         = font;
    instance.textFiled.textColor    = textColor;
    return instance;
}

- (void)setUI
{
    [super setUI];
}
@end
