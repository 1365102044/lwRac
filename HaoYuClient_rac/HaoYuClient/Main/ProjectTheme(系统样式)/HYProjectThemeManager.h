//
//  HYProjectThemeManager.h
//  HaoYuClient
//
//  Created by 刘文强 on 2018/5/18.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYProjectThemeManager : NSObject
#pragma mark - 配置颜色

/**
 项目用颜色主题工厂
 */
@property (nonatomic, strong) HYProjectThemeColorFactory *themeColorFatory;

#pragma mark - 初始化

/**
 获取项目主题管理单利
 
 @return 对象
 */
+ (instancetype)sharedManager;

#pragma mark - 配置图片

/**
 加载网络图片URL处理
 
 @param imageURLStringType  HYProjectImageURLStringType
 @param URLString           图片的URLString
 @return                    处理好的URL
 */
- (NSString *)resetImageURLStringWithImageType:(HYProjectImageURLStringType)imageURLStringType
                                     URLString:(NSString *)URLString;

#pragma mark - 字体配置

@end
