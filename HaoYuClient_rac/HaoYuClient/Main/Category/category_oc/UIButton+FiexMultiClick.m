//
//  UIButton+FiexMultiClick.m
//  Test_Project
//
//  Created by 刘文强 on 2018/1/10.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "UIButton+FiexMultiClick.h"
#import <objc/runtime.h>

@implementation UIButton (FiexMultiClick)

static const char *UIControl_acceptEventInterval = "UIControl_acceptEventInterval";

static const char *UIControl_cs_acceptEventInterval = "UIControl_cs_acceptEventInterval";
//- (NSTimeInterval)acceptEventTime
//{
//    return [objc_getAssociatedObject(self, UIControl_acceptEventInterval) doubleValue];
//}
//
//- (void)setAcceptEventTime:(NSTimeInterval)acceptEventTime
//{
//    objc_setAssociatedObject(self, UIControl_acceptEventInterval, @(acceptEventTime), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}
//
//- (NSTimeInterval)cs_acceptEventTime
//{
//    return [objc_getAssociatedObject(self, UIControl_cs_acceptEventInterval) doubleValue];
//}
//
//- (void)setCs_acceptEventTime:(NSTimeInterval)cs_acceptEventTime
//{
//    objc_setAssociatedObject(self, UIControl_cs_acceptEventInterval, @(cs_acceptEventTime), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}
//
//+ (void)load
//{
//    Method before = class_getInstanceMethod([self class], @selector(sendAction:to:forEvent:));
//    Method after  = class_getInstanceMethod([self class], @selector(cs_sendAction:to:forEvent:));
//    method_exchangeImplementations(before, after);
//}
//
//- (void)cs_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event
//{
//    NSLog(@"=============++++%f=====%f",self.acceptEventTime,self.cs_acceptEventTime);
//    if ([NSDate date].timeIntervalSince1970 - self.cs_acceptEventTime < self.acceptEventTime) {
//        return;
//    }
//    if (self.acceptEventTime > 0) {
//        self.cs_acceptEventTime = [NSDate date].timeIntervalSince1970;
//         NSLog(@"=============%f=====%f",self.acceptEventTime,self.cs_acceptEventTime);
//    }
//    [self cs_sendAction:action to:target forEvent:event];
//}

@end
