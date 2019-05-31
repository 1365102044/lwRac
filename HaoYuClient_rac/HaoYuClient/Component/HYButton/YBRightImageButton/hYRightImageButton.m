//
//  YBRightImageButton.m
//  inborn
//
//  Created by 郑键 on 17/3/21.
//  Copyright © 2017年 inborn. All rights reserved.
//

#import "HYRightImageButton.h"

@implementation HYRightImageButton

#pragma mark - First.通知

#pragma mark - Second.赋值

#pragma mark - Third.点击事件

#pragma mark - Fourth.代理方法

#pragma mark - Fifth.视图生命周期

/**
 初始化图片及文字的按钮
 
 @param titleStringKey                      titleStringKey
 @param target                              target
 @param selector                            selector
 @return                                    图片在右侧的按钮
 */
+ (instancetype)buttonImageAndTitleWithTitleStringKey:(NSString *)titleStringKey
                                        titleColorNor:(UIColor *)titleColorNor
                                        titleColorSel:(UIColor *)titleColorSel
                                        titleColorDis:(UIColor *)titleColorDis
                                            titleFont:(UIFont *)titleFont
                                           imageNamed:(NSString *)imageNamed
                                               target:(id)target
                                             selector:(SEL)selector
{
   
    UIImage *de = [UIImage imageNamed:imageNamed];
    UIImage *nor = [UIImage imageNamed:[NSString stringWithFormat:@"%@_n",imageNamed]];
    UIImage *dis = [UIImage imageNamed:[NSString stringWithFormat:@"%@_d",imageNamed]];
    UIImage *hig = [UIImage imageNamed:[NSString stringWithFormat:@"%@_h",imageNamed]];
    nor = nor ? nor : de;
    dis =  dis ? dis : nor;
    hig = hig ? hig : nor;
    HYRightImageButton *button              = [[HYRightImageButton alloc] init];
    [button setTitle:(titleStringKey)
            forState:UIControlStateNormal];
    [button setImage:nor
            forState:UIControlStateNormal];
    [button setImage:hig
            forState:UIControlStateSelected];
    [button setImage:dis
            forState:UIControlStateDisabled];
    [button setTitleColor:titleColorNor
                 forState:UIControlStateNormal];
    [button setTitleColor:titleColorSel
                 forState:UIControlStateSelected];
    [button setTitleColor:titleColorSel
                 forState:UIControlStateDisabled];
    button.titleLabel.font                  = titleFont;
    [button addTarget:target
               action:selector
     forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

/**
 布局子控件
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self setTitleEdgeInsets:UIEdgeInsetsMake(0,
                                              -self.imageView.size.width,
                                              0,
                                              self.imageView.size.width)];
    [self setImageEdgeInsets:UIEdgeInsetsMake(0,
                                              self.titleLabel.bounds.size.width,
                                              0,
                                              -self.titleLabel.bounds.size.width)];
}

#pragma mark - Sixth.界面配置

#pragma mark - Seventh.懒加载

@end
