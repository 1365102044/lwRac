//
//  UIControl+LWdelay.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/8/10.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "UIControl+LWdelay.h"
#import <objc/runtime.h>
//增加两个属性
static const char *UIControl_acceptEventInterval = "UIControl_acceptEventInterval";

@implementation UIControl (LWdelay)

//时间间隔
- (NSTimeInterval)lw_acceptEventInterval
{
    return [objc_getAssociatedObject(self, UIControl_acceptEventInterval) doubleValue];
}
- (void)setLw_acceptEventInterval:(NSTimeInterval)lw_acceptEventInterval
{
    objc_setAssociatedObject(self, UIControl_acceptEventInterval, @(lw_acceptEventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

static const char *UIControl_acceptEventTime = "UIControl_acceptEventTime";

- (NSTimeInterval)cs_acceptEventTime {
    return  [objc_getAssociatedObject(self, UIControl_acceptEventTime) doubleValue];
}
- (void)setCs_acceptEventTime:(NSTimeInterval)cs_acceptEventTime {
    objc_setAssociatedObject(self, UIControl_acceptEventTime, @(cs_acceptEventTime), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+(void)load
{
    //将系统的sendAction方法和自己实现的方法进行互换
    SEL swizzleSel = @selector(__lw_sendAction:to:forEvent:);
    SEL originalSel = @selector(sendAction:to:forEvent:);
    Method originalMethod = class_getInstanceMethod(self,originalSel);
    Method swizzleMethod = class_getInstanceMethod(self,swizzleSel);
    /**
     要先尝试添加原 selector 是为了做一层保护，因为如果这个类没有实现 originalSelector ，但其父类实现了，那 class_getInstanceMethod 会返回父类的方法。这样 method_exchangeImplementations 替换的是父类的那个方法，这当然不是你想要的。所以我们先尝试添加 orginalSelector ，如果已经存在，再用 method_exchangeImplementations 把原方法的实现跟新的方法实现给交换掉。
     */
    //class_addMethod will fail if original method already exists
    BOOL didAddMethod = class_addMethod(self,
                                        originalSel,
                                        method_getImplementation(swizzleMethod),
                                        method_getTypeEncoding(swizzleMethod));
    if (didAddMethod) {
        class_replaceMethod(self,
                            swizzleSel,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    }else{
        method_exchangeImplementations(originalMethod,swizzleMethod);
    }
}

//点击后会先进入这里
- (void)__lw_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event
{
    if ([NSDate date].timeIntervalSince1970 - self.cs_acceptEventTime < self.lw_acceptEventInterval) {
        return;
    }
    if (self.lw_acceptEventInterval > 0) {
        self.cs_acceptEventTime = [NSDate date].timeIntervalSince1970;
    }
    
    //这里其实是系统的原来的sendAction to方法。
    [self __lw_sendAction:action to:target forEvent:event];
}

@end
