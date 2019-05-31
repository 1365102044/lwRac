//
//  LWPayMainView.h
//  HaoYuClient
//
//  Created by 刘文强 on 2019/2/18.
//  Copyright © 2019年 LWQ. All rights reserved.
//

#import "HYBaseView.h"
#import "HYMoneyTextFiled.h"

@interface LWPayMainView : HYBaseView
/**
 获取该视图
 
 @param payMentType 支付类型（充值、定金、账单）
 @return 对应视图
 */
+ (instancetype)getPayMainView:(PayMentType)payMentType;

/**
  1: 点击选择优惠券； 2：点击下一步
 */
@property (nonatomic, copy) HYEventCallBackBlock clickBtn;

/**
 支付信息字典
 */
@property (nonatomic, strong) NSDictionary * infor;

/**
 金额输入框
 */
@property (nonatomic, strong)  HYMoneyTextFiled * moneyTextFlied;

/**
 选择的优惠券列表数据
 */
@property (nonatomic, strong) NSArray * discountDatas;
/**
 充值方式（1：充值电费 2：充值冷水费 4：充值热水费）
 */
@property (nonatomic, assign) NSInteger rechargeTag;

/**
 选择的优惠券的总金额
 */
@property (nonatomic, strong) NSString * discAllMoney;

/**
 获取logo图片名
 */
- (NSString *)getLogoImageName;

@end
