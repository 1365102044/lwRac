//
//  CoustomSlider.m
//  SliderDemo
//
//  Created by 刘文强 on 2018/7/21.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "CoustomSlider.h"

@implementation CoustomSlider

- (CGRect)trackRectForBounds:(CGRect)bounds
{
    return CGRectMake(0, 0, CGRectGetWidth(self.frame), 10);
}

- (CGRect)maximumValueImageRectForBounds:(CGRect)bounds
{
    return CGRectMake(0, 0, CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)/2);
}

// 设置最小值
- (CGRect)minimumValueImageRectForBounds:(CGRect)bounds
{
    return CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
}

// 改变滑块的触摸范围
- (CGRect)thumbRectForBounds:(CGRect)bounds trackRect:(CGRect)rect value:(float)value
{
    rect.origin.x=rect.origin.x-10;
    rect.size.width=rect.size.width+20;
    return CGRectInset([super thumbRectForBounds:bounds trackRect:rect value:value], 10, 10);
}
@end
