//
//  HYSurfaceInforView.h
//  HaoYuClient
//
//  Created by 刘文强 on 2018/10/29.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYBaseView.h"

@protocol SurfaceInforDelegate <NSObject>
/**
 更多
 */
- (void)moreRechargeRecordListInfor;
/**
 充值
 */
- (void)submitRechargeRequest;
@end

@interface HYSurfaceInforView : HYBaseView
@property (nonatomic, weak) id<SurfaceInforDelegate> delegate;
/**
 选择tag 随数据标示 水10/ 热水20/ 电40
 */
@property (nonatomic, copy) NSString * selTag;
- (void)setSurfaceInforModel:(NSDictionary *)modelDict;
/**
 type : 1 水/ 2 电 / 3 热水
 */
- (void)surfaceType:(NSInteger)Type;

@end
