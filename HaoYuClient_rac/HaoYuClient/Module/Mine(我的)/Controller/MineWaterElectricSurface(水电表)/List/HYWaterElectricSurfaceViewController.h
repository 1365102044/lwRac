//
//  HYWaterElectricSurfaceViewController.h
//  HaoYuClient
//
//  Created by 刘文强 on 2018/5/24.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYBaseTableViewController.h"

@interface HYWaterElectricSurfaceViewController : HYBaseTableViewController
/**
 跳转水电表
 titleStr  水表、电表
 */
+ (instancetype)pushWaterElectricSurfaceVCwith:(NSString *)titleStr;

/**
 选择 合同列表 进入账单
 */
@property (nonatomic, copy) NSArray * HeTongDataArr;

/**
 来源表示 根据按钮title
 */
@property (nonatomic, strong) NSString * sourceType;

@end
