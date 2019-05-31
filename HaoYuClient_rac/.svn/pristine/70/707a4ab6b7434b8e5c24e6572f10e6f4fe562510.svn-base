//
//  LWHomePageModelHandler.h
//  HaoYuClient
//
//  Created by 刘文强 on 2019/5/9.
//  Copyright © 2019年 LWQ. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LWHomePageModelHandler : NSObject

// 检查版本
- (void)checkVersion;

/**
 获取首页banner
 
 @param callBackBlock   成功回调
 @param failureBlock    失败回调
 */
- (void)requestHomePageBannerWithCallBackBlock:(HYEventCallBackBlock)callBackBlock
                                  failureBlock:(HYEventCallBackBlock)failureBlock;

/**
 首页的数据
 */
- (void)requestHomePageInforCallBackBlock:(HYEventCallBackBlock)callBackBlock failureBlock:(HYEventCallBackBlock)failureBlock;

/**
 获取 热分享
 
 @param callBackBlock 成功
 @param failureBlock 失败
 */
- (void)requestHomePageInforForHotShareCallBackBlock:(HYEventCallBackBlock)callBackBlock failureBlock:(HYEventCallBackBlock)failureBlock;
/**
 获取 热事件
 
 @param callBackBlock 成功
 @param failureBlock 失败
 */
- (void)requestHomePageInforForHotEventsCallBackBlock:(HYEventCallBackBlock)callBackBlock failureBlock:(HYEventCallBackBlock)failureBlock;

/**
 获取首页列表的所有数据
 
 @param callBackBlock 成功回调
 @param failureBlock 失败回调
 */
- (void)requestHomePageAllListInforCallBackBlock:(HYEventCallBackBlock)callBackBlock failureBlock:(HYEventCallBackBlock)failureBlock;
@end

NS_ASSUME_NONNULL_END
