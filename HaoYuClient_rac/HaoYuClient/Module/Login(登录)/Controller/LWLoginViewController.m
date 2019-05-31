//
//  LWLoginViewController.m
//  HaoYuClient
//
//  Created by 刘文强 on 2019/3/13.
//  Copyright © 2019年 LWQ. All rights reserved.
//

#import "LWLoginViewController.h"
#import "LWLoginMainView.h"
#import "HYRequstGlobalDataTool.h"
#import "LWLoginViewModel.h"
#import <ReactiveObjC.h>
#import "HYBaseBarButtonItem.h"
@interface LWLoginViewController ()
@property (nonatomic, strong) LWLoginMainView * mainView;
@property (nonatomic, strong) LWLoginViewModel * loginViewModel;

@end

@implementation LWLoginViewController


#pragma mark - First.通知
- (void)clickMainBtnFunc
{
    POST_NOTI(CHANGETABBAR_INDEX_KEY, (@{@"tag":@"100",@"lastIndex":@(_sourceTabbarIndex)}));
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - Second.网络请求

#pragma mark - Third.点击事件

#pragma mark - Fourth.代理方法

#pragma mark - Fifth.视图生命周期
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[HYTimerManager shareTimer] stopTimer];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_mainView updateScrollviewOfferset];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"登录";
    
    [self.view addSubview:self.mainView];
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    /** 1.注册 2 忘记密码 3.登录*/
    WEAKSELF(self);
    self.navigationItem.leftBarButtonItem = [HYBaseBarButtonItem backbarButtonItemWithCallBack:^(id sender) {
        [weakself dismissViewControllerAnimated:YES completion:nil];
    }];
    
    self.loginViewModel = [LWLoginViewModel createLoginViewModelWithMainView:self.mainView];
    [self.loginViewModel.delegateSubject subscribeNext:^(id  _Nullable x) {
        [weakself clickMainBtnFunc];
        if (weakself.sourceTabbarIndex == 3) {
            POST_NOTI(CHANGETABBAR_INDEX_KEY, @"3");
        }
    }];
}
#pragma mark - Sixth.界面配置

#pragma mark - Seventh.懒加载

- (LWLoginMainView*)mainView
{
    if (!_mainView) {
        _mainView = [LWLoginMainView loginMainView];
    }
    return _mainView;
}

#pragma mark - Eigth.Other

@end
