//
//  HYHouseRescourceDeatilViewController.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/10.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYHouseRescourceDeatilViewController.h"
#import "HYHouseRescourceDeatiMainView.h"
@interface HYHouseRescourceDeatilViewController ()
@property (nonatomic, strong) HYHouseRescourceDeatiMainView * MainView;

@end

@implementation HYHouseRescourceDeatilViewController


#pragma mark - First.通知

#pragma mark - Second.网络请求

#pragma mark - Third.点击事件

#pragma mark - Fourth.代理方法

#pragma mark - Fifth.视图生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"公寓详情";
    [self setUI];
}
#pragma mark - Sixth.界面配置
- (void)setUI{
    [self.MainScrollView addSubview:self.MainView];
    self.MainScrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - TABBAR_HIEGHT);
    [self.view addSubview:self.MainScrollView];
    [self.MainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.MainScrollView);
        make.width.mas_offset(SCREEN_WIDTH);
    }];
    self.MainScrollView.showsVerticalScrollIndicator = NO;
    self.MainScrollView.backgroundColor = HYCOLOR.color_c1;
    
}
#pragma mark - Seventh.懒加载
- (HYHouseRescourceDeatiMainView*)MainView
{
    if (!_MainView) {
        _MainView = [[HYHouseRescourceDeatiMainView alloc] init];
    }
    return _MainView;
}
#pragma mark - Eigth.Other

@end
