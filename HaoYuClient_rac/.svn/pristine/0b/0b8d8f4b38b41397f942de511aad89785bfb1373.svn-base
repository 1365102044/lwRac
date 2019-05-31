//
//  LWHomeHotInforListViewController.m
//  HaoYuClient
//
//  Created by 刘文强 on 2019/5/13.
//  Copyright © 2019年 LWQ. All rights reserved.
//

#import "LWHomeHotInforListViewController.h"
#import "LWHomeHotInforListTableViewCell.h"
#import "HYHomePageModel.h"
#import "HYBannerActivityViewController.h"
static NSString * HOMEHOTINFORINDENTIFITER = @"HOMEHOTINFORINDENTIFITER";

@interface LWHomeHotInforListViewController ()

@end

@implementation LWHomeHotInforListViewController


#pragma mark - First.通知

#pragma mark - Second.网络请求

#pragma mark - Third.点击事件

#pragma mark - Fourth.代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HYBannerActivityViewController *DeatilVC = [[HYBannerActivityViewController alloc] init];
    HYHomePageHotModel *hotModel = self.dataMutableArray[indexPath.row];
    DeatilVC.web_url = hotModel.linkAddress;
    if (!hotModel.linkAddress) return;
    DeatilVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:DeatilVC animated:YES];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataMutableArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LWHomeHotInforListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:HOMEHOTINFORINDENTIFITER];
    if (!cell) {
        cell = [[LWHomeHotInforListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:HOMEHOTINFORINDENTIFITER];
    }
    HYHomePageHotModel *hotmodel = self.dataMutableArray[indexPath.row];
    cell.hotModel = hotmodel;
    return cell;
}
#pragma mark - Fifth.视图生命周期

+ (instancetype)homeHotInforListViewControllerWithDataArray:(NSArray *)dataArray Title:(NSString *)title extend:(id)extend
{
    LWHomeHotInforListViewController *instance = [LWHomeHotInforListViewController new];
    [instance.dataMutableArray addObjectsFromArray:dataArray];
    instance.title = title;
    return instance;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.MainTableView];
    self.MainTableView.rowHeight = ADJUST_PERCENT_FLOAT(140);
    [self.MainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    self.MainTableView.mj_header = nil;
}
#pragma mark - Sixth.界面配置

#pragma mark - Seventh.懒加载

#pragma mark - Eigth.Other

@end
