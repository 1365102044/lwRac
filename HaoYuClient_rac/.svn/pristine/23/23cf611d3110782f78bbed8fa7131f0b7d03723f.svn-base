//
//  LWChangePhoneSucessViewController.m
//  HaoYuClient
//
//  Created by 刘文强 on 2019/4/11.
//  Copyright © 2019年 LWQ. All rights reserved.
//

#import "LWChangePhoneSucessViewController.h"
#import "HYBaseBarButtonItem.h"
@interface LWChangePhoneSucessViewController ()
@property (weak, nonatomic) IBOutlet UILabel *descL;
@property (weak, nonatomic) IBOutlet HYFillLongButton *commitBtn;

@end

@implementation LWChangePhoneSucessViewController

#pragma mark - First.通知

#pragma mark - Second.网络请求

#pragma mark - Third.点击事件

- (IBAction)clickCommitBtn:(id)sender {
    POST_NOTI(CHANGE_ACCOUNT_PHONE_SUCCESS_KEY, nil);
    [self.navigationController popToViewController:self.navigationController.viewControllers[self.navigationController.viewControllers.count-5] animated:YES];
}
#pragma mark - Fourth.代理方法

#pragma mark - Fifth.视图生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"更换手机号";
    self.view.backgroundColor = HYCOLOR.color_c1;
    [_commitBtn setBoundWidth:0 cornerRadius:6];
    
    if (self.PhoneStr.length == 11) {
       NSString *tem = [_PhoneStr ex_replaceStringWithReplaceString:@"*" startLocation:3 lenght:6];
        _descL.text  = [NSString stringWithFormat:@"下次请使用%@登陆",tem];
    }
    __weak typeof(self)weakself = self;
    self.navigationItem.leftBarButtonItem = [HYBaseBarButtonItem backbarButtonItemWithCallBack:^(id sender) {
        [weakself clickCommitBtn:weakself.commitBtn];
    }];
}
#pragma mark - Sixth.界面配置

#pragma mark - Seventh.懒加载

#pragma mark - Eigth.Other

@end
