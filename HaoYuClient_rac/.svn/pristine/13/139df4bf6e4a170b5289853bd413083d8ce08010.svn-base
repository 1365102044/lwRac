//
//  HYProjectNetRequestInfo.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/5/21.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYProjectNetRequestInfo.h"

@implementation HYProjectNetRequestInfo

- (void)setResponseObject:(id)responseObject
{
    if ([responseObject isKindOfClass:[NSHTTPURLResponse class]]) {
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)responseObject;
        _responseObject = response.allHeaderFields;
        
    }else{
        _responseObject = @{@"errorMsg":@"响应头错误"};
    }
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"sessionTask-%@\nurlString-%@\nrequestParam-%@\ntimeStamp-%@\nresponseObject-%@",
            _sessionTask,
            _urlString,
            _requestParam,
            _timeStamp,
            _responseObject];
}

@end
