//
//  HYBase_LocalData.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/5/22.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYBase_LocalData.h"

@implementation HYBase_LocalData
+ (void)initialize
{
    if (self == [HYBase_LocalData self]) {
    }
}

+ (instancetype)share
{
    static HYBase_LocalData * instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[HYBase_LocalData alloc] init];
    });
    return instance;
}

@end
