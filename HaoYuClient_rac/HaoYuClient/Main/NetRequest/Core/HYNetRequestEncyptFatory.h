//
//  HYNetRequestEncyptFatory.h
//  HaoYuClient
//
//  Created by 刘文强 on 2018/5/21.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYNetRequestEncyptFatory : NSObject

    /**
     配置请求头
     
     @param sessionManager sessionManager
     */
+ (void)setRequestHeaderWithSessionManager:(AFHTTPSessionManager *)sessionManager;
@end
