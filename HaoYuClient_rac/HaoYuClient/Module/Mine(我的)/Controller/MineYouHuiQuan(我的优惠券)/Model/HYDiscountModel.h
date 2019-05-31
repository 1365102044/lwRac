//
//  HYDiscountModel.h
//  HaoYuClient
//
//  Created by 刘文强 on 2018/9/20.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYBaseModel.h"

@interface HYDiscountModel : HYBaseModel

//优惠券金额
//@property (nonatomic, copy) NSString * couponMoney;
@property (nonatomic, copy) NSString * iosDedicated;

//优惠券最低使用金额
//@property (nonatomic, copy) NSString * couponLimitMoney;
@property (nonatomic, copy) NSString * iosDedicatedMin;



//优惠券生效时间
@property (nonatomic, copy) NSString * couponBeginTime;

//优惠券失效时间
@property (nonatomic, copy) NSString * couponEndTime;

//优惠券使用状态（1.未使用 2.使用中 0.已使用）
@property (nonatomic, copy) NSString * couponUsed;

//优惠券可进行抵扣的门店id
@property (nonatomic, copy) NSString * couponUsedItemId;

//优惠券名称
@property (nonatomic, copy) NSString * couponTitle;

//优惠券mark集合
@property (nonatomic, copy) NSString * marklist;

@property (nonatomic, strong) NSDictionary * ov;

//优惠券可抵扣类型
@property (nonatomic, copy) NSString * couponType;

//可使用门店名称
@property (nonatomic, copy) NSString * couponItemName;

@property (nonatomic, copy) NSString * couponDesc;

//id 优惠券ID

//是否已经选中
@property (nonatomic, assign) BOOL isSelect;


@end
