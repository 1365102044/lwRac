//
//  HYPayDeatilViewController.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/1.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYPayDeatilViewController.h"
#import "HYPayDeatilHeaderView.h"
#import "HYNoPayBillDiscountTableViewCell.h"
#import "HYBillModel.h"
#import "HYRequstGlobalDataTool.h"
#import "HYPaymentViewController.h"
#import "HYChooseDiscountViewController.h"
#import "HYDiscountModel.h"
#import "LWHud.h"
#define PAYDEATILCELLIDENTIFITER @"PAYDEATILCELLIDENTIFITER"

@interface HYPayDeatilViewController ()<HYNoPayBillProtocol,chooseDiscountDelegate>
{
    dispatch_group_t group;
}
@property (nonatomic, strong) HYPayDeatilHeaderView * MainHeaderView;
/**
 选中的账单
 */
@property (nonatomic, strong) NSMutableArray * seleIdsMutableArray;
@property (nonatomic, strong) HYContractModel *heTongModel;
/**
 获取到的可用优惠券的列表
 */
@property (nonatomic, strong) NSMutableArray * DiscountMutableArray;

/**
 用于筛选 不同的账单可使用的优惠券
 */
@property (nonatomic, strong) NSMutableArray * alearySelDiscMutableArray;

@end

@implementation HYPayDeatilViewController

#pragma mark - First.通知

#pragma mark - Second.网络请求
- (void)requestDatas
{
    group = dispatch_group_create();
    
    [self requestDiscountInfor];
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        [self.MainTableView reloadData];
    });
}

- (void)requestListInfor
{
    [super requestListInfor];
    [self requestDatas];
    
    [self.seleIdsMutableArray removeAllObjects];
    [self.alearySelDiscMutableArray removeAllObjects];
    dispatch_group_enter(group);
    [[HYRequstGlobalDataTool new] requestBillOfNoPayWithindentChengzuId:_heTongModel.chengzuId
                                                          CallBackBlock:^(id sender) {
                                                              NSArray *datas = (NSArray *)sender;
                                                              [self.dataMutableArray addObjectsFromArray:datas];
                                                              dispatch_group_leave(group); [self.MainTableView.mj_header endRefreshing];
                                                              [self.MainTableView reloadData];
                                                          } failureBlock:^(id sender) {
                                                              dispatch_group_leave(group); [self.MainTableView.mj_header endRefreshing];
                                                          }];
}

/**
 获取未使用优惠券列表
 */
- (void)requestDiscountInfor
{
    [self.DiscountMutableArray removeAllObjects];
    
    dispatch_group_enter(group);
    [[[HYRequstGlobalDataTool alloc] init] requestDiscountInforWithChengzuId:_heTongModel.chengzuId
                                                               CallBackBlock:^(id sender) {
                                                                   [self.DiscountMutableArray removeAllObjects];
                                                                   LWLog(@"\n***********优惠券:%@",sender);
                                                                   NSArray *datas = (NSArray *)sender;
                                                                   for (NSDictionary *dic in datas) {
                                                                       [self.DiscountMutableArray addObject:[HYDiscountModel modelWithJSON:dic]];
                                                                   }
                                                                   dispatch_group_leave(group);
                                                               } failureBlock:^(id sender) {
                                                                   dispatch_group_leave(group);
                                                               }];
}
/**
 优惠券
 */
- (NSArray *)getCanUseDiscountWithIndexpath:(NSIndexPath *)indexpath
{
    NSMutableArray *temp = [[NSMutableArray alloc]init];
    NSArray *bill_M_Arr = self.dataMutableArray[indexpath.row];
    HYBillModel *bill_M = bill_M_Arr.firstObject;
    for (HYDiscountModel *disc_M in self.DiscountMutableArray) {
        if ([self.alearySelDiscMutableArray containsObject:disc_M] && ![bill_M.selectDiscModels containsObject:disc_M]) continue;
        NSInteger typecode = [disc_M.ov[@"typecode"] integerValue];
        for (HYBillModel *bill_M in bill_M_Arr) {
            if (bill_M.discUseType != DISCOUNT_NOFUND_TYPE &&
                (typecode == (typecode | bill_M.discUseType)) &&
                ![temp containsObject:disc_M]) {
                [temp addObject:disc_M];
            }
        }
    }
    return temp;
}

#pragma mark - Third.点击事件

- (void)addTap
{
    //账单缴费
    [self.MainHeaderView.bottom_func bk_whenTapped:^{
        if (self.seleIdsMutableArray.count == 0) {
            ALERT(@"请选择要支付的账单");
            return ;
        }
        
        [LWHud show];
        //json
        NSMutableArray *json_arr = [[NSMutableArray alloc] init];
        
        NSInteger bill_count = 0;
        //跳出循环的标识 根据账单的个数
        BOOL isBreakBool = NO;
        for (NSArray *bill_M_arr in self.dataMutableArray) {
            if (isBreakBool) break;
            //选择每期的优惠券
            NSMutableArray *disc_ids_arr_temp = [[NSMutableArray alloc] init];
            //选择每期的账单
            NSMutableArray *bill_ids_arr_temp = [[NSMutableArray alloc] init];
            for (HYBillModel *bill_M in bill_M_arr) {
                if ([self.seleIdsMutableArray containsObject:bill_M.customId]) {
                    for (HYDiscountModel *dis_M in bill_M.selectDiscModels) {
                        [disc_ids_arr_temp addObject:dis_M.customId];
                    }
                    bill_count++;
                    [bill_ids_arr_temp addObject:bill_M.customId];
                    if(bill_count == self.seleIdsMutableArray.count) {isBreakBool = YES; break;}
                }
            }
            if (!(disc_ids_arr_temp.count == 0
                  &&bill_ids_arr_temp.count == 0)) {
                [json_arr addObjectsFromArray:@[@{@"cid":disc_ids_arr_temp,
                                                  @"bid":bill_ids_arr_temp}]];
            }
        }
        
        [LWHud dismiss];
        PARA_CREART;
        if(self.seleIdsMutableArray) PARA_SET(self.seleIdsMutableArray, @"ids");
        PARA_SET([HYStringTool checkString:_heTongModel.deptId], @"deptId");
        if (json_arr) PARA_SET(json_arr, @"json");//json = [@[{"cid":@[],"bid":@[]}],]
        PayMentType type = PAYMENTTYPE_BILLDISCOUNTPAY;
        if (self.alearySelDiscMutableArray == nil ||
            self.alearySelDiscMutableArray.count == 0) {
            type = PAYMENTTYPE_BILLPAY;
        }
        PARA_SET([_heTongModel.houseItemId isNullToString], @"houseItemId");
        [HYPaymentViewController pushPayViewController:self PayMentType:type extend:para];
    }];
    
    /**
     tag : 12 热水表；  11 水表； 10 电费
     */
    WEAKSELF(self);
    _MainHeaderView.clickSurfaceIconBlock = ^(id sender) {
        if ([sender integerValue] == 11 ||
            [sender integerValue] == 12){
            if ([sender integerValue] == 12 &&
                !weakself.heTongModel.hotWaterId) {
                ALERT(@"此房间没有热水表");
                return ;
            }
            PARA_CREART;
            PARA_SET( [sender integerValue] == 12 ? @"4" : @"2", @"num");//水费
            PARA_SET([HYStringTool checkString:weakself.heTongModel.houseId], @"houseId");
            NSString *surfaceId = [sender integerValue] == 12 ? weakself.heTongModel.hotWaterId : weakself.heTongModel.waterId;
            PARA_SET([HYStringTool checkString:surfaceId], @"meterId");
            PARA_SET([HYStringTool checkString:weakself.heTongModel.deptId], @"deptId");
            [HYPaymentViewController pushPayViewController:weakself PayMentType:PAYMENTTYPE_RECHARGE extend:para];
        }else if ([sender integerValue] == 10){
//            NSArray *tem = weakself.dataMutableArray.firstObject;
//            HYBillModel *billModel = tem.firstObject;
            PARA_CREART;
            PARA_SET(@"1", @"num");//电费
            PARA_SET([HYStringTool checkString:weakself.heTongModel.houseId], @"houseId");
            PARA_SET([HYStringTool checkString:weakself.heTongModel.electricityId], @"meterId");
            PARA_SET([HYStringTool checkString:weakself.heTongModel.deptId], @"deptId");
            [HYPaymentViewController pushPayViewController:weakself PayMentType:PAYMENTTYPE_RECHARGE extend:para];
        }
    };
}

#pragma mark - Fourth.代理方法
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HYNoPayBillDiscountTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PAYDEATILCELLIDENTIFITER];
    [cell setindexpath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSArray *temp = (self.dataMutableArray.count > indexPath.row) ? self.dataMutableArray[indexPath.row] : nil;
    HYBillModel *bill_M = temp.firstObject;
    if (![self.seleIdsMutableArray containsObject:bill_M.customId]) {
        bill_M.selectDiscModels = nil;
    }
    [cell setDataArr:temp];
    cell.delegate = self;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataMutableArray.count;
}

- (void)selectCellWithBool:(BOOL)isSelect indexPath:(NSIndexPath *)indexpath
{
    NSArray *temp = self.dataMutableArray[indexpath.row];
    HYNoPayBillDiscountTableViewCell *cell = [self.MainTableView cellForRowAtIndexPath:indexpath];
    HYBillModel *bill_M = temp.firstObject;
    bill_M.cellIsSelect = !bill_M.cellIsSelect;
    
    for (HYBillModel *billModel in temp) {
        if(isSelect){
            
            //添加
            [self.seleIdsMutableArray addObject:billModel.customId];
            //有可用优惠券 显示选择优惠券的按钮
            NSArray *discDatas = [self getCanUseDiscountWithIndexpath:indexpath];
            if (discDatas.count > 0) {
                [cell.billView updateConsWithisShow:YES];
            }else{
                [cell.billView updateConsWithisShow:NO];
            }
            [self.MainTableView reloadData];
        }else{
            //存在 就移除
            if([self.seleIdsMutableArray containsObject:billModel.customId]){
                [self.seleIdsMutableArray removeObject:billModel.customId];
            }
            //选中账单、优惠券后，取消账单，同时移出优惠券标识和账单数据中优惠券数据
            NSArray *discDatas = [self getCanUseDiscountWithIndexpath:indexpath];
            [cell.billView updateConsWithisShow:NO];
            [cell.billView setDiscountDatas:nil];
            if (discDatas.count > 0) {
                HYBillModel *bill_M = self.dataMutableArray[indexpath.row][0];
                NSArray *disc_M_arr = bill_M.selectDiscModels;
                for (HYDiscountModel *disc_M in disc_M_arr) {
                    disc_M.isSelect = NO;
                    if ([self.alearySelDiscMutableArray containsObject:disc_M]) {
                        [self.alearySelDiscMutableArray removeObject:disc_M];
                    }
                }
                bill_M.selectDiscModels = nil;
            }
            [self.MainTableView reloadData];
        }
    }
}
/**
 点击选择优惠券按钮
 */
- (void)refreshTableForDiscWithIndexpath:(NSIndexPath *)indexpath
{
    NSArray *discDatas = [self getCanUseDiscountWithIndexpath:indexpath];
    if (discDatas.count == 0 ||discDatas == nil) {
        ALERT(@"没有可选的剩余优惠券");
        return;
    }
    HYChooseDiscountViewController *chooseDiscVC = [HYChooseDiscountViewController creatChooseDiscountVCWithDatas:discDatas sourceVC:self extend:nil];
    chooseDiscVC.delegate = self;
    chooseDiscVC.indexpath = indexpath;
    [self.navigationController pushViewController:chooseDiscVC animated:YES];
}

#pragma chooseDicountDelegate --------
/**
 选择优惠券后
 */
- (void)alearySelectDicount:(NSArray *)discounts indexPath:(NSIndexPath *)indexPath
{
    //如果取消，移出本页的alearySelDiscMutableArray
    NSArray *bill_M_arr = self.dataMutableArray[indexPath.row];
    HYBillModel *bill_M = bill_M_arr.firstObject;
    for (HYDiscountModel *dis_M in bill_M.selectDiscModels) {
        if ([self.alearySelDiscMutableArray containsObject:dis_M]) [self.alearySelDiscMutableArray removeObject:dis_M];
    }
    
    //更新优惠券的数数据模型
    for (HYDiscountModel *discM in discounts) {
        if (![self.alearySelDiscMutableArray containsObject:discM]) {
            [self.alearySelDiscMutableArray addObject:discM];
        }
    }
    //更新账单数据
    NSArray *temp_sel = self.dataMutableArray[indexPath.row];
    HYBillModel *billM = temp_sel.firstObject;
    //覆盖旧值
    billM.selectDiscModels = discounts;
    
    HYNoPayBillDiscountTableViewCell *cell = [self.MainTableView cellForRowAtIndexPath:indexPath];
    [cell.billView setDiscountDatas:discounts];
    [self.MainTableView reloadData];
}

#pragma mark - Fifth.视图生命周期
+ (instancetype)creatPayDeatilViewController:(HYContractModel *)heTongModel
{
    HYPayDeatilViewController *instance = [[HYPayDeatilViewController alloc] init];
    instance.heTongModel =  heTongModel;
    return instance;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"缴费/充值";
    [self setUI];
    [self requestListInfor];
    [self addTap];
    self.MainHeaderView.contractModel = _heTongModel;
    
    /**
     支付成功后，刷新账单
     */
    ADD_NOTI(paySucessRefreshBill:, PAYMENT_AFTER_REFRESH_BILLLIST_KEY);
}

- (void)paySucessRefreshBill:(NSNotification *)noti
{
    [self requestListInfor];
}

#pragma mark - Sixth.界面配置
- (void)setUI
{
    [self.MainTableView registerClass:[HYNoPayBillDiscountTableViewCell class] forCellReuseIdentifier:PAYDEATILCELLIDENTIFITER];
    self.MainTableView.rowHeight = UITableViewAutomaticDimension;
    self.MainTableView.estimatedRowHeight = ADJUST_PERCENT_FLOAT(150);
    self.MainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.MainTableView.backgroundColor = HYCOLOR.color_c1;
    [self.view addSubview:self.MainTableView];
    self.MainTableView.tableHeaderView = self.MainHeaderView;
    self.MainTableView.tableHeaderView.height = ADJUST_PERCENT_FLOAT(400);
    [self.MainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

#pragma mark - Seventh.懒加载
- (HYPayDeatilHeaderView*)MainHeaderView
{
    if (!_MainHeaderView) {
        _MainHeaderView                 = [[HYPayDeatilHeaderView alloc] init];
        _MainHeaderView.backgroundColor = HYCOLOR.color_c1;
        _MainHeaderView.viewController  = self;
    }
    return _MainHeaderView;
}

- (NSMutableArray*)seleIdsMutableArray
{
    if (!_seleIdsMutableArray) {
        _seleIdsMutableArray = [[NSMutableArray alloc] init];
    }
    return _seleIdsMutableArray;
}
- (NSMutableArray*)DiscountMutableArray
{
    if (!_DiscountMutableArray) {
        _DiscountMutableArray = [[NSMutableArray alloc] init];
    }
    return _DiscountMutableArray;
}
- (NSMutableArray*)alearySelDiscMutableArray
{
    if (!_alearySelDiscMutableArray) {
        _alearySelDiscMutableArray = [[NSMutableArray alloc] init];
    }
    return _alearySelDiscMutableArray;
}
#pragma mark - Eigth.Other


@end
