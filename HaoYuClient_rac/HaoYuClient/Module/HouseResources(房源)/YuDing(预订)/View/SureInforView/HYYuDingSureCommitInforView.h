//
//  HYYuDingSureCommitInforView.h
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/14.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYBaseView.h"
#import "HYHouseRescourcesModel.h"
@interface HYYuDingSureCommitInforView : HYBaseView
/**
 房源信息
 */
@property (nonatomic, strong) HYHouseRescourcesModel * houseInfor_M;

/**
 预计结束时间
 */
@property (nonatomic, strong) NSString * endtime;

@end
