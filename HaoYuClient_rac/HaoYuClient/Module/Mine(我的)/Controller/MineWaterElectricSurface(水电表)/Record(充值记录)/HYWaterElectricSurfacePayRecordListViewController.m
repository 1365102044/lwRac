//
//  HYWaterElectricSurfacePayRecordListViewController.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/8/15.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYWaterElectricSurfacePayRecordListViewController.h"
#import "HYRechargeRecordTableViewCell.h"
#import "HYRequstGlobalDataTool.h"
#define RECHARGERECORDCELLINDIFITER_MORE @"RECHARGERECORDCELLINDIFITER_MORE"
@interface HYWaterElectricSurfacePayRecordListViewController ()<UITableViewDataSource>
@property (nonatomic, assign) id  param;
@property (nonatomic, assign) NSInteger surfaceType;
@end

@implementation HYWaterElectricSurfacePayRecordListViewController

#pragma mark - First.通知

#pragma mark - Second.网络请求
- (void)requestListInfor
{
    if(!_param) return;
    [[HYRequstGlobalDataTool new] getRechargreRecordInforListWithParam:_param
                                                           surfaceType:_surfaceType
                                                         CallBackBlock:^(id sender) {
                                                             [self.dataMutableArray removeAllObjects];
                                                             NSArray *infor = (NSArray *)sender;
                                                             [self handleData:infor];
                                                             [self.MainTableView reloadData];
                                                             [self.MainTableView.mj_header endRefreshing];
                                                         } failureBlock:^(id sender) {
                                                             [self.MainTableView.mj_header endRefreshing];
                                                         }];
}

/**
 处理数据
 */
- (void)handleData:(NSArray *)dataModelArray
{
    if (!dataModelArray || dataModelArray.count == 0) {
        return;
    }
    NSMutableDictionary *temp = [[NSMutableDictionary alloc] init];
    for (HYRechargeRecordListInforModel *recordModel  in dataModelArray) {
        NSArray *date_arr =  [recordModel.rechargeDate componentsSeparatedByString:@"-"];
        if (date_arr.count < 2) {
            return;
        }
        NSString *dateStr =  [NSString stringWithFormat:@"%@-%@",date_arr.firstObject,date_arr[1]];
        if ([temp.allKeys containsObject:dateStr]) {
             HYRechargeRecordBaseInforModel *temp_baseModel = [temp objectForKey:dateStr];
            NSMutableArray * dateModelArr_temp = [[NSMutableArray alloc] initWithArray: temp_baseModel.dateModelArrary];
            [dateModelArr_temp addObject:recordModel];
            temp_baseModel.dateModelArrary = dateModelArr_temp;
        }else{
            NSMutableArray * dateModelArr_temp = [[NSMutableArray alloc] init];
            [dateModelArr_temp addObject:recordModel];
            HYRechargeRecordBaseInforModel *recordBaseModel = [[HYRechargeRecordBaseInforModel alloc] init];
            recordBaseModel.dateModelArrary = dateModelArr_temp;
            recordBaseModel.dateString = dateStr;
            [temp setObject:recordBaseModel forKey:dateStr];
        }
    }
    //排序
    NSArray *tem_dicValues = [temp.allValues sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        HYRechargeRecordBaseInforModel *recordBaseModel1 = obj1;
        HYRechargeRecordBaseInforModel *recordBaseModel2 = obj2;
        NSRange stringRange = NSMakeRange(0, 7);
        
        NSComparisonResult result = [recordBaseModel1.dateString compare:recordBaseModel2.dateString options:(NSCaseInsensitiveSearch) range:stringRange];
        return result == NSOrderedAscending;
    }];
    [self.dataMutableArray addObjectsFromArray:tem_dicValues];
}

#pragma mark - Third.点击事件

#pragma mark - Fourth.代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataMutableArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    HYRechargeRecordBaseInforModel *recordBaseModel = self.dataMutableArray[section];
    return recordBaseModel.dateModelArrary.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HYRechargeRecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:RECHARGERECORDCELLINDIFITER_MORE];
    HYRechargeRecordBaseInforModel *recordBaseModel = self.dataMutableArray[indexPath.section];
    cell.rechargeRecordModel = recordBaseModel.dateModelArrary[indexPath.row];
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *seactionView = [UIView new];
    HYRechargeRecordBaseInforModel *recordBaseModel = self.dataMutableArray[section];
    NSString *sectionContent = recordBaseModel.dateString;
    HYDefaultLabel *sectionLable = [HYDefaultLabel labelWithFont:SYSTEM_MEDIUMFONT(17) text:sectionContent textColor:HYCOLOR.color_c4];
    sectionLable.textAlignment = NSTextAlignmentCenter;
    [seactionView addSubview:sectionLable];
    [sectionLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(seactionView.mas_top).mas_offset(MARGIN/2);
        make.bottom.mas_equalTo(seactionView.mas_bottom).mas_offset(-MARGIN/2);
        make.left.mas_equalTo(seactionView.mas_left).mas_offset(MARGIN);
        make.right.mas_equalTo(seactionView.mas_right).mas_offset(-MARGIN);
//        make.top.bottom.mas_equalTo(seactionView);
    }];
    seactionView.backgroundColor = self.MainTableView.backgroundColor;
    return seactionView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 45;
}
#pragma mark - Fifth.视图生命周期
/**
 dataModelArray    数据模型
 */
+ (instancetype)creatRechargePayRecordListViewControllerWithSurfaceType:(NSInteger )surfaceType
                                                      dataModelArray:(NSArray *)dataModelArray
                                                              extend:(id)extend;
{
    HYWaterElectricSurfacePayRecordListViewController *instance = [[HYWaterElectricSurfacePayRecordListViewController alloc] init];
    instance.surfaceType = surfaceType;
    instance.navigationItem.title  = [NSString stringWithFormat:@"%@充值记录",(surfaceType == 1) ? @"水表" : @"电表" ];
    [instance handleData:dataModelArray];
    instance.param = extend;
    return instance;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self confiUI];
}

#pragma mark - Sixth.界面配置
- (void)confiUI{
    [self.MainTableView registerClass:[HYRechargeRecordTableViewCell class] forCellReuseIdentifier:RECHARGERECORDCELLINDIFITER_MORE];
    self.MainTableView.rowHeight = MARGIN*4;
    [self.view addSubview:self.MainTableView];
    [self.MainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}
#pragma mark - Seventh.懒加载

#pragma mark - Eigth.Other

@end
