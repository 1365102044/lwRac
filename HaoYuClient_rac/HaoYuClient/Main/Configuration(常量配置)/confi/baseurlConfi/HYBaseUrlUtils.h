//
//  HYBaseUrlUtils.h
//  HaoYuClient
//
//  Created by 刘文强 on 2019/1/9.
//  Copyright © 2019年 LWQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYBaseUrlModel: NSObject
@property (nonatomic, copy) NSString * url;
@property (nonatomic, copy) NSString * urlName;
@property (nonatomic, assign) NSInteger tag;

@end

@interface HYBaseUrlUtils : NSObject

/**
 配置的服务器地址
 */
@property (nonatomic, strong) NSArray * baseUrlsArray;

/**
 当前服务器地址
 */
@property (nonatomic, strong) NSString * currentServiceURL;
@property (nonatomic, strong) NSString * currentServiceName;

@end
