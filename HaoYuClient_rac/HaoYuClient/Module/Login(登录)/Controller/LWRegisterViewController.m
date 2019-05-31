//
//  LWRegisterViewController.m
//  HaoYuClient
//
//  Created by 刘文强 on 2019/3/13.
//  Copyright © 2019年 LWQ. All rights reserved.
//

#import "LWRegisterViewController.h"
#import "LWLoginMainView.h"
#import "LWLoginViewModel.h"

@interface LWRegisterViewController ()
@property (nonatomic, strong) LWLoginMainView * mainView;
@property (nonatomic, strong) LWLoginViewModel * registerViewModel;
@end

@implementation LWRegisterViewController


#pragma mark - First.通知

#pragma mark - Second.网络请求

#pragma mark - Third.点击事件

#pragma mark - Fourth.代理方法

#pragma mark - Fifth.视图生命周期
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[HYTimerManager shareTimer] stopTimer];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.fromType == 1 ? @"注册" : @"重置密码";
    
    [self.view addSubview:self.mainView];
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    WEAKSELF(self);
    self.registerViewModel = [LWLoginViewModel createLoginViewModelWithMainView:self.mainView];
    [[self.registerViewModel.delegateSubject takeUntil:self.rac_deallocDisposable]
     subscribeNext:^(id  _Nullable x) {
        [weakself.navigationController popViewControllerAnimated:YES];
    }];
}

#pragma mark - Sixth.界面配置

#pragma mark - Seventh.懒加载
- (LWLoginMainView*)mainView
{
    if (!_mainView) {
        _mainView = [LWLoginMainView registerMainView:self.fromType];
    }
    return _mainView;
}

#pragma mark - Eigth.Other


@end
