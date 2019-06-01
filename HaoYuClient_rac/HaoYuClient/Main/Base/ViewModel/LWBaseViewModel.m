//
//  LWBaseViewModel.m
//  HaoYuClient
//
//  Created by 刘文强 on 2019/6/1.
//  Copyright © 2019年 LWQ. All rights reserved.
//

#import "LWBaseViewModel.h"

@implementation LWBaseViewModel

- (NSMutableArray*)dataMutableArray
{
    if (!_dataMutableArray) {
        _dataMutableArray = [[NSMutableArray alloc] init];
    }
    return _dataMutableArray;
}

@end
