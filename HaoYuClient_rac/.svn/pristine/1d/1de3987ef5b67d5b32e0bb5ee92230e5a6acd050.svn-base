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

#define  HOUSERESCOURCESLISTCELLIDNTIFIER @"HOUSERESCOURCESLISTCELLIDNTIFIER"

@interface HYHouseRescourcesViewController ()

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
    cell.clickBlock = ^(id sender) {
        HYHouseRescourceDeatilViewController *deatilVC = [[HYHouseRescourceDeatilViewController alloc] init];
        deatilVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:deatilVC animated:YES];
    };
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
#pragma mark - Fifth.视图生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"公寓";
    [self setUI];
}
#pragma mark - Sixth.界面配置
- (void)setUI
{
    [self.view addSubview:self.MainTableView];
    [self.MainTableView  mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    self.MainTableView.rowHeight = ADJUST_PERCENT_FLOAT(220);
    self.MainTableView.mj_header = nil;
}

@end
