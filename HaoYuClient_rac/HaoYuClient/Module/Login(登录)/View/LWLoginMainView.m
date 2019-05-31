
//
//  LWLoginMainView.m
//  HaoYuClient
//
//  Created by 刘文强 on 2019/3/13.
//  Copyright © 2019年 LWQ. All rights reserved.
//

#import "LWLoginMainView.h"
#import "HYFillLongButton.h"
#import "LWRegisterViewController.h"
#import "HYAttributedStringLabel.h"
#import "LWRegisterXieYiViewController.h"

@interface LWLoginMainView ()

@property (nonatomic, strong) HYBaseView * sliderview;
@property (nonatomic, strong) UIScrollView * scrollerview;
@property (nonatomic, strong) HYBaseView * chooserview;
@property (nonatomic, strong) HYBaseView * bottomView;
@property (nonatomic, strong) HYBaseView * bottomReView;

@property (nonatomic, strong) HYBaseView * pw_phoneview;
@property (nonatomic, strong) HYBaseView * code_phoneview;

@end

@implementation LWLoginMainView

- (void)updateScrollviewOfferset
{
    self.sliderview.centerX = self.lastbtn.centerX;
    [self.scrollerview setContentOffset:CGPointMake(SCREEN_WIDTH*self.lastbtn.tag, 1)];
}

+ (instancetype)registerMainView:(NSInteger)mainType
{
    LWLoginMainView *instance = [LWLoginMainView new];
    instance.viewType = mainType;
    instance.codecount = 60;
    [instance confiRegisterUI];
    return instance;
}

+ (instancetype)loginMainView
{
    LWLoginMainView *instance = [LWLoginMainView new];
    instance.viewType = 3;
    instance.codecount = 60;
    [instance confiMainUI];
    return instance;
}

/** 注册界面UI */
- (void)confiRegisterUI
{
    [self addSubviews:@[self.code_phoneview,self.bottomReView]];
    [self.code_phoneview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.mas_top).offset(60);
    }];
    [self.code_phoneview addSubview:self.setpwTF];
    [self.setpwTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_codeTF);
        make.top.equalTo(_codeTF.mas_bottom).offset(10);
        make.height.mas_offset(50);
        make.bottom.equalTo(self.code_phoneview).offset(-5);
    }];
    [self.bottomReView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.code_phoneview.mas_bottom).offset(15);
    }];
    
    [self addbottomLine:self referviews:@[self.setpwTF]];
    
}

/** 登录界面UI */
- (void)confiMainUI
{
    [self addSubviews:@[self.chooserview,self.scrollerview,self.bottomView]];
    [self.chooserview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.mas_top).offset(10);
    }];
    [self.scrollerview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.chooserview.mas_bottom).offset(20);
        make.height.offset(150);
    }];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.scrollerview.mas_bottom).offset(40);
    }];
    
    self.phone_pwTF.textFiled.text = USERDEFAULTS_GET(USER_INFOR_PHONE);
    
}

/** 切换登录方式 */
- (void)clickChooserBtn:(HYDefaultButton *)sender
{
    [UIView animateWithDuration:0.25 animations:^{
        self.sliderview.centerX = sender.centerX;
        [self.scrollerview setContentOffset:CGPointMake(SCREEN_WIDTH*sender.tag, 1)];
    }];
    
    self.lastbtn.selected = NO;
    sender.selected = YES;
    self.lastbtn = sender;
    if (self.lastbtn.tag == 1) {
        [_phone_codeTF.textFiled becomeFirstResponder];
    }else{
        [_phone_pwTF.textFiled becomeFirstResponder];
    }
}

- (HYBaseView*)chooserview
{
    if (!_chooserview) {
        _chooserview = [[HYBaseView alloc] init];
        HYDefaultButton *pw_login_btn = [HYDefaultButton buttonWithTitleStringKey:@"密码登录" titleColor:UIColor.blackColor titleFont:SYSTEM_REGULARFONT(13) target:self selector:@selector(clickChooserBtn:)];
        pw_login_btn.tag = 0;
        [pw_login_btn setTitleColor:UIColor.redColor forState:UIControlStateSelected];
        pw_login_btn.selected = YES;
        self.lastbtn = pw_login_btn;
        
        HYDefaultButton *code_login_btn = [HYDefaultButton buttonWithTitleStringKey:@"快捷登录" titleColor:UIColor.blackColor titleFont:SYSTEM_REGULARFONT(13) target:self selector:@selector(clickChooserBtn:)];
        code_login_btn.tag = 1;
        [code_login_btn setTitleColor:UIColor.redColor forState:UIControlStateSelected];
        
        self.sliderview = [HYBaseView new];
        self.sliderview.backgroundColor = UIColor.redColor;
        [_chooserview addSubviews:@[pw_login_btn,code_login_btn,self.sliderview]];
        
        [pw_login_btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_offset(CGSizeMake(SCREEN_WIDTH/2, 40));
            make.left.top.equalTo(_chooserview);
        }];
        [code_login_btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_offset(CGSizeMake(SCREEN_WIDTH/2, 40));
            make.right.top.equalTo(_chooserview);
        }];
        [self.sliderview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_offset(CGSizeMake(80, 1));
            make.top.equalTo(pw_login_btn.mas_bottom).offset(2);
            make.centerX.equalTo(pw_login_btn.mas_centerX);
            make.bottom.equalTo(_chooserview.mas_bottom).offset(-1);
        }];
    }
    return _chooserview;
}


- (UIScrollView*)scrollerview
{
    if (!_scrollerview) {
        _scrollerview = [[UIScrollView alloc] init];
        _scrollerview.contentSize = CGSizeMake(SCREEN_WIDTH *2, 1);
        _scrollerview.showsVerticalScrollIndicator = NO;
        _scrollerview.showsHorizontalScrollIndicator = NO;
        _scrollerview.scrollEnabled = NO;
        [_scrollerview addSubviews:@[self.pw_phoneview,self.code_phoneview]];
        
        [_pw_phoneview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.offset(SCREEN_WIDTH);
            make.height.offset(150);
            make.left.top.bottom.equalTo(_scrollerview);
        }];
        [_code_phoneview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.offset(SCREEN_WIDTH);
            make.height.equalTo(_pw_phoneview);
            make.top.equalTo(_scrollerview);
            make.bottom.equalTo(_scrollerview.mas_bottom).offset(0);
            make.left.equalTo(_scrollerview.mas_left).offset(SCREEN_WIDTH);
        }];
    }
    return _scrollerview;
}

- (HYBaseView*)pw_phoneview
{
    if (!_pw_phoneview) {
        _pw_phoneview = [[HYBaseView alloc] init];
        
        _phone_pwTF = [HYDefaultTextField creatDefaultTextField:@"请输入手机号" font:SYSTEM_REGULARFONT(15) textColor:HYCOLOR.color_c4];
        _pwTF = [HYDefaultTextField creatDefaultTextField:@"请输入密码" font:SYSTEM_REGULARFONT(15) textColor:HYCOLOR.color_c4];
        _phone_pwTF.maxCount = 11;
        _pwTF.maxCount = 12;
        _pwTF.textFiled.secureTextEntry = YES;
        _phone_pwTF.textFiled.keyboardType = UIKeyboardTypeNumberPad;
        [_pw_phoneview addSubviews:@[_pwTF,_phone_pwTF]];
        
        [_phone_pwTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_pw_phoneview.mas_left).offset(30);
            make.right.equalTo(_pw_phoneview.mas_right).offset(-30);
            make.top.equalTo(_pw_phoneview.mas_top);
            make.height.offset(50);
        }];
        [_pwTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(_phone_pwTF);
            make.top.equalTo(_phone_pwTF.mas_bottom).offset(10);
            make.height.equalTo(_phone_pwTF);
            //            make.bottom.equalTo(_pw_phoneview.mas_bottom).offset(-5);
        }];
        
        [self addbottomLine:_pw_phoneview referviews:@[_phone_pwTF,_pwTF]];
    }
    return _pw_phoneview;
}

- (HYBaseView*)code_phoneview
{
    if (!_code_phoneview) {
        _code_phoneview = [[HYBaseView alloc] init];
        _phone_codeTF = [HYDefaultTextField creatDefaultTextField:@"请输入手机号" font:SYSTEM_REGULARFONT(15) textColor:HYCOLOR.color_c4];
        _codeTF = [HYDefaultTextField creatDefaultTextField:@"请输入验证码" font:SYSTEM_REGULARFONT(15) textColor:HYCOLOR.color_c4];
        _phone_codeTF.maxCount = 11;
        _codeTF.maxCount = 6;
        _phone_codeTF.textFiled.keyboardType = UIKeyboardTypeNumberPad;
        _codeTF.textFiled.keyboardType = UIKeyboardTypeNumberPad;
        _sendcodebtn = [HYDefaultButton buttonWithTitleStringKey:@"获取验证码" titleColor:UIColor.blackColor titleFont:SYSTEM_REGULARFONT(13) target:self selector:nil];
        [_sendcodebtn setBoundWidth:1 cornerRadius:4 boardColor:HYCOLOR.color_c4];
        
        UIView *tembgview = UIView.new;
        [_code_phoneview addSubviews:@[_codeTF,_phone_codeTF,tembgview,_sendcodebtn]];
        
        [_phone_codeTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_code_phoneview.mas_left).offset(30);
            make.right.equalTo(_code_phoneview.mas_right).offset(-30);
            make.top.equalTo(_code_phoneview.mas_top);
            make.height.offset(50);
        }];
        [_codeTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(_phone_codeTF);
            make.top.equalTo(_phone_codeTF.mas_bottom).offset(10);
            make.height.equalTo(_phone_codeTF);
            //            make.bottom.equalTo(_code_phoneview.mas_bottom).offset(-5);
        }];
        [_sendcodebtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_codeTF.mas_right).offset(2);
            make.centerY.equalTo(_codeTF.mas_centerY);
            make.size.mas_offset(CGSizeMake(ADJUST_PERCENT_FLOAT(80), ADJUST_PERCENT_FLOAT(30)));
        }];
        [tembgview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_sendcodebtn);
            make.top.bottom.right.equalTo(_codeTF);
        }];
        [self addbottomLine:_code_phoneview referviews:@[_phone_codeTF,_codeTF]];
    }
    return _code_phoneview;
}
- (HYBaseView*)bottomView
{
    if (!_bottomView) {
        _bottomView = [[HYBaseView alloc] init];
        
        HYFillLongButton *submitbtn = [HYFillLongButton buttonCorWithTitleStringKey:@"登录" target:self selector:nil];
        _submitbtn = submitbtn;
        
        HYDefaultButton *forgetpwbtn = [HYDefaultButton buttonWithTitleStringKey:@"忘记密码" titleColor:UIColor.blueColor titleFont:SYSTEM_REGULARFONT(12) target:self selector:@selector(clickfunctionbtn:)];
        forgetpwbtn.tag = 2;
        HYDefaultButton *registerbtn = [HYDefaultButton buttonWithTitleStringKey:@"去注册" titleColor:UIColor.blueColor titleFont:SYSTEM_REGULARFONT(12) target:self selector:@selector(clickfunctionbtn:)];
        registerbtn.tag = 1;
        HYDefaultLabel *orlable = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(14) text:@"or" textColor:UIColor.blackColor];
        
        [_bottomView addSubviews:@[submitbtn,forgetpwbtn,registerbtn,orlable]];
        
        [submitbtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_bottomView.mas_left).offset(30);
            make.right.equalTo(_bottomView.mas_right).offset(-30);
            make.top.equalTo(_bottomView.mas_top);
            make.height.offset(40);
        }];
        
        [orlable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_bottomView.mas_centerX);
            make.top.equalTo(submitbtn.mas_bottom).offset(20);
        }];
        [forgetpwbtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_offset(CGSizeMake(80, 30));
            make.right.equalTo(orlable.mas_left).offset(-5);
            make.centerY.equalTo(orlable.mas_centerY);
            make.bottom.equalTo(_bottomView.mas_bottom).offset(-5);
        }];
        [registerbtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_offset(CGSizeMake(80, 30));
            make.left.equalTo(orlable.mas_right).offset(5);
            make.centerY.equalTo(orlable.mas_centerY);
        }];
    }
    return _bottomView;
}

- (HYBaseView*)bottomReView
{
    if (!_bottomReView) {
        _bottomReView = [[HYBaseView alloc] init];
        
        NSString *substr = @"同意协议并注册";
        if (self.viewType == 2) {
            substr = @"重置密码";
        }
        
        HYFillLongButton *submitbtn = [HYFillLongButton buttonCorWithTitleStringKey:substr target:self selector:nil];
        _submitRebtn = submitbtn;
        HYAttributedStringLabel *xiyiL= [HYAttributedStringLabel labelWithFont:SYSTEM_REGULARFONT(14) text:@"" textColor:HYCOLOR.color_c4];
        [xiyiL setAttributedStringWithContentArray:@[@{@"color" : HYCOLOR.color_c4,
                                                       @"content" : @"已阅读并同意",
                                                       @"size" : SYSTEM_REGULARFONT(13),
                                                       @"lineSpacing": @1
                                                       },
                                                     @{@"color" : UIColor.blueColor,
                                                       @"content" : @"《好寓注册协议》",
                                                       @"size" : SYSTEM_REGULARFONT(13),
                                                       @"lineSpacing": @1
                                                       },]];
        xiyiL.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickxiyibtn)];
        [xiyiL addGestureRecognizer:tap];
        
        HYDefaultLabel *alertL = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(12) text:@"密码设置只能是英文和数字，长度为6~12位" textColor:UIColor.grayColor];
        alertL.textAlignment = NSTextAlignmentCenter;
        
        [_bottomReView addSubviews:@[submitbtn,xiyiL,alertL]];
        [alertL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_bottomReView.mas_top);
            make.left.equalTo(_bottomReView.mas_left).offset(30);
            make.right.equalTo(_bottomReView.mas_right).offset(-30);
        }];
        [submitbtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_bottomReView.mas_left).offset(30);
            make.right.equalTo(_bottomReView.mas_right).offset(-30);
            make.top.equalTo(alertL.mas_bottom).offset(30);
            make.height.offset(40);
        }];
        [xiyiL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(submitbtn.mas_right);
            make.top.equalTo(submitbtn.mas_bottom).offset(15);
            make.height.offset(30);
            make.bottom.equalTo(_bottomReView.mas_bottom).offset(-5);
        }];
        
        if (self.viewType == 2) {
            xiyiL.hidden = YES;
        }
    }
    return _bottomReView;
}

- (void)addbottomLine:(HYBaseView *)superview referviews:(NSArray *)referviews
{
    for (UIView *referview in referviews) {
        HYBaseView *line = [HYBaseView new];
        line.backgroundColor = UIColor.grayColor;
        [superview addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(referview);
            make.height.offset(1);
            make.top.equalTo(referview.mas_bottom).offset(1);
        }];
    }
}

- (HYDefaultTextField*)setpwTF
{
    if (!_setpwTF) {
        _setpwTF = [HYDefaultTextField creatDefaultTextField:@"请输入密码" font:SYSTEM_REGULARFONT(15) textColor:HYCOLOR.color_c4];
        _setpwTF.maxCount = 12;
        _setpwTF.textFiled.secureTextEntry = YES;
    }
    return _setpwTF;
}
@end
