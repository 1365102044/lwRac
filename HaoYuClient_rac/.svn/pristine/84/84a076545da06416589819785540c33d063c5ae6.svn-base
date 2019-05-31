//
//  HYVerticalButton.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/5/24.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYVerticalButton.h"

@implementation HYVerticalButton


/**
 初始化图片及文字的按钮VerticalButton
 
 @param titleStringKey                      titleStringKey
 @param type                                图片种类类型
 @param target                              target
 @param selector                            selector
 @return                                    返回黑底按钮
 */
+ (instancetype)buttonImageAndTitleWithTitleStringKey:(NSString *)titleStringKey
                                           titleColor:(UIColor *)titleColor
                                            titleFont:(UIFont *)titleFont
                                           imageNamed:(NSString *)imageNamed
                                                 type:(HYProjectButtonSetImageType)type
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
    return type == HYProjectButtonSetImage ? [super buttonWithTitleStringKey:titleStringKey
                                                                  titleColor:titleColor
                                                                   titleFont:titleFont
                                                                    imageNor:nor
                                                                    imageDis:dis
                                                                    imageHig:hig
                                                                      target:target
                                                                    selector:selector] :
    [super buttonWithTitleStringKey:titleStringKey
                         titleColor:titleColor
                          titleFont:titleFont
                 backgroundImageNor:nor
                 backgroundImageDis:dis
                 backgroundImageHig:hig
                             target:target
                           selector:selector];
}

- (void)setup
{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setup];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 调整图片
    self.imageView.ex_x = self.width * 0.5 - self.imageView.width * 0.5;
    self.imageView.ex_y = 0;
    self.imageView.width = self.imageView.size.width;
    self.imageView.height = self.imageView.size.height;
    
    // 调整文字
    self.titleLabel.ex_x = 0;
    self.titleLabel.ex_y = self.imageView.height;
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.titleLabel.ex_y;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

/**
 创建默认的verticalbtn 样式
 */
+ (instancetype)buttonVerImageAndTitleWithTitle:(NSString *)titleStr
                                     imageNamed:(NSString *)imageNamed
                                         target:(id)target
                                       selector:(SEL)selector
{
    return  [HYVerticalButton buttonImageAndTitleWithTitleStringKey:titleStr
                                                 titleColor:HYCOLOR.color_c4
                                                  titleFont:SYSTEM_REGULARFONT(12)
                                                 imageNamed:imageNamed
                                                       type:(HYProjectButtonSetImage)
                                                     target:target
                                                   selector:selector];
}

@end
