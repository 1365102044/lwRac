//
//  HYProjectNetRequestInfo.h
//  HaoYuClient
//
//  Created by 刘文强 on 2018/5/21.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYProjectNetRequestInfo : NSObject

//** =========================================================================================== */
//** ============================================请求=========================================== */
//** =========================================================================================== */

/**
 请求任务task
 */
@property (nonatomic, strong) NSURLSessionTask *sessionTask;

/**
 请求的URLString
 */
@property (nonatomic, copy) NSString *urlString;

/**
 请求参数
 */
@property (nonatomic, strong) NSDictionary *requestParam;

/**
 请求时间戳
 */
@property (nonatomic, strong) NSString *timeStamp;

//** =========================================================================================== */
//** ============================================响应=========================================== */
//** =========================================================================================== */

/**
 responseObject
 */
@property (nonatomic, strong) id responseObject;
    
@end
