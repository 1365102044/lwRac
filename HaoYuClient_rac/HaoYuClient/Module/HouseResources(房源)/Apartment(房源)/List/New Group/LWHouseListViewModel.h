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
/**
 首页过来的数据
 */
@property (nonatomic, strong) NSArray * dataModel;

@property (nonatomic, strong) UITableView * mainTableView;

@property (nonatomic, strong) RACSubject * delegateSubject;


+ (instancetype)createHouseViewModelBind:(UIView *)topView;

/**
 获取列表数据
 */
- (void)requestListInfor;

/**
 根据城市ID 获取区域列表
 */
- (void)requestQuYuInforByCityId;

@end

NS_ASSUME_NONNULL_END
