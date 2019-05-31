//
//  HYTouSuJianYiModel.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/22.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYTouSuJianYiModel.h"

@implementation HYTouSuJianYiModel
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
