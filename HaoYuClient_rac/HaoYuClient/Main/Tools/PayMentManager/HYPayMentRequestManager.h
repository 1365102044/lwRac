//
//  HYPayMentRequestManager.h
//  HaoYuClient
//
//  Created by 刘文强 on 2018/8/3.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYPayMentRequestManager : NSObject


//支付回调结果的代理控制器
@property (nonatomic, strong) UIViewController * delegateVc;

/**
 充值 生成预支付订单
 */
+ (instancetype)payCreatPrePaymentForRechargeWithPara:(NSMutableDictionary *)param;

/**
 订单 / 定金 预支付订单
 */
+ (instancetype)payCreatPrePaymentForBillDespositWithPara:(NSMutableDictionary *)param;

/**
 请求回调
 */
- (void)payResultSuccessBlock:(HYEventCallBackBlock)successBlock failBlock:(HYEventCallBackBlock)failBlock;

/**
 返回 商户交易号 用户h支付结果 的查询
 */
@property (nonatomic, copy) HYEventCallBackBlock paramCallBlackBlock;

@end
