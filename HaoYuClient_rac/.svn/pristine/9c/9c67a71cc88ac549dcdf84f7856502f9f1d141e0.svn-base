//
//  HYPayMainView.h
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/13.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYBaseView.h"
#import "HYMoneyTextFiled.h"

@protocol payMainViewDelegate <NSObject>
//去选择优惠券
- (void)pushChooseDiscountViewController;
@end

@interface HYPayMainView : HYBaseView
@property (nonatomic, strong) HYMoneyTextFiled *moneyTextFlied;
@property (nonatomic, weak) id<payMainViewDelegate>  delegate;

/**
 更新约束
 */
- (void)updateConstraintsHeaderViewWithPayMentType:(PayMentType)payType;

/**
 选择支付方式  默认:1
    微信 ：1
    支付宝：2
 */
@property (nonatomic, assign) NSInteger selPayTypeTag;
/**
 为顶部视图赋值
 */
- (void)setHeaderViewDatas:(NSDictionary *)data;
/**
 显示选择的优惠券
 */
- (void)setDiscountDatas:(NSArray *)datas;

@end
