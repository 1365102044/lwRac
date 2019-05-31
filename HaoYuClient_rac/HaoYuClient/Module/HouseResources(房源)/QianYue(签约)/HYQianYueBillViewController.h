//
//  HYQianYueBillViewController.h
//  HaoYuClient
//
//  Created by 刘文强 on 2018/7/24.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYBaseTableViewController.h"

@interface HYQianYueBillViewController : HYBaseTableViewController

/**
 sourceVC   签约来源控制器
 */
+ (instancetype)qianYuBillViewControllerFromSoucrVC:(HYBaseViewController *)sourceVC
                                              param:(NSDictionary *)param
                                             extend:(id)extend;
- (void)setDataArrayModel:(NSMutableArray *)dataArrayModel;

@end
