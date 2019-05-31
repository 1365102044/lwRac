//
//  HYHouseRescourcesViewController.h
//  HaoYuClient
//
//  Created by 刘文强 on 2018/5/21.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYBaseTableViewController.h"

@interface HYHouseRescourcesViewController : HYBaseTableViewController

/**
 dataModel  首页推荐的房源信息
 */
+ (instancetype)houseRescourcesViewControllerWithDataModel:(NSArray *)dataModel
                                                    extend:(id)extend;

@end
