//
//  LWLoginViewModel.m
//  HaoYuClient
//
//  Created by 刘文强 on 2019/5/31.
//  Copyright © 2019年 LWQ. All rights reserved.
//

#import "LWLoginViewModel.h"
#import "HYRequstGlobalDataTool.h"
#import "LWRegisterXieYiViewController.h"
#import "LWRegisterViewController.h"

@implementation LWLoginViewModel

+ (instancetype)createLoginViewModelWithMainView:(UIView *)mainView
{
    LWLoginViewModel *instance = [[LWLoginViewModel alloc] init];
    instance.mainView = (LWLoginMainView *)mainView;
    [instance confi];
    return instance;
}

- (void)confi
{
    // 监听输入框内容，赋值给模型
    RAC(self.accountModel,phoneofpw) = self.mainView.phone_pwTF.textFiled.rac_textSignal;
    RAC(self.accountModel,pwofpw) = self.mainView.pwTF.textFiled.rac_textSignal;
    RAC(self.accountModel,phoneofcode) = self.mainView.phone_codeTF.textFiled.rac_textSignal;
    RAC(self.accountModel,codeofcode) = self.mainView.codeTF.textFiled.rac_textSignal;
    
    RAC(self.accountModel,phoneofre) = self.mainView.phone_codeTF.textFiled.rac_textSignal;
    RAC(self.accountModel,codeofre) = self.mainView.codeTF.textFiled.rac_textSignal;
    RAC(self.accountModel,pwofre) = self.mainView.setpwTF.textFiled.rac_textSignal;
    
    // 监听 登录方式的切换
    [RACObserve(self.mainView,lastbtn.tag) subscribeNext:^(id  _Nullable x) {
        self.loginType = [x integerValue];
    }];
    // 监听 视图是登录、注册、重置密码
    @weakify(self);
    [RACObserve(self.mainView, viewType) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        self.viewType = [x integerValue];
    }];
    
    // 输入框的合法性
    RACSignal *validPhoneOfpwSignal = [self.mainView.phone_pwTF.textFiled.rac_textSignal map:^id _Nullable(NSString * _Nullable value) {
        return @([self.mainView.phone_pwTF.textFiled.text ex_isMobileNumber]);
    }];
    RACSignal *validpwOfpwSignal = [self.mainView.pwTF.textFiled.rac_textSignal map:^id _Nullable(NSString * _Nullable value) {
        return @(value.length<13 && value.length>5);
    }];
    RACSignal *validCodeSignal = [self.mainView.codeTF.textFiled.rac_textSignal map:^id _Nullable(NSString * _Nullable value) {
        return @(value.length == 6);
    }];
    RACSignal *validCodePhoneSignal = [self.mainView.phone_codeTF.textFiled.rac_textSignal map:^id _Nullable(NSString * _Nullable value) {
        return @([self.mainView.phone_codeTF.textFiled.text ex_isMobileNumber]);
    }];
    RACSignal *validSetPwSignal = [self.mainView.setpwTF.textFiled.rac_textSignal map:^id _Nullable(NSString * _Nullable value) {
        return @(value.length<13 && value.length>5);
    }];
    // 控制发送按钮的可以状态
    [validCodePhoneSignal subscribeNext:^(id  _Nullable x) {
        self.mainView.sendcodebtn.enabled = [x boolValue];
    }];
    
    //根据 输入框内容，判断按钮的状态
    if (self.viewType == 3) {
        RACSignal *validLoginSignal = [RACSignal combineLatest:@[validPhoneOfpwSignal,validpwOfpwSignal,validCodePhoneSignal,validCodeSignal] reduce:^id _Nonnull(NSNumber *ph_pw,NSNumber *pw_pw,NSNumber *ph_code,NSNumber *code_code){
            return @((self.loginType == 1) ? [ph_code boolValue] && [code_code boolValue] : [ph_pw boolValue] && [pw_pw boolValue]);
        }];
        /// 监听登录按钮的状态
//        [validLoginSignal subscribeNext:^(id  _Nullable x) {
//            self.mainView.submitbtn.enabled = [x boolValue];
//        }];
        
    }else{
        RACSignal *validRegisterBtnSignal = [RACSignal combineLatest:@[validCodePhoneSignal,validCodeSignal,validSetPwSignal] reduce:^id _Nonnull(NSNumber *ph_code,NSNumber *code_code,NSNumber *setpw){
            return @([ph_code boolValue] && [code_code boolValue] && [setpw boolValue]);
        }];
        [validRegisterBtnSignal subscribeNext:^(id  _Nullable x) {
            self.mainView.submitRebtn.enabled = [x boolValue];
        }];
        
        // 监听 event
        [[self.mainView rac_signalForSelector:@selector(clickxiyibtn)]
         subscribeNext:^(RACTuple * _Nullable x) {
             LWRegisterXieYiViewController *xieyi = [LWRegisterXieYiViewController new];
             xieyi.title = @"注册协议";
             [self.mainView.currentViewController.navigationController pushViewController:xieyi animated:YES];
         }];
    }
    // 监听 跳转注册事件
    [[self.mainView rac_signalForSelector:@selector(clickfunctionbtn:)]
     subscribeNext:^(RACTuple * _Nullable x) {
         UIButton *btn = x.first;
         [self gotoRegiestVC:btn.tag];
     }];
    
    // 登录事件
    [[self.mainView.submitbtn rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(__kindof UIControl * _Nullable x) {
         [self loginRequest:[self getPram]];
     }];
    
    // 监听发送验证码的事件
    [[self.mainView.sendcodebtn rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(__kindof UIControl * _Nullable x) {
         [self codeRequest];
     }];
    
    [[self.mainView.submitRebtn rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(__kindof UIControl * _Nullable x) {
         [self registerRequest:[self getPram]];
     }];
}

// 验证码
- (void)codeRequest
{
    if (self.viewType == 1) {
        PARA_CREART;
        PARA_SET(self.accountModel.phoneofcode, @"phone");
        [[HYServiceManager share] postRequestWithurl:CHECK_NEW_PHONE_ISREGISTER_URL
                                           paramters:para
                                        successBlock:^(id objc, id requestInfo) {
                                            [self getCode];
                                        }];
    }else{
        [self getCode];
    }
}

// 获取请求参数
- (NSDictionary *)getPram
{
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    if(self.viewType == 1|| self.viewType == 2){
        /** 1：注册、2：重置 */
        NSString *tem = self.viewType == 1 ? @"1":@"2";
        [param setValue:tem forKey:@"operatingState"];
        [param setValue:self.accountModel.phoneofre forKey:@"phone"];
        [param setValue:self.accountModel.codeofre forKey:@"checkCode"];
        [param setValue:self.accountModel.pwofre forKey:@"password"];
    }else{
        if (self.loginType == 1) {
            // 验证码登录
            [param setValue:self.accountModel.phoneofcode forKey:@"phone"];
            [param setValue:self.accountModel.codeofcode forKey:@"checkCode"];
        }else{
            // 密码登录
            [param setValue:self.accountModel.phoneofpw forKey:@"phone"];
            [param setValue:self.accountModel.pwofpw forKey:@"passWord"];
        }
    }
    return param;
}

// 登录
- (void)loginRequest:(NSDictionary *)para
{
    NSString *urlstr = LOGINWITH_PASSWORD_URL;
    if (self.loginType == 1) {
        urlstr = LOGINWITHCODE_URL;
    }
    [HYServiceManager share].notShowMsgAlert = YES;
    [[HYServiceManager share] postRequestAnWithurl:urlstr
                                         paramters:para
                                      successBlock:^(id objc, id requestInfo) {
                                          LWLog(@"\n-----------\n\nlogin:%@",objc);
                                          [[HYUserInfor_LocalData share] saveLoginInfor:objc[@"result"]];
                                          [[HYRequstGlobalDataTool new] requestMessageInforCallBackBlock:nil failureBlock:nil];
                                          
                                          if (self.delegateSubject) {
                                              [self.delegateSubject sendNext:nil];
                                          }
                                      } failureBlock:^(id error, id requestInfo) {
                                          ALERT(@"账号或密码错误");
                                      }];
}

// 注册、重置密码
- (void)registerRequest:(NSDictionary *)para
{
    [HYServiceManager share].notShowMsgAlert = YES;
    [[HYServiceManager share] postRequestAnWithurl:RESISTER_URL
                                         paramters:para
                                      successBlock:^(id objc, id requestInfo) {
                                          LWLog(@"\n-----------\n\nreisgrer:%@",objc);
                                          ALERT( self.viewType == 1 ? @"注册成功":@"密码重置成功");
                                          if (self.delegateSubject) {
                                              [self.delegateSubject sendNext:nil];
                                          }
                                      } failureBlock:^(id error, id requestInfo) {
                                          NSDictionary *dic = [error valueForKey:@"userInfo"];
                                          NSString *msg =  dic[@"errorInfo"];
                                          ALERT(msg);
                                      }];
}

/** 发送验证码 */
- (void)getCode
{
    self.mainView.sendcodebtn.userInteractionEnabled = NO;
    PARA_CREART;
    PARA_SET(self.accountModel.phoneofcode, @"phone");
    [[HYServiceManager share] postRequestAnWithurl:GETLOGINCODE_URL
                                         paramters:para
                                      successBlock:^(id objc, id requestInfo) {
                                          LWLog(@"\n-----------\n\nrequestcode:%@",objc);
                                          self.mainView.sendcodebtn.userInteractionEnabled = YES;
                                          [[HYTimerManager shareTimer] stopTimer];
                                          [[HYTimerManager shareTimer] startTimerWithTimeInterVal:1.0 target:self selector:@selector(cutTime)];
                                          
                                      }failureBlock:^(id error, id requestInfo) {
                                          self.mainView.sendcodebtn.userInteractionEnabled = YES;
                                      }];
}

- (void)cutTime
{
    if (self.mainView.codecount <=0 ) {
        [self.mainView.sendcodebtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [[HYTimerManager shareTimer] stopTimer];
        self.mainView.codecount = 60;
        self.mainView.sendcodebtn.enabled = YES;
    }else{
        self.mainView.sendcodebtn.enabled = NO;
        self.mainView.codecount--;
        [self.mainView.sendcodebtn setTitle:[NSString stringWithFormat:@"%lds",(long)self.mainView.codecount] forState:UIControlStateNormal];
    }
}

// 跳转到注册、重置密码控制器
- (void)gotoRegiestVC:(NSInteger )tag
{
    LWRegisterViewController *revc = [LWRegisterViewController new];
    revc.fromType = tag;
    [self.mainView.ex_viewController.navigationController pushViewController:revc animated:YES];
}

- (LWAccountModel*)accountModel
{
    if (!_accountModel) {
        _accountModel = [[LWAccountModel alloc] init];
    }
    return _accountModel;
}

- (RACSubject*)delegateSubject
{
    if (!_delegateSubject) {
        _delegateSubject = [[RACSubject alloc] init];
    }
    return _delegateSubject;
}
@end
