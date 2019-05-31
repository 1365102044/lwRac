//
//  HYBaseBarButtonItem.h
//  HaoYuClient
//
//  Created by 刘文强 on 2018/5/23.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYBaseBarButtonItem : UIBarButtonItem
/**
 用于处理图片偏移的文字
 */
@property (nonatomic, assign) BOOL offSet;

/**
 alph
 */
@property (nonatomic, assign) CGFloat alph;

/**
  用于外部修改文字颜色
 */
@property (nonatomic, strong) UIColor *textColor;

/**
 用于配置内容偏移
 
 @param inset  偏移量
 */
- (void)inset:(UIEdgeInsets)inset;

/**
 创建BarButtonItem（文字）
 
 @param titleStringKey                          title的文字Key
 @return                                        barButtonItem
 */
+ (instancetype)barButtonItemWithTitleStringKey:(NSString *)titleStringKey
                                       callBack:(HYEventCallBackBlock)callBack;
/**
 创建返回按钮（图片）
 
 @return                                        barButtonItem
 */
+ (instancetype)backbarButtonItemWithCallBack:(HYEventCallBackBlock)callBack;
/**
 创建BarButtonItem（图片）
 
 @param imageNamed                              图片名
 @return                                        barButtonItem
 */
+ (instancetype)barButtonItemWithimageNamed:(NSString *)imageNamed
                                   callBack:(HYEventCallBackBlock)callBack;
@end
