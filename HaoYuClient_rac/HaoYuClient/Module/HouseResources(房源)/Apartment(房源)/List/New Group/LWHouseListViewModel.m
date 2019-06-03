//
//  LWHouseListViewModel.m
//  HaoYuClient
//
//  Created by 刘文强 on 2019/6/1.
//  Copyright © 2019年 LWQ. All rights reserved.
//

#import "LWHouseListViewModel.h"
#import "HYHouseRescourcesModel.h"

@interface LWHouseListViewModel ()

@end

@implementation LWHouseListViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        //默认
        _sortType = @"desc";
        ADD_NOTI(changeCityNoti:, HOUSERESOURCE_CITYID_FORCHANGECITY_INHOUMEPAGE_NOTI);
    }
    return self;
}

- (void)setDataModel:(NSArray *)dataModel
{
    _dataModel = dataModel;
    if (!dataModel) {
        [self requestListInfor];
    }else{
        [self.dataMutableArray addObjectsFromArray:dataModel];
    }
}

/**
 修改城市列表后，修改筛选条件
 */
- (void)changeCityNoti:(NSNotification *)noti
{
    self.regionTitle = @"选择区域";
    //清空筛选条件
    self.quyuId = @"";
    [self requestListInfor];
}

//- (RACCommand*)quYuForCityCommand
//{
//    if (!_quYuForCityCommand) {
//        _quYuForCityCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
//            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
//                return nil;
//            }];
//        }];
//    }
//    return _quYuForCityCommand;
//}
/**
 获取列表数据
 */
- (void)requestListInfor
{
    PARA_CREART;
    PARA_SET([HYStringTool checkString:_preStayTime], @"preStayTime");
    PARA_SET(@"zujin_", @"sortFields");
    PARA_SET(_sortType, @"sortType");//asc
    PARA_SET([HYStringTool checkString:_quyuId], @"quyuId");
    PARA_SET([HYStringTool checkString:[HYPublic_LocalData share].location_City_Id], @"cityId");//@"d94bba14-dec1-11e5-bcc3-00163e1c066c"
    [[HYServiceManager share] postRequestAnWithurl:HOUSE_LIST_INFOR_URL
                                         paramters:para
                                      successBlock:^(id objc, id requestInfo) {
                                          NSArray *datas = objc[@"result"][@"list"];
                                          [self handleListDatas:datas];
                                          if (datas.count == 0 && self.noDataSubject) {
                                              [self.noDataSubject sendNext:@"0"];
                                          }

                                          if (self.endRefreshSubject) {
                                              [self.endRefreshSubject sendNext:@""];
                                          }
                                      } failureBlock:^(id error, id requestInfo) {
                                          if (self.endRefreshSubject) {
                                              [self.endRefreshSubject sendNext:@""];
                                          }
                                          if (self.noDataSubject) {
                                              [self.noDataSubject sendNext:@"2"];
                                          }
                                      }];
}

- (void)handleListDatas:(NSArray *)datas
{
    if (!datas) return;
    NSMutableArray *temp_data = [[NSMutableArray alloc] init];
    for (NSDictionary *dict in datas) {
        HYHouseRescourcesModel *houseRescourcesModel = [HYHouseRescourcesModel modelWithJSON:dict];
        [temp_data addObject:houseRescourcesModel];
    }
    self.dataMutableArray = temp_data;
}

/**
 根据城市ID 获取区域列表
 */
- (void)requestQuYuInforByCityId
{
    if (self.quyuModelArray && self.quyuModelArray.count > 0) {
        NSMutableArray *items_Ar = [[NSMutableArray alloc] init];
        for (HYQuYuModel *model in self.quyuModelArray) {
            [items_Ar addObject:model.townName];
        }
        [items_Ar insertObject:@"全部区域" atIndex:0];
        self.quyuNameDatas = items_Ar;
        return;
    }
    PARA_CREART;
    PARA_SET([HYStringTool checkString:[HYPublic_LocalData share].location_City_Id], @"cityId");
    [[HYServiceManager share] postRequestWithurl:GET_QUYU_LIST_BY_CITY_INFOR_URL
                                       paramters:para
                                    successBlock:^(id objc, id requestInfo) {
                                        LWLog(@"-------\nquyu:%@",objc);
                                        NSMutableArray *tem_Ar = [[NSMutableArray alloc] init];
                                        NSMutableArray *items_Ar = [[NSMutableArray alloc] init];
                                        for (NSDictionary *dic in objc[@"result"][@"list"]) {
                                            HYQuYuModel *model = [HYQuYuModel modelWithJSON:dic];
                                            [items_Ar addObject:model.townName];
                                            [tem_Ar addObject:model];
                                        }
                                        [HYPublic_LocalData share].QuYu_ByCityId_Arr_M = tem_Ar;
                                        self.quyuModelArray = tem_Ar;
                                        [items_Ar insertObject:@"全部区域" atIndex:0];
                                        self.quyuNameDatas = items_Ar;
                                    } failureBlock:^(id error, id requestInfo) {
                                        
                                    }];
}

- (void)updateSortPrice:(BOOL)isAsc
{
    self.sortType = isAsc ? @"asc": @"desc";
    [self requestListInfor];
}
- (RACSubject*)endRefreshSubject
{
    if (!_endRefreshSubject) {
        _endRefreshSubject = [[RACSubject alloc] init];
    }
    return _endRefreshSubject;
}

- (RACSubject*)noDataSubject
{
    if (!_noDataSubject) {
        _noDataSubject = [[RACSubject alloc] init];
    }
    return _noDataSubject;
}
@end
