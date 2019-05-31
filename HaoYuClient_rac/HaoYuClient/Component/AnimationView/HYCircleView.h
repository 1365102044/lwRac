//
//  HYCircleView.h
//  HaoYuClient
//
//  Created by 刘文强 on 2019/1/24.
//  Copyright © 2019年 LWQ. All rights reserved.
//

#import "HYBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface HYCircleView : HYBaseView
//每次触发定时器的事件
@property (nonatomic, copy) HYEventCallBackBlock timerCallBlock;
//m定时器结束的事件
@property (nonatomic, copy) HYEventCallBackBlock timerStopCallBlock;
/**
 手动关闭定时器
 */
- (void)stopTimer;
@end

NS_ASSUME_NONNULL_END
