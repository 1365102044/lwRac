//
//  HYDefaultButton.h
//  HaoYuClient
//
//  Created by 刘文强 on 2018/5/22.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYBaseButton.h"

@interface HYDefaultButton : HYBaseButton
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
                                selector:(SEL)selector;
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
                                             selector:(SEL)selector;
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
                                    selector:(SEL)selector;
@end
