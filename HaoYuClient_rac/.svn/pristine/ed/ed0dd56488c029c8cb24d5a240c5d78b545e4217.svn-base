//
//  HYContractModel.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/6.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYContractModel.h"

@implementation HYContractModel
/**
 0:待签字、1:已签字、2:在租中、3:已到期、4:已退租、5:已作废
 */
- (NSString *)statusStr
{
    switch ([self.status integerValue]) {
        case 0:
            return @"待签字";
            break;
        case 1:
            return @"待生效";
            break;
        case 2:
            return @"在租中";
            break;
        case 3:
            return @"已到期";
            break;
        case 4:
            return @"已退租";
            break;
        case 5:
            return @"已作废";
            break;
        default:
            return @"";
            break;
    }
}

@end
