//
//  HYNetRequestEncyptFatory.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/5/21.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYNetRequestEncyptFatory.h"

@implementation HYNetRequestEncyptFatory
/**
 配置请求头
 
 @param sessionManager sessionManager
 */
+ (void)setRequestHeaderWithSessionManager:(AFHTTPSessionManager *)sessionManager
{
    /**
     *  配置公司编码
     */
    [sessionManager.requestSerializer setValue:BASE_GCID
                            forHTTPHeaderField:@"gcid"];
    /**
     *  如果登录，携带token
     */
    [sessionManager.requestSerializer setValue:[USERDEFAULTS_GET(USER_TOKEN_KEY) isNullToString]
                            forHTTPHeaderField:@"token"];
}

@end
