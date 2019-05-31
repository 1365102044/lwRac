//
//  HYQianYueBillModel.h
//  HaoYuClient
//
//  Created by 刘文强 on 2018/7/24.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYBaseModel.h"

@interface HYQianYueBillModel : HYBaseModel
@property (nonatomic, copy) NSString * bqCount;
@property (nonatomic, copy) NSString * feiYongDesc;
@property (nonatomic, copy) NSString * bqBeginDate;
@property (nonatomic, copy) NSString * feiYongTypeId;
@property (nonatomic, copy) NSString * bqEndDate;
@property (nonatomic, copy) NSString * type;
@property (nonatomic, copy) NSString * bqBackPayDate;
@property (nonatomic, copy) NSString * bqMonthMoney;


//---------------- 转化后的字段----------------
@property (nonatomic, copy) NSString * typeId;
@property (nonatomic, copy) NSString * predictTime;
@property (nonatomic, copy) NSString * beginTime;
@property (nonatomic, copy) NSString * endTime;
@property (nonatomic, copy) NSString * isIncludeDJ;
//@property (nonatomic, copy) NSString * type;
@property (nonatomic, copy) NSString * desc;
@property (nonatomic, copy) NSString * money;

@end
