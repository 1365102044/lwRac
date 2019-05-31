//
//  HYMineModel.h
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/7.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYBaseModel.h"

@interface HYMineModel : HYBaseModel
/**
 房源id
 */
@property (nonatomic, copy) NSString * houseId;
/**
 楼栋号
 */
@property (nonatomic, copy) NSString * buildingNo;
/**
 项目名称
 */
@property (nonatomic, copy) NSString * houseItemName;

/**
 项目id
 */
@property (nonatomic, copy) NSString * houseItemId;
/**
 房间号
 */
@property (nonatomic, copy) NSString * fangNo;
/**
 0:待签字、1:已签字、2:在租中、3:已到期、4:已退租、5:已作废
 */
@property (nonatomic, copy) NSString * status;

@end

