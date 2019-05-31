//
//  HYMineActivityViewController.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/5/24.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYMineActivityViewController.h"
#import "HYActivityTableViewCell.h"
#define  ACTIVITYCELLIDNTIFIER @"ACTIVITYCELLIDNTIFIER"
@interface HYMineActivityViewController ()

@end

@implementation HYMineActivityViewController


#pragma mark - First.通知

#pragma mark - Second.赋值

#pragma mark - Third.点击事件

#pragma mark - Fourth.代理方法
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HYActivityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ACTIVITYCELLIDNTIFIER];
    if(!cell){
        cell = [[HYActivityTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ACTIVITYCELLIDNTIFIER];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.indexPath = indexPath;
    cell.clickBlock = ^(id sender) {
        LWLog(@"======%@",indexPath);
    };
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

#pragma mark - Fifth.视图生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的活动";
    [self setUI];
}
#pragma mark - Sixth.界面配置
- (void)setUI
{
    [self.view addSubview:self.MainTableView];
    self.MainTableView.rowHeight = ADJUST_PERCENT_FLOAT(130);
    self.MainTableView.mj_header = nil;
}

#pragma mark - Seventh.懒加载

#pragma mark - Eigth.Other

@end
