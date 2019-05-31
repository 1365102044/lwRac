
//
//  LWCreatePassWordViewController.m
//  HaoYuClient
//
//  Created by 刘文强 on 2019/3/18.
//  Copyright © 2019年 LWQ. All rights reserved.
//

#import "LWUpdatePassWordViewController.h"
#import "LWUpdatePwView.h"

@interface LWUpdatePassWordViewController ()

@property (nonatomic, strong)  id extend;
@property (nonatomic, strong) LWUpdatePwView * mainView;

@end

@implementation LWUpdatePassWordViewController


#pragma mark - First.通知

#pragma mark - Second.网络请求
- (void)changePW:(NSDictionary *)para
{
    NSString *urlstr = CHANGE_LOGIN_PASSWORD_URL;
    if ([self.extend integerValue] == 1) {
        urlstr = SET_LOGIN_PASSWORD_URL;
    }
    [[HYServiceManager share] postRequestAnWithurl:urlstr
                                         paramters:para
                                      successBlock:^(id objc, id requestInfo) {
                                          LWLog(@"\n-----------\n\nchangepassword:%@",objc);
                                          ALERT(([self.extend integerValue] == 1) ? @"密码设置成功" :@"密码修改成功");
                                          [self.navigationController popViewControllerAnimated:YES];
                                          NSString *pw = ([self.extend  integerValue] == 1) ? para[@"passWord"] : para[@"newPassWord"];
                                          USERDEFAULTS_SET(pw, USER_INFOR_PASSWORD_KEY);
                                          [[NSUserDefaults standardUserDefaults] synchronize];
                                          POST_NOTI(CREATE_LOGIN_PASSWORD_SUCCESS_KEY, nil);
                                      }];
}
#pragma mark - Third.点击事件

#pragma mark - Fourth.代理方法

#pragma mark - Fifth.视图生命周期
+ (instancetype)updatePassWordVCWithExtend:(id)extend
{
    LWUpdatePassWordViewController *instance = [LWUpdatePassWordViewController new];
    instance.extend = extend;
    return instance;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = HYCOLOR.color_c1;
    self.title =  ([self.extend integerValue] == 1) ? @"设置密码" : @"修改密码";
 
    [self.view addSubview:self.mainView];
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
//        make.height.mas_offset(ADJUST_PERCENT_FLOAT(430));
    }];
    
    WEAKSELF(self);
    self.mainView.callblock = ^(id sender) {
        [weakself changePW:(NSDictionary *)sender];
    };
}

#pragma mark - Sixth.界面配置

#pragma mark - Seventh.懒加载
- (LWUpdatePwView *)mainView
{
    if (!_mainView) {
        _mainView = [LWUpdatePwView updatePwView:[self.extend integerValue]];
    }
    return _mainView;
}

#pragma mark - Eigth.Other

@end
