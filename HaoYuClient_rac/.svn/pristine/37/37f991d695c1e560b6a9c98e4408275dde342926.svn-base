//
//  LWInputNewPhoneViewController.m
//  HaoYuClient
//
//  Created by 刘文强 on 2019/4/1.
//  Copyright © 2019年 LWQ. All rights reserved.
//
#import "LWInputNewPhoneViewController.h"
#import "LWTFHandler.h"
#import "LWValidatePhoneViewController.h"
@interface LWInputNewPhoneViewController ()
@property (weak, nonatomic) IBOutlet UITextField *inputPhoneTF;
@property (weak, nonatomic) IBOutlet HYFillLongButton *nextBtn;

@end

@implementation LWInputNewPhoneViewController


#pragma mark - First.通知

#pragma mark - Second.网络请求
/**
 检查手机号是否已经注册过
 */
- (void)checkPhoneRequest:(NSDictionary *)para
{
    [[HYServiceManager share] postRequestWithurl:CHECK_NEW_PHONE_ISREGISTER_URL
                                       paramters:para
                                    successBlock:^(id objc, id requestInfo) {
                                        LWValidatePhoneViewController *vc = [LWValidatePhoneViewController new];
                                        vc.NewPhone = self.inputPhoneTF.text;
                                        [self.navigationController pushViewController:vc animated:YES];
                                    }];
}
#pragma mark - Third.点击事件

- (IBAction)clickNextBtn:(id)sender {
    
    [self.inputPhoneTF endEditing:YES];
    
    NSString *oldphone = USERDEFAULTS_GET(USER_INFOR_PHONE);
    if ([self.inputPhoneTF.text isEqualToString:oldphone]) {
        ALERT(@"新号与老号不能一致！");
        return;
    }
    
    if (![self.inputPhoneTF.text ex_isMobileNumber]) {
        ALERT(@"手机号格式错误！");
        return;
    }
    [self checkPhoneRequest:@{@"phone":self.inputPhoneTF.text}];
}
#pragma mark - Fourth.代理方法
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
#pragma mark - Fifth.视图生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    self.title = @"更换手机号";
    self.view.backgroundColor = HYCOLOR.color_c1;
   
    [self.nextBtn setBoundWidth:0 cornerRadius:6 boardColor:HYCOLOR.color_c0];
    
    self.inputPhoneTF.keyboardType = UIKeyboardTypeNumberPad;
//        [self.inputPhoneTF becomeFirstResponder];
    [LWTFHandler handleTextFieldLenghtLimitWithTF:self.inputPhoneTF maxCount:@(11)];
    [LWTFHandler handleTextFieldRelationButtonStateWithTF:@[_inputPhoneTF] BT:_nextBtn];
    
}

#pragma mark - Sixth.界面配置

#pragma mark - Seventh.懒加载

#pragma mark - Eigth.Other

@end
