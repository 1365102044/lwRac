//
//  HYHouseRescourcesViewController.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/5/21.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYHouseRescourcesViewController.h"
#import "HYHouseRescourcesListTableViewCell.h"
#import "HYHouseRescourceDeatilViewController.h"
#import "HYHouseTopView.h"
#import "HYHourseChooseListView.h"
#import "HYHouseRescourcesModel.h"
#import "HYQuYuModel.h"
#import "HYHomePageModel.h"
#import <malloc/malloc.h>
#import "LWHouseListViewModel.h"

#define  HOUSERESCOURCESLISTCELLIDNTIFIER @"HOUSERESCOURCESLISTCELLIDNTIFIER"
@interface HYHouseRescourcesViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) HYHouseTopView * topView;
/** 首页过来的数据 */
@property (nonatomic, strong) NSArray * dataModel;

@property (nonatomic, strong) LWHouseListViewModel * houseViewModel;

@end

@implementation HYHouseRescourcesViewController

#pragma mark - First.通知


#pragma mark - Second.网络请求

#pragma mark - Third.点击事件

#pragma mark - Fourth.代理方法
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HYHouseRescourcesListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:HOUSERESCOURCESLISTCELLIDNTIFIER];
    if(!cell){
        cell = [[HYHouseRescourcesListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:HOUSERESCOURCESLISTCELLIDNTIFIER];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.indexPath = indexPath;
    HYHouseRescourcesModel *dataModel = self.houseViewModel.dataMutableArray[indexPath.row];
    cell.houseRescourcesModel = dataModel;
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.houseViewModel.dataMutableArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id model = self.houseViewModel.dataMutableArray[indexPath.row];
    NSString * customId ;
    if ([model isKindOfClass:[HYHouseRescourcesModel class]]) {
        HYHouseRescourcesModel *tem_M = model;
        customId = tem_M.customId;
    }else if ([model isKindOfClass:[HYHomePageModel class]]){
        HYHomePageModel *tem_M = model;
        customId = tem_M.itemId;
    }
    HYHouseRescourceDeatilViewController *deatilVC = [[HYHouseRescourceDeatilViewController alloc] init];
    deatilVC.hidesBottomBarWhenPushed = YES;
    deatilVC.houseItemId = customId;
    [self.navigationController pushViewController:deatilVC animated:YES];
}

#pragma mark - Fifth.视图生命周期
+ (instancetype)houseRescourcesViewControllerWithDataModel:(NSArray *)dataModel
                                                    extend:(id)extend
{
    HYHouseRescourcesViewController *instance = [[HYHouseRescourcesViewController alloc] init];
    instance.dataModel = dataModel;
    instance.title = extend[@"title"] ?:@"房源";
    return instance;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.MainTableView.mj_header endRefreshing];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUI];
    
    self.houseViewModel = [LWHouseListViewModel createHouseViewModelBind:self.topView];
    self.houseViewModel.mainTableView = self.MainTableView;
    self.houseViewModel.dataModel = self.dataModel;
    [self.houseViewModel.delegateSubject subscribeNext:^(id  _Nullable x) {
        self.MainTableView.mj_header = nil;
        [self.houseViewModel.dataMutableArray addObjectsFromArray:self.dataModel];
        self.topView.hidden = YES;
        [self.MainTableView  mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.view);
        }];
        [self.MainTableView reloadData];
    }];
}

#pragma mark - Sixth.界面配置
- (void)setUI
{
    [self.view addSubview:self.topView];
    [self.view addSubview:self.MainTableView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top);
        make.left.right.mas_equalTo(self.view);
        make.height.mas_offset(MARGIN*5);
    }];
    [self.MainTableView  mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(self.topView.mas_bottom);
    }];
    self.MainTableView.rowHeight = ADJUST_PERCENT_FLOAT(220);
}

- (HYHouseTopView*)topView
{
    if (!_topView) {
        _topView = [[HYHouseTopView alloc] init];
    }
    return _topView;
}
@end
