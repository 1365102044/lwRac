//
//  LWChoosePayMentView.h
//  HaoYuClient
//
//  Created by 刘文强 on 2019/1/25.
//  Copyright © 2019年 LWQ. All rights reserved.
//

#import "HYBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface LWChoosePayMentView : HYBaseView

@property (nonatomic, copy) HYEventCallBackBlock selectPayMethodBlock;


/**
 显示支付视图

 @param title 标题
 @param desc 描述（内部拼接：价格L：desc）
 @param callBlackBlock 点击底部按钮的回调（1：取消支付，2：确认支付）
 */
- (void)showChoosePayTypeViewWithTitle:(NSString *)title desc:(NSString *)desc imageName:(NSString *)imageName callBlackBlock:(HYEventCallBackBlock)callBlackBlock;;

/**
 显示支付视图
 
 @param title 标题
 @param desc 描述（内部拼接：价格L：desc）
 @param callBlackBlock 点击底部按钮的回调（1：取消支付，2：确认支付）
 */
+ (instancetype)showChoosePayMethodViewWithTitle:(NSString *)title desc:(NSString *)desc imageName:(NSString *)imageName callBlackBlock:(HYEventCallBackBlock)callBlackBlock;

- (void)dismiss;

@end

NS_ASSUME_NONNULL_END
