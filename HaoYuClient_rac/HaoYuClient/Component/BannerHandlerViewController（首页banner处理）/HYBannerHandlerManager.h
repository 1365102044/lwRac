//
//  HYBannerHandlerViewController.h
//  HaoYuClient
//
//  Created by 刘文强 on 2018/10/23.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYHomePageModel.h"
@interface HYBannerHandlerManager : NSObject

/**
 bannerModel:  数据模型
 sourceVC:     来源控制器
 extend:       扩展数据
 */
+ (void)handleWithBannerModel:(HYHomeBannnerModel *)bannerModel
         sourceViewControlelr:(HYBaseViewController *)sourceVC
                       extend:(id)extend;
@end

