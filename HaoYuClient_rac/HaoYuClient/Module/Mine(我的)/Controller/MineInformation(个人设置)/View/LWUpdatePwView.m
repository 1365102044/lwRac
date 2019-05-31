//
//  LWUpdatePassWordView.m
//  HaoYuClient
//
//  Created by 刘文强 on 2019/3/18.
//  Copyright © 2019年 LWQ. All rights reserved.
//

#import "LWUpdatePwView.h"
#import "LWTFHandler.h"
@interface LWUpdatePwView ()
@property (weak, nonatomic) IBOutlet UILabel *titleDescL;

@property (weak, nonatomic) IBOutlet UITextField *oldPwTF;
@property (weak, nonatomic) IBOutlet UILabel *oldLeftL;
@property (weak, nonatomic) IBOutlet UIView *oldlineV;
@property (weak, nonatomic) IBOutlet UILabel *newsPwL;

@property (weak, nonatomic) IBOutlet UITextField *newsPwTF;
@property (weak, nonatomic) IBOutlet UITextField *confirPwTF;

/** 1.设置密码 2.修改密码 */
@property (nonatomic, assign) NSInteger viewType;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *newsL_top;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;

@end
@implementation LWUpdatePwView


+ (instancetype)updatePwView:(NSInteger)viewtype
{
   LWUpdatePwView *instance = [[NSBundle mainBundle] loadNibNamed:@"LWUpdatePwView" owner:nil options:nil].firstObject;
    instance.viewType  = viewtype;
    [instance confitUI];
    return instance;
}

- (void)confitUI
{
    self.backgroundColor = UIColor.whiteColor;
    NSArray *tfs = @[_oldPwTF,_newsPwTF,_confirPwTF];
    if (_viewType == 1) {
        _oldLeftL.hidden = _oldPwTF.hidden = _oldlineV.hidden = YES;
        _newsL_top.constant = -50;
        [self setNeedsLayout];
        [self layoutIfNeeded];
        tfs = @[_newsPwTF,_confirPwTF];
    }
    [self.submitBtn setBoundWidth:0 cornerRadius:6];
    NSString *phone = USERDEFAULTS_GET(USER_INFOR_PHONE);
    NSString *phonestr = [phone ex_replaceStringWithReplaceString:@"*" startLocation:4 lenght:4];
    self.titleDescL.text = [NSString stringWithFormat:@"手机号 %@",phonestr];
    
    self.submitBtn.enabled = NO;
    [LWTFHandler handleTextFieldLenghtLimitWithTF:tfs maxCount:@[@(12),@(12),@(12)]];
    [LWTFHandler handleTextFieldRelationButtonStateWithTF:tfs BT:_submitBtn];
}

- (IBAction)clickSubmitBtn:(id)sender {
    
    PARA_CREART;
    if (_viewType == 2) {
        if (![_oldPwTF.text ex_isPassword]) {
            ALERT(@"请检查旧密码格式");
            return;
        }
        PARA_SET(self.oldPwTF.text, @"oldPassWord");
    }
    if (![_newsPwTF.text ex_isPassword]) {
        ALERT(@"请检查新密码格式");
        return;
    }
    if (![_confirPwTF.text ex_isPassword]) {
        ALERT(@"请检查确认密码格式");
        return;
    }
    if (![_confirPwTF.text isEqualToString:_newsPwTF.text]) {
        ALERT(@"设置的新密码2次不一致");
        return;
    }
    if ([_oldPwTF.text isEqualToString:_confirPwTF.text]) {
        ALERT(@"新密码和旧密码不能相同");
        return;
    }
    
    if (_viewType == 2) {
        PARA_SET(self.newsPwTF.text, @"newPassWord");
    }else{
        PARA_SET(self.newsPwTF.text, @"passWord");
    }
    NSString *userid = USERDEFAULTS_GET(USER_INFOR_USERID);
    if(userid) PARA_SET(userid, @"userId");

    if (self.callblock) {
        self.callblock(para);
    }
}



@end
