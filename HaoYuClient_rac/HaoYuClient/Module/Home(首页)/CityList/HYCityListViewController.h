//
//  HYCityListViewController.h
//  HaoYuClient
//
//  Created by 刘文强 on 2018/7/12.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYBaseTableViewController.h"

@interface HYCityListViewController : HYBaseTableViewController
+ (instancetype)creatCityListViewController:(id)extend CallBlock:(HYEventCallBackBlock)callBlock;
@end
