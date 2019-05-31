//
//  HYShuiDianBiaoModel.h
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/13.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYBaseModel.h"

@interface HYRechargeRecordBaseInforModel:HYBaseModel
@property (nonatomic, strong) NSString * dateString;
@property (nonatomic, strong) NSArray * dateModelArrary;
@end

@interface HYRechargeRecordListInforModel: HYBaseModel
@property (nonatomic, copy) NSString * rechargeCount;
/**
 表类型-10:水表，20:热水表，30:燃气表，40:电表,50:中水表
 */
@property (nonatomic, assign) NSInteger  waterMeter;
@property (nonatomic, copy) NSString * shuiLiang;
@property (nonatomic, copy) NSString * rechargeDate;
// 水表：1； 电表：2 （本地字段）
@property (nonatomic, assign) NSInteger surfaceType;

@end

@interface HYShuiDianBiaoModel : HYBaseModel
/**
 电余量
 */
@property (nonatomic, copy) NSString * dianYuE;
/**
 昨日用电量
 */
@property (nonatomic, copy) NSString * dianLiang;
/**
 部门id
 */
@property (nonatomic, copy) NSString * deptId;
/**
 电费余额
 */
@property (nonatomic, copy) NSString * dianYuLiang;
/**
 总电量
 */
@property (nonatomic, copy) NSString * sumDian;
/**
 昨日电费
 */
@property (nonatomic, copy) NSString * dianFei;
/**
 表品牌
 */
@property (nonatomic, copy) NSString * brand;
/**
 房源地址
 */
@property (nonatomic, copy) NSString * fullAdress;
/**
 类型-10:水表，20:热水表，30:燃气表，40:电表,50:中水表
 */
@property (nonatomic, copy) NSString * type;

@property (nonatomic, copy) NSString * shuiYuE;
@property (nonatomic, copy) NSString * shuiFei;
@property (nonatomic, copy) NSString * shuiLiang;
@property (nonatomic, copy) NSString * shuiYuLiang;
@property (nonatomic, copy) NSString * sumShui;


// id 电/水表 id


@end
