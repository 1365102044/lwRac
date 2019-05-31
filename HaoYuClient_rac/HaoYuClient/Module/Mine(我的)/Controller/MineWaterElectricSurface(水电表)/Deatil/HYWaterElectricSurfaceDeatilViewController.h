//
//  HYWaterElectricSurfaceDeatilViewController.h
//  HaoYuClient
//
//  Created by 刘文强 on 2018/5/31.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYBaseTableViewController.h"
#import "HYContractModel.h"
@interface HYWaterElectricSurfaceDeatilViewController : HYBaseTableViewController

+ (instancetype)creatSurfaceDeatilViewController:(NSString *)titleStr heTongModel:(HYContractModel *)heTongModel;
/**
 充值成功后，调用刷新数据
 */
- (void)requestInfor;

@end
