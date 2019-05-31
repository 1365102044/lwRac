//
//  HYDefaultButton.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/5/22.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYDefaultButton.h"

@implementation HYDefaultButton

/**
 初始化文字按钮
 
 @param titleStringKey                      titleStringKey
 @param target                              target
 @param selector                            selector
 @return                                    返回黑底按钮
 */
+ (instancetype)buttonWithTitleStringKey:(NSString *)titleStringKey
                              titleColor:(UIColor *)titleColor
                               titleFont:(UIFont *)titleFont
                                  target:(id)target
                                selector:(SEL)selector
{
    return [super buttonWithTitleStringKey:titleStringKey
                                titleColor:titleColor
                                 titleFont:titleFont
                        backgroundImageNor:nil
                        backgroundImageDis:nil
                        backgroundImageHig:nil
                                    target:target
                                  selector:selector];
}

/**
 初始化图片及文字的按钮
 
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

/**
 初始化图片的按钮
 
 @parma imageNamed
 @param type                                图片种类类型
 @param target                              target
 @param selector                            selector
 @return                                    返回黑底按钮
 */
+ (instancetype)buttonImageWithImageNamed:(NSString *)imageNamed
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
    return type == HYProjectButtonSetImage ? [super buttonWithTitleStringKey:nil
                                                                  titleColor:nil
                                                                   titleFont:nil
                                                                    imageNor:dis
                                                                    imageDis:dis
                                                                    imageHig:hig
                                                                      target:target
                                                                    selector:selector] :
    [super buttonWithTitleStringKey:nil
                         titleColor:nil
                          titleFont:nil
                 backgroundImageNor:nor
                 backgroundImageDis:dis
                 backgroundImageHig:hig
                             target:target
                           selector:selector];
}

@end
