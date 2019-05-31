//
//  HYDefaultTextView.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/4.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYPlaceHolderTextView.h"
@interface HYPlaceHolderTextView()

@end
@implementation HYPlaceHolderTextView

+ (instancetype)creatPlaceHolderTextViewWithPlaceHolder:(NSString *)placeholder
{
    HYPlaceHolderTextView *instance = [[HYPlaceHolderTextView alloc] init];
    [instance setUI];
    instance.placeHolderLable.text = placeholder;
    return instance;
}

- (void)setUI
{
    [super setUI];
}



@end
