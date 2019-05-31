//
//  HYBaseTimer.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/5/18.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYBaseTimer.h"


@interface HYBaseTimer()

/**
 定时器
 */
@property (nonatomic, strong) NSTimer *timer;

/**
 回调
 */
@property (nonatomic, copy) HYEventCallBackBlock callBlock;

@end
@implementation HYBaseTimer

- (void)callBackBlock:(HYEventCallBackBlock)callBackBlock
{
    self.callBlock = callBackBlock;
}

+ (instancetype)shareTimer
{
    static dispatch_once_t onceToken;
    static HYBaseTimer *instance;
    dispatch_once(&onceToken, ^{
        instance = [[HYBaseTimer alloc]init];
    });
    return instance;
}

/**
 定时器调用事件
 
 @param timer timer
 */
- (void)timerAction:(NSTimer *)timer
{
    if (self.callBlock) {
        self.callBlock(timer);
    }else{
        [SYSTEM_NOTIFICATIONCENTER postNotificationName:TIMER_NOTIFICATION
                                                 object:nil
                                               userInfo:nil];
    }
}

/**
 开始定时器
 */
- (void)startTimerWithTimeInterVal:(NSTimeInterval)timeInterVal
{
    if (_timer) return;
    _timer = [NSTimer timerWithTimeInterval:timeInterVal
                                     target:self
                                   selector:@selector(timerAction:)
                                   userInfo:nil
                                    repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timer
                              forMode:NSRunLoopCommonModes];
}

/**
 开始定时器
 
 @param timeInterVal        调用时间间隔
 @param target              对象
 @param selector            方法
 */
- (void)startTimerWithTimeInterVal:(NSTimeInterval)timeInterVal
                            target:(id)target
                          selector:(SEL)selector
{
    if (_timer) return;
    _timer = [NSTimer timerWithTimeInterval:timeInterVal
                                     target:target
                                   selector:selector
                                   userInfo:nil
                                    repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timer
                              forMode:NSRunLoopCommonModes];
}

/**
 结束定时器
 */
- (void)stopTimer
{
    [self.timer invalidate];
    self.timer = nil;
}

@end
