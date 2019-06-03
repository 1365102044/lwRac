//
//  LWHouseListViewModel.h
//  HaoYuClient
//
//  Created by 刘文强 on 2019/6/1.
//  Copyright © 2019年 LWQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC.h>
#import "HYQuYuModel.h"
#import "LWBaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LWHouseListViewModel : LWBaseViewModel

//@property (nonatomic, strong) RACCommand * quYuForCityCommand;
//区域ID
@property (nonatomic, strong) NSString * quyuId;
//预入住时间
@property (nonatomic, strong) NSString * preStayTime;
//升序or降序  默认 desc  /asc
@property (nonatomic, strong) NSString * sortType;
// 首页过来的数据
@property (nonatomic, strong) NSArray * dataModel;

// 结束下拉刷新
@property (nonatomic, strong) RACSubject * endRefreshSubject;
// 无数据
@property (nonatomic, strong) RACSubject * noDataSubject;

// 区域名字
@property (nonatomic, strong) NSString * townName;
@property (nonatomic, strong) NSArray * quyuModelArray;

// 区域名字数据
@property (nonatomic, strong) NSArray * quyuNameDatas;

@property (nonatomic, strong) NSString * regionTitle;

/**
 获取列表数据
 */
- (void)requestListInfor;

/**
 根据城市ID 获取区域列表
 */
- (void)requestQuYuInforByCityId;
/**
 更新价格排序
 */
- (void)updateSortPrice:(BOOL)isAsc;

@end

NS_ASSUME_NONNULL_END
