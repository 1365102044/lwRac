//
//  HYBaseTimer.h
//  HaoYuClient
//
//  Created by 刘文强 on 2018/5/18.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYBaseTimer : NSObject
#pragma mark - 初始化

/**
 init获取定时器管理，该对象使用通知接收响应，通知名参照HYNotificationConst.h
 */

+ (instancetype)shareTimer;

/**
 开始定时器
 */
- (void)startTimerWithTimeInterVal:(NSTimeInterval)timeInterVal;

/**
 回调 配合👆👆👆👆👆方法使用
 
 @param callBackBlock 回调
 */
- (void)callBackBlock:(HYEventCallBackBlock)callBackBlock;

/**
 开始定时器
 
 @param timeInterVal        调用时间间隔
 @param target              对象
 @param selector            方法
 */
- (void)startTimerWithTimeInterVal:(NSTimeInterval)timeInterVal
                            target:(id)target
                          selector:(SEL)selector;

/**
 结束定时器
 */
- (void)stopTimer;

@end
