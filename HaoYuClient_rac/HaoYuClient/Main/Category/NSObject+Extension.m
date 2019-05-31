//
//  NSObject+Extension.m
//  Project
//
//  Created by 郑键 on 17/1/11.
//  Copyright © 2017年 zhengjian. All rights reserved.
//

#import "NSObject+Extension.h"

@implementation NSObject (Extension)
/**
 判断该对象是否属于某个类，包含子类
 
 @param classType 所属类型
 @return 当class不传时：self == nil，返回YES；当class传时，当不为nil或不是该类型时，返回YES
 */
- (BOOL)lw_isNullObjectWith:(Class)classType
{
    if (!self) {
        return YES;
    }
    if (classType && ![self isKindOfClass:classType]) {
        return YES;
    }
    return NO;
}

@end
