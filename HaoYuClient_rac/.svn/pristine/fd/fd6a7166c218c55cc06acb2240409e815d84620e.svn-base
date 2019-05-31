//
//  LWValidatePhoneViewController.m
//  HaoYuClient
//
//  Created by 刘文强 on 2019/3/19.
//  Copyright © 2019年 LWQ. All rights reserved.
//

#import "LWValidatePhoneViewController.h"
#import "WLUnitField.h"
#import "LWUpdatePassWordViewController.h"
#import "HYTimerManager.h"
#import "LWChangePhoneSucessViewController.h"
NSInteger downCountNumber = 60;
@interface LWValidatePhoneViewController ()<WLUnitFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *phoneL;
@property (weak, nonatomic) IBOutlet WLUnitField *codeTF;
@property (weak, nonatomic) IBOutlet UILabel *alertL;
@property (nonatomic, assign) NSInteger downCount;
@property (nonatomic, strong) NSString * inputCode;
@property (weak, nonatomic) IBOutlet UILabel *codeErrorL;

@end

@implementation LWValidatePhoneViewController


#pragma mark - First.通知

#pragma mark - Second.网络请求
- (void)checkCodeRequest
{
    PARA_CREART;
    if(_NewPhone)PARA_SET(_NewPhone, @"newPhone");
    if(_inputCode)PARA_SET(_inputCode, @"checkCode");
    NSString *oldPhone = USERDEFAULTS_GET(USER_INFOR_PHONE);
    if(oldPhone) PARA_SET(oldPhone, @"oldPhone");
    [[HYServiceManager share] postRequestAnWithurl:CHANGE_ACCOUNT_PHONE_URL paramters:para successBlock:^(id objc, id requestInfo) {
        USERDEFAULTS_SET(_NewPhone, USER_INFOR_PHONE);
        [[NSUserDefaults standardUserDefaults] synchronize];
        ALERT(@"手机号修改成功！");
//        POST_NOTI(CHANGE_ACCOUNT_PHONE_SUCCESS_KEY, @{@"phone":_NewPhone});
        LWChangePhoneSucessViewController *res = [LWChangePhoneSucessViewController new];
        res.PhoneStr = _NewPhone;
        [self.navigationController pushViewController:res animated:YES];
        [[HYTimerManager shareTimer] stopTimer];
    }failureBlock:^(id error, id requestInfo) {
        _codeTF.text = nil;
        _codeErrorL.hidden = NO;
        [_codeTF becomeFirstResponder];
    }];
}

/**
 请求验证码
 */
- (void)rquestCode {
    
//#ifdef DEBUG
//    self.alertL.text = @"收不到短信？请等到60秒重新获取";
//    [[HYTimerManager shareTimer] startTimerWithTimeInterVal:1 target:self selector:@selector(cutDown)];
//    self.downCount = downCountNumber;
//    self.alertL.textColor = UIColor.grayColor;
//
//    return;
//#else
//
//#endif
    
    PARA_CREART;
    if(!_NewPhone){
        ALERT(@"获取手机号失败");
        return;
    }
    PARA_SET(_NewPhone, @"phone");
    [[HYServiceManager share] postRequestAnWithurl:GETLOGINCODE_URL
                                         paramters:para
                                      successBlock:^(id objc, id requestInfo) {
//                                          LWLog(@"\n-----------\n\nrequestcode:%@",objc);
                                          self.alertL.text = @"收不到短信？请等到60秒重新获取";
                                          [[HYTimerManager shareTimer] startTimerWithTimeInterVal:1 target:self selector:@selector(cutDown)];
                                          self.downCount = downCountNumber;
                                          self.alertL.textColor = UIColor.grayColor;
                                      }];
}

- (void)cutDown
{
    if (_downCount <= 0) {
        self.alertL.userInteractionEnabled = YES;
        [[HYTimerManager shareTimer] stopTimer];
        self.alertL.text = @"重新获取";
        self.alertL.textColor = UIColor.blueColor;
    }else{
        self.alertL.userInteractionEnabled = NO;
        _downCount --;
         self.alertL.text = [NSString stringWithFormat:@"收不到短信？请等到%ld秒重新获取",_downCount];
    }
    NSLog(@"**************_downCount:%ld",(long)_downCount);
}
#pragma mark - Third.点击事件
- (void)clickReGetCode
{
    if ([self.alertL.text isEqualToString:@"重新获取"]) {
        [self rquestCode];
    }
}
#pragma mark - Fourth.代理方法
- (BOOL)unitField:(WLUnitField *)uniField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    _codeErrorL.hidden = YES;
    NSString *text = nil;
    if (range.location >= uniField.text.length) {
        text = [uniField.text stringByAppendingString:string];
    } else {
        text = [uniField.text stringByReplacingCharactersInRange:range withString:string];
    }
    NSLog(@"******>%@", text);
    if (text.length == 6) {
        _inputCode = text;
        [self checkCodeRequest];
    }
    return YES;
}

#pragma mark - Fifth.视图生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"验证手机号";
    _downCount = downCountNumber;
    _codeTF.delegate = self;
    [_codeTF becomeFirstResponder];
    if (self.NewPhone) {
        _phoneL.text = [self.NewPhone ex_replaceStringWithReplaceString:@"*" startLocation:4 lenght:4];
    }
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickReGetCode)];
    [self.alertL addGestureRecognizer:tap];
    
    [self rquestCode];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[HYTimerManager shareTimer] stopTimer];
}
#pragma mark - Sixth.界面配置

#pragma mark - Seventh.懒加载

#pragma mark - Eigth.Other

@end
