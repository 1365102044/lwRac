//
//  HYBaseService.h
//  HaoYuClient
//
//  Created by 刘文强 on 2018/5/21.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HYProjectNetRequestInfo.h"
#import "HYNetRequestError.h"
#import "HYProjectNetRequestManager.h"

@interface HYBaseService : NSObject

@property (nonatomic, assign) BOOL notShowMsgAlert;

    /**
     *  单例
     */
+ (instancetype)share;
    
    /**
     *  请求数据成功的处理
     *
     *  @param dictionary   请求回来的数据
     *  @param requestInfoModel      请求task
     *  @param sucBlock  如果一切正常则会执行该block
     *  @param failBlock 出现其它错误时执行(例如:请求虽然成功,但出现必填参数为空)
     */
- (void)handleRequestSuccess:(NSDictionary *)dictionary
                requestModel:(HYProjectNetRequestInfo *)requestInfoModel
                    sucBlock:(HYNetRequestSuccessBlock)sucBlock
                   failBlock:(HYNetRequestFailureBlock)failBlock;
    
    /**
     *  请求数据失败后的处理
     *
     *  @param error     请求失败后返回Error对象
     */
- (void)handleRequestFailed:(NSError *)error
               requestModel:(HYProjectNetRequestInfo *)requestInfoModel
                  failBlock:(HYNetRequestFailureBlock)failBlock;
@end
