//
//  HYWaterElectricSurfaceViewController.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/5/24.
//  Copyright © 2018年 LWQ. All rights reserved.
//


#import "HYWaterElectricSurfaceViewController.h"
#import "HYWaterElectricSurfaceListTableViewCell.h"
#import "HYWaterElectricSurfaceDeatilViewController.h"
#import "HYContractModel.h"
#import "HYMineBillViewController.h"
#import "HYChangeLockPwViewController.h"
#import "HYPayDeatilViewController.h"

#define  WATERELECTRICSURFACECELLIDNTIFIER @"WATERELECTRICSURFACECELLIDNTIFIER"
@interface HYWaterElectricSurfaceViewController ()
{
    NSString *titleStr;
}
@end

@implementation HYWaterElectricSurfaceViewController

#pragma mark - First.通知
- (void)requestListInfor
{
    [HYUserInfor_LocalData share].isReHT_SuccessBooL = NO;
    [self.dataMutableArray removeAllObjects];
    PARA_CREART;
    PARA_SET([USERDEFAULTS_GET(USER_INFOR_PHONE) isNullToString], @"phone");
    [[HYServiceManager share] postRequestWithurl:GET_MINEHETONGLISTINFOR_URL
                                       paramters:para
                                    successBlock:^(id objc, id requestInfo) {
                                        LWLog(@"\n\n\nhetonglist:%@",objc);
                                        NSArray *dataArr = objc[@"result"][@"list"];
                                        [[HYUserInfor_LocalData share] saveHeTongInfor:dataArr];
                                        for (NSDictionary *dict in dataArr) {
                                            HYContractModel *hetongmodel = [HYContractModel modelWithJSON:dict];
                                            if([hetongmodel.status integerValue] != 5){
                                                [self.dataMutableArray addObject:hetongmodel];
                                            }
                                        }
                                        [self.MainTableView.mj_header endRefreshing];
                                        if(self.dataMutableArray.count == 0){
                                            [self showTableViewPlaceholder:Empty_Holder];
                                        }
                                    } failureBlock:^(id error, id requestInfo) {
                                        [self.MainTableView.mj_header endRefreshing];
                                        [self showTableViewPlaceholder:RequestError_Holder];
                                    }];
}
#pragma mark - Second.赋值

- (void)setHeTongDataArr:(NSArray *)HeTongDataArr
{
    self.title = @"请选择合同";
    [self.dataMutableArray addObjectsFromArray:HeTongDataArr];
}

#pragma mark - Third.点击事件

#pragma mark - Fourth.代理方法
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HYWaterElectricSurfaceListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:WATERELECTRICSURFACECELLIDNTIFIER];
    if(!cell){
        cell = [[HYWaterElectricSurfaceListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:WATERELECTRICSURFACECELLIDNTIFIER];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.indexPath = indexPath;
    if (self.dataMutableArray.count > 0) {
        HYContractModel *model =  self.dataMutableArray[indexPath.row];
        cell.contractModel = model;
    }
    
    WEAKSELF(self);
    cell.clickBlock = ^(NSIndexPath *indexPath) {
        HYContractModel *heTongModel =  weakself.dataMutableArray[indexPath.row];
        
        // 分散式不能使用水电表、智能门锁 2018年12月25日09:54:54
        if ([heTongModel.isJiZhong integerValue] != 1 && ([weakself.sourceType isEqualToString:@"水表"] ||
                                                            [weakself.sourceType isEqualToString:@"电表"] ||
                                                            [weakself.sourceType isEqualToString:@"智能门锁"])) {
            NSString *alearStr = [NSString stringWithFormat:@"该合同未查询到%@相关信息",weakself.sourceType];
            ALERT(alearStr);
            return;
        }
        
          HYBaseViewController *VC ;
        if ([weakself.sourceType isEqualToString:@"水表"] ||
            [weakself.sourceType isEqualToString:@"电表"]) {
           VC = [HYWaterElectricSurfaceDeatilViewController creatSurfaceDeatilViewController:weakself.sourceType heTongModel:heTongModel];
        }else if ([weakself.sourceType isEqualToString:@"账单"]) {
             VC = [HYMineBillViewController creatBillViewController:heTongModel];
        }else if ([weakself.sourceType isEqualToString:@"智能门锁"]) {
           VC = [HYChangeLockPwViewController  creatChangeLockPwViewController:nil heTongModel:heTongModel];
        }else if ([weakself.sourceType isEqualToString:@"缴费"]) {
             VC = [HYPayDeatilViewController creatPayDeatilViewController:heTongModel];
        }
        [weakself.navigationController pushViewController:VC animated:YES];
    };
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataMutableArray.count;
}

#pragma mark - Fifth.视图生命周期
/**
 跳转水电表
 titleStr  水表、电表
 */
+ (instancetype)pushWaterElectricSurfaceVCwith:(NSString *)titleStr
{
    HYWaterElectricSurfaceViewController *instance = [[HYWaterElectricSurfaceViewController alloc] init];
    instance->titleStr = titleStr;
    return instance;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = titleStr;
    [self setUI];
}

#pragma mark - Sixth.界面配置
- (void)setUI
{
    [self.view addSubview:self.MainTableView];
    self.MainTableView.rowHeight = ADJUST_PERCENT_FLOAT(130);
    [self.MainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

#pragma mark - Seventh.懒加载

#pragma mark - Eigth.Other


@end
