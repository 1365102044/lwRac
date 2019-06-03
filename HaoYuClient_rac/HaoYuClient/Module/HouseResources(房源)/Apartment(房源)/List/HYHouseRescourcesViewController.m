//
//  HYHouseRescourcesViewController.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/5/21.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYHouseRescourcesViewController.h"
#import "HYHouseRescourceDeatilViewController.h"
#import "HYHouseTopView.h"
#import "LWHouseListTableViewManager.h"

@interface HYHouseRescourcesViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) HYHouseTopView * topView;
/** 首页过来的数据 */
@property (nonatomic, strong) NSArray * dataModel;
@property (nonatomic, strong) LWHouseListViewModel * houseViewModel;
@property (nonatomic, strong) LWHouseListTableViewManager * tableViewDelegateManager;

@end

@implementation HYHouseRescourcesViewController

#pragma mark - First.通知

#pragma mark - Second.网络请求

#pragma mark - Third.点击事件

#pragma mark - Fourth.代理方法

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
    self.MainTableView.dataSource = self.tableViewDelegateManager;
    self.MainTableView.delegate = self.tableViewDelegateManager;
    self.houseViewModel.dataModel = self.dataModel;
    self.MainTableView.mj_header = [MJRefreshGifHeader headerWithRefreshingTarget:self.houseViewModel refreshingAction:@selector(requestListInfor)];
    if (self.houseViewModel.dataModel) {
        self.MainTableView.mj_header = nil;
        self.topView.hidden = YES;
        [self.MainTableView  mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.view);
        }];
    }
    @weakify(self);
    [RACObserve(self.houseViewModel, dataMutableArray) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
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
        _topView = [HYHouseTopView createTopViewBindViewModel:self.houseViewModel];
    }
    return _topView;
}
- (LWHouseListViewModel *)houseViewModel
{
    if (!_houseViewModel) {
        _houseViewModel = [[LWHouseListViewModel alloc] init];
        @weakify(self);
        [_houseViewModel.endRefreshSubject subscribeNext:^(id  _Nullable x) {
            @strongify(self);
            [self.MainTableView.mj_header endRefreshing];
        }];
        [_houseViewModel.noDataSubject subscribeNext:^(id  _Nullable x) {
            [self showTableViewPlaceholder:[x integerValue]];
        }];
    }
    return _houseViewModel;
}
- (LWHouseListTableViewManager*)tableViewDelegateManager
{
    if (!_tableViewDelegateManager) {
        _tableViewDelegateManager = [LWHouseListTableViewManager createListTableViewManagerBindViewModel:self.houseViewModel];
        @weakify(self);
        [_tableViewDelegateManager.pushVcSubject subscribeNext:^(id  _Nullable x) {
            @strongify(self);
            HYHouseRescourceDeatilViewController *deatilVC = [[HYHouseRescourceDeatilViewController alloc] init];
            deatilVC.hidesBottomBarWhenPushed = YES;
            deatilVC.houseItemId = x;
            [self.navigationController pushViewController:deatilVC animated:YES];
        }];
    }
    return _tableViewDelegateManager;
}
@end
