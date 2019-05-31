//
//  HYWaterElectricSurfacePayRecordListViewController.h
//  HaoYuClient
//
//  Created by 刘文强 on 2018/8/15.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYBaseTableViewController.h"

@interface HYWaterElectricSurfacePayRecordListViewController : HYBaseTableViewController
/**
 surfaceType: 水表：1 ； 电表：2
 dataModelArray    数据模型
 */
+ (instancetype)creatRechargePayRecordListViewControllerWithSurfaceType:(NSInteger )surfaceType
                                                      dataModelArray:(NSArray *)dataModelArray
                                                              extend:(id)extend;

@end
