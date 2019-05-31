//
//  HYYuYueResultViewController.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/12.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYYuYueResultViewController.h"
#import "HYYuYueResultView.h"

@interface HYYuYueResultViewController ()
@property (nonatomic, strong) HYYuYueResultView * mainView;

@end

@implementation HYYuYueResultViewController

#pragma mark - First.通知

#pragma mark - Second.网络请求

#pragma mark - Third.点击事件

#pragma mark - Fourth.代理方法

#pragma mark - Fifth.视图生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"预约结果";
    [self.view addSubview:self.mainView];
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}
#pragma mark - Sixth.界面配置

#pragma mark - Seventh.懒加载
- (HYYuYueResultView*)mainView
{
    if (!_mainView) {
        _mainView = [[HYYuYueResultView alloc] init];
        _mainView.sourceVC = self;
    }
    return _mainView;
}
#pragma mark - Eigth.Other

@end
