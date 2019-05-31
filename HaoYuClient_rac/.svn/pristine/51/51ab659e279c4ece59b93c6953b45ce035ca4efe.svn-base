//
//  HYSurfaceDeatilView.h
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/1.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYBaseView.h"
#import "HYShuiDianBiaoModel.h"

@protocol SurfaceDeatilDelegate <NSObject>
//点击充值记录
- (void)gotoRechargeHistoryList;
//切换水表/热水表
- (void)switchWaterSufaceWithSegIndex:(NSInteger)segIndex;

@end

@interface HYSurfaceDeatilView : HYBaseView
@property (nonatomic, weak) id<SurfaceDeatilDelegate> delegate;

/**
 水 / 电 表
 */
@property (nonatomic, strong) NSString * typeStr;
@property (nonatomic, strong) HYDefaultLabel * payLable;
//@property (nonatomic, strong) NSArray * dataArray;
- (void)setSurfaceDataArray:(NSArray *)dataArray;

@end
