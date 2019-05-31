//
//  HYTouSuJianYiViewController.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/5/24.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYTouSuJianYiViewController.h"
#import "HYTouSuJianYiMainView.h"

@interface HYTouSuJianYiViewController ()
@property (nonatomic, copy) HYTouSuJianYiMainView * mainView;

@end

@implementation HYTouSuJianYiViewController


#pragma mark - First.通知

#pragma mark - Second.赋值

#pragma mark - Third.点击事件

#pragma mark - Fourth.代理方法

#pragma mark - Fifth.视图生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"投诉建议";
    [self setUI];
}
#pragma mark - Sixth.界面配置
- (void)setUI
{
    [self.MainScrollView addSubview:self.mainView];
    [self.view addSubview:self.MainScrollView];
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(SCREEN_WIDTH);
        make.left.right.bottom.mas_equalTo(self.MainScrollView);
        make.top.mas_equalTo(self.view.mas_top).mas_offset(NAVIGATOR_HEIGHT);
    }];
    [self.MainScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    self.MainScrollView.backgroundColor = HYCOLOR.color_c1;
}

#pragma mark - Seventh.懒加载
- (HYTouSuJianYiMainView*)mainView
{
    if (!_mainView) {
        _mainView = [[HYTouSuJianYiMainView alloc] init];
    }
    return _mainView;
}
#pragma mark - Eigth.Other


@end
