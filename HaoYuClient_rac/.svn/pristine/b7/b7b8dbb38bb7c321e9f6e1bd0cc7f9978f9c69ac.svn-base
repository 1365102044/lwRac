//
//  HYBaoXiuModel.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/7.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYBaoXiuModel.h"

@implementation HYBaoXiuModel
-(NSArray *)picurlArray
{
    if (!_picurlArray) {
        NSMutableArray *tem = [[NSMutableArray alloc] init];
        for (NSDictionary *dict in _resultPic) {
            if(dict[@"big"]) [tem addObject:dict[@"big"]];
        }
        _picurlArray = tem;
    }
    return _picurlArray;
}
@end
