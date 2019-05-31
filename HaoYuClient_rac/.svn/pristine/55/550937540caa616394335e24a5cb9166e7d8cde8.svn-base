//
//  HYZhiMengLockViewController.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/5/24.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYZhiMengLockViewController.h"
#import "HYDoorLockTableViewCell.h"

#define  DOORLAOCKIDENTIFITER @"DOORLAOCKIDENTIFITER"

@interface HYZhiMengLockViewController ()

@end

@implementation HYZhiMengLockViewController


#pragma mark - First.通知

#pragma mark - Second.赋值

#pragma mark - Third.点击事件

#pragma mark - Fourth.代理方法
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HYDoorLockTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:DOORLAOCKIDENTIFITER];
    if (!cell) {
        cell  = [[HYDoorLockTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:DOORLAOCKIDENTIFITER];
    }
    cell.indexPath = indexPath;
    cell.clickBlock = ^(NSIndexPath *indexPath) {
      ALERT_MSG(@"功能开发中...");
    };
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

#pragma mark - Fifth.视图生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"智能门锁";
    
    [self.view addSubview:self.MainTableView];
     self.MainTableView.rowHeight = ADJUST_PERCENT_FLOAT(165);
}
#pragma mark - Sixth.界面配置

#pragma mark - Seventh.懒加载

#pragma mark - Eigth.Other

@end
