//
//  LWHouseListViewModel.m
//  HaoYuClient
//
//  Created by 刘文强 on 2019/6/1.
//  Copyright © 2019年 LWQ. All rights reserved.
//

#import "LWHouseListViewModel.h"
#import "HYHourseChooseListView.h"
#import "HYHouseTopView.h"
#import "HYHouseRescourcesModel.h"
#import "HYDatePickerManager.h"

@interface LWHouseListViewModel ()
@property (nonatomic, strong) HYHouseTopView * topView;

@property (nonatomic, strong) NSArray * quyuDatas;

@end

@implementation LWHouseListViewModel

+ (instancetype)createHouseViewModelBind:(UIView *)topView
{
    LWHouseListViewModel *instance = [[LWHouseListViewModel alloc] init];
    instance.topView = (HYHouseTopView *)topView;
    [instance configure];
    return instance;
}
- (void)setMainTableView:(UITableView *)mainTableView
{
    _mainTableView = mainTableView;
    _mainTableView.mj_header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestListInfor)];
}
- (void)setDataModel:(NSArray *)dataModel
{
    _dataModel = dataModel;
    if (!dataModel) {
        [self requestListInfor];
    }else{
        if (self.delegateSubject) {
            [self.delegateSubject sendNext:nil];
        }
    }
}
- (void)configure
{
    //默认
    _sortType = @"desc";
    _delegateSubject = [RACSubject subject];
    
    ADD_NOTI(changeCityNoti:, HOUSERESOURCE_CITYID_FORCHANGECITY_INHOUMEPAGE_NOTI);
    
    @weakify(self);
    [[self.topView.pricebtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        self.topView.pricebtn.selected = !self.topView.pricebtn.selected;
        self.sortType = self.topView.pricebtn.selected ? @"asc" : @"desc";
        [self requestListInfor];
    }];
    [[self.topView.regionbtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self requestQuYuInforByCityId];
    }];
    [[self.topView.clearBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self.topView updateClearBtnContransWithisShow:NO];
        self.topView.yuJIruzhuTimeTextField.textFiled.text = nil;
        [self requestListInfor];
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    [self.topView.yuJIruzhuTimeTextField addGestureRecognizer:tap];
    [tap.rac_gestureSignal subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
        @strongify(self);
        [self.topView endEditing:YES];
        [HYDatePickerManager showDatePicker:^(id sender) {
            NSArray *firstArr = [sender componentsSeparatedByString:@" "];
            _preStayTime = self.topView.yuJIruzhuTimeTextField.textFiled.text = firstArr.firstObject;
            [self requestListInfor];
            [self.topView updateClearBtnContransWithisShow:YES];
        } DateStyle:DateStyleShowYearMonthDay];
    }];
}

/**
 修改城市列表后，修改筛选条件
 */
- (void)changeCityNoti:(NSNotification *)noti
{
    [_topView.regionbtn setTitle:@"选择区域" forState:UIControlStateNormal];
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
                                          [self.mainTableView.mj_header  endRefreshing];
                                          if (datas.count == 0) {
//                                              [self showTableViewPlaceholder:Empty_Holder];
                                          }
                                      } failureBlock:^(id error, id requestInfo) {
                                          [self.mainTableView.mj_header  endRefreshing];
//                                          [self showTableViewPlaceholder:RequestError_Holder];
                                      }];
}
- (void)handleListDatas:(NSArray *)datas
{
    if (!datas) {
        return;
    }
    NSMutableArray *temp_data = [[NSMutableArray alloc] init];
    for (NSDictionary *dict in datas) {
        HYHouseRescourcesModel *houseRescourcesModel = [HYHouseRescourcesModel modelWithJSON:dict];
        [temp_data addObject:houseRescourcesModel];
    }
    self.dataMutableArray = temp_data;
    [self.mainTableView reloadData];
}

/**
 根据城市ID 获取区域列表
 */
- (void)requestQuYuInforByCityId
{
    NSArray *quyu_loca_Arr =  [HYPublic_LocalData share].QuYu_ByCityId_Arr_M;
    _quyuDatas =  quyu_loca_Arr;
    if (quyu_loca_Arr && quyu_loca_Arr.count > 0) {
        NSMutableArray *items_Ar = [[NSMutableArray alloc] init];
        for (HYQuYuModel *model in quyu_loca_Arr) {
            [items_Ar addObject:model.townName];
        }
        [items_Ar insertObject:@"全部区域" atIndex:0];
        [self showPopViewWithDataArray:items_Ar];
        return;
    }
    PARA_CREART;
    PARA_SET([HYStringTool checkString:[HYPublic_LocalData share].location_City_Id], @"cityId");
    [[HYServiceManager share] postRequestWithurl:GET_QUYU_LIST_BY_CITY_INFOR_URL
                                       paramters:para
                                    successBlock:^(id objc, id requestInfo) {
                                        LWLog(@"-------\nquyu:%@",objc);
                                        _quyuDatas = [NSArray new];
                                        NSMutableArray *tem_Ar = [[NSMutableArray alloc] init];
                                        NSMutableArray *items_Ar = [[NSMutableArray alloc] init];
                                        for (NSDictionary *dic in objc[@"result"][@"list"]) {
                                            HYQuYuModel *model = [HYQuYuModel modelWithJSON:dic];
                                            [items_Ar addObject:model.townName];
                                            [tem_Ar addObject:model];
                                        }
                                        _quyuDatas = tem_Ar;
                                        [HYPublic_LocalData share].QuYu_ByCityId_Arr_M = _quyuDatas;
                                        [items_Ar insertObject:@"全部区域" atIndex:0];
                                        [self showPopViewWithDataArray:items_Ar];
                                    } failureBlock:^(id error, id requestInfo) {
                                        
                                    }];
}

/**
 弹框
 */
- (void)showPopViewWithDataArray:(NSArray *)DataArray
{
    HYHourseChooseListView *listview = [HYHourseChooseListView showChooseListView:DataArray
                                                                    referenceView:_topView.regionbtn
                                                                    callBackBlock:^(id sender) {
                                                                        if([sender integerValue] == 0){
                                                                            _quyuId = nil;
                                                                            [_topView.regionbtn setTitle:@"全部区域" forState:UIControlStateNormal];
                                                                            _topView.regionbtn.selected = NO;
                                                                        }else{
                                                                            HYQuYuModel *quyumodel =         _quyuDatas[[sender integerValue]-1];
                                                                            [_topView.regionbtn setTitle:quyumodel.townName forState:UIControlStateNormal];
                                                                            _topView.regionbtn.selected = NO;
                                                                            _quyuId = quyumodel.customId;
                                                                        }
                                                                        [self requestListInfor];
                                                                    }];
    listview.clickDismissBlock = ^(id sender) {
        _topView.regionbtn.selected = NO;
    };
    _topView.regionbtn.selected = YES;
}

@end
