//
//  HYLockModel.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/13.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYLockModel.h"

@implementation HYLockModel

- (NSString *)lockTypeStr
{
    switch ([_lockType integerValue]) {
        case 1:
            return @"云柚";
            break;
        case 2:
            return @"果加";
            break;
        case 3:
            return @"丁盯";
            break;
        default:
            return @"";
            break;
    }
}
@end
