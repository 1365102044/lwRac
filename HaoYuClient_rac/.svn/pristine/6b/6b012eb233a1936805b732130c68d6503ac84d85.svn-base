//
//  HYAddTongZhuRenView.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/19.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYAddTongZhuRenView.h"
#import "HYLeftRightArrowView.h"
#import "HYActionSheet.h"
@interface HYAddTongZhuRenView ()
@property (nonatomic, strong) NSMutableDictionary * param;
@property (nonatomic, strong) NSDictionary * oldinfor;
//@property (nonatomic, strong) HYLeftRightArrowView * six_L;

@end

@implementation HYAddTongZhuRenView

+ (instancetype)showAddHeZhuRenViewHZinfor:(NSDictionary *)infor callbackBlock:(HYEventCallBackBlock)callBackBlock
{
    HYAddTongZhuRenView *instance = [[HYAddTongZhuRenView alloc] init];
    instance.oldinfor = infor;
    instance.callBackBlock = callBackBlock;
    [instance setUI];
    return instance;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.param = [NSMutableDictionary dictionary];
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didClickKeyboard:) name:UIKeyboardWillShowNotification object:nil];
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didKboardDisappear:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}

- (void)setUI
{
    HYDefaultLabel *titleLable = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(15)
                                                          text:@"添加同住人"
                                                     textColor:HYCOLOR.color_c4];
    HYLeftRightArrowView *name = [HYLeftRightArrowView creatLeftRightTextFieldArrowViewWithLeftStr:@"姓名："
                                                                                              rightStr:@"输入姓名"
                                                                                         showArrowIcon:NO
                                                                                         CallBackBlock:^(id sender) {
                                                                                             [self creatParam:sender key:@"nickname"];
                                                                                         }];
    HYLeftRightArrowView *phone = [HYLeftRightArrowView creatLeftRightTextFieldArrowViewWithLeftStr:@"手机号："
                                                                                              rightStr:@"输入手机号"
                                                                                         showArrowIcon:NO
                                                                                         CallBackBlock:^(id sender) {
                                                                                             [self creatParam:sender key:@"phone"];
                                                                                         }];
    phone.rightTextField.textFiled.keyboardType = UIKeyboardTypeNumberPad;
    phone.rightTextField.maxCount = 11;
    HYLeftRightArrowView *zhengjianleixing = [HYLeftRightArrowView creatLeftRightLableArrowViewWithLeftStr:@"证件类型："
                                                                                              rightStr:@"身份证"
                                                                                         showArrowIcon:NO
                                                                                         CallBackBlock:^(id sender) {
                                                                                             
                                                            [self creatParam:sender key:@"TongZhuRen_IdCarType"];                             }];
    HYLeftRightArrowView *zhengjianhao = [HYLeftRightArrowView creatLeftRightTextFieldArrowViewWithLeftStr:@"证件号码："
                                                                                              rightStr:@"输入证件号"
                                                                                         showArrowIcon:NO
                                                                                         CallBackBlock:^(id sender) {
                                                                                             [self creatParam:sender key:@"sfzNo"];
                                                                                         }];
//    _six_L = [HYLeftRightArrowView creatLeftRightTextFieldArrowViewWithLeftStr:@"性别"
//                                                                                                  rightStr:@"请选择性别"
//                                                                                             showArrowIcon:YES
//                                                                                             CallBackBlock:^(id sender) {
//
//                                                                                             }];
//
    HYFillLongButton *commit = [HYFillLongButton buttonCorWithTitleStringKey:@"确定"
                                                                      target:self
                                                                    selector:@selector(clickBtn)];
    
    [self.bgView addSubview:titleLable];
    [self.bgView addSubview:phone];
    [self.bgView addSubview:name];
    [self.bgView addSubview:zhengjianleixing];
    [self.bgView addSubview:zhengjianhao];
//    [self.bgView addSubview:_six_L];
    [self.bgView addSubview:commit];
    
    [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgView.mas_top).mas_offset(MARGIN*2);
        make.centerX.mas_equalTo(self.bgView.mas_centerX);
    }];
    [name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgView.mas_left).mas_offset(MARGIN);
        make.right.mas_equalTo(self.bgView.mas_right).mas_offset(-MARGIN);
        make.height.mas_offset(MARGIN*4);
        make.top.mas_equalTo(titleLable.mas_bottom).mas_offset(MARGIN*2);
    }];
    [phone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.mas_equalTo(name);
        make.height.mas_offset(MARGIN*4);
        make.top.mas_equalTo(name.mas_bottom);
    }];
    [zhengjianleixing mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.mas_equalTo(name);
        make.height.mas_offset(MARGIN*4);
        make.top.mas_equalTo(phone.mas_bottom);
    }];
    [zhengjianhao mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.mas_equalTo(name);
        make.height.mas_offset(MARGIN*4);
        make.top.mas_equalTo(zhengjianleixing.mas_bottom);
    }];
//    [_six_L mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.left.mas_equalTo(name);
//        make.height.mas_offset(MARGIN*4);
//        make.top.mas_equalTo(zhengjianhao.mas_bottom);
//    }];
    [commit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(MARGIN*12);
        make.height.mas_offset(MARGIN*3);
        make.centerX.mas_equalTo(self.bgView.mas_centerX);
        make.top.mas_equalTo(zhengjianhao.mas_bottom).mas_offset(MARGIN*2);
        make.bottom.mas_equalTo(self.bgView.mas_bottom).mas_offset(-MARGIN*2);
    }];
    [self.bgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(SCREEN_WIDTH*0.8);
        make.centerX.mas_equalTo(self.window.mas_centerX);
        make.centerY.mas_equalTo(self.window.mas_centerY);
    }];
    
//    _six_L.rightTextField.textFiled.enabled = NO;
//    [_six_L.rightTextField bk_whenTapped:^{
//        [HYActionSheet showDefaultAlert:self.viewController titleKey:@"选择性别" buttonArr:@[@"男",@"女"] callBack:^(id sender) {
//            if([sender integerValue] == 0 ){
//                _six_L.rightTextField.textFiled.text = @"男";
//            }else if ([sender integerValue] == 1){
//                _six_L.rightTextField.textFiled.text = @"女";
//            }
//            self.param[@"gender"] = @([sender integerValue] + 1);
//        }];
//    }];
    if (_oldinfor) {
        //需要修改的信息
        name.rightTextField.textFiled.text = _oldinfor[@"nickname"];
        phone.rightTextField.textFiled.text = _oldinfor[@"phone"];
        zhengjianhao.rightTextField.textFiled.text = _oldinfor[@"sfzNo"];
//        _six_L.rightTextField.textFiled.text = _oldinfor[@"gender"];
        [self.param addEntriesFromDictionary:_oldinfor];
    }
}

- (void)clickBtn
{
    if ([[HYStringTool checkString:self.param[@"nickname"]] isEqualToString:@""]||
        [self toString:self.param[@"nickname"]].length > 20) {
        ALERT(@"姓名格式不正确");
        return;
    }
    if ([[HYStringTool checkString:self.param[@"phone"]] isEqualToString:@""]||
        ![StringWithFormat(self.param[@"phone"]) ex_isMobileNumber]) {
        ALERT(@"手机号格式不正确");
        return;
    }
    if ([[HYStringTool checkString:self.param[@"sfzNo"]] isEqualToString:@""]||
        ![self.param[@"sfzNo"] ex_validateIdentityCard]) {
        ALERT(@"证件号格式不正确");
        return;
    }
    
    [self endEditing:YES];
    [self dismiss];
    if (self.callBackBlock) {
        self.param[@"gender"] = @"1";
        self.callBackBlock(self.param);
    }
}

/**
 创建参数
 */
- (void)creatParam:(HYLeftRightArrowView *)sender key:(NSString *)key
{
    NSString *value = sender.rightTextField.text;
    if (value && ![value isEqualToString:@""]) {
        [self.param setObject:value forKey:key];
    }
}

-(void)didClickKeyboard:(NSNotification *)sender{
    
    CGFloat durition = [sender.userInfo[@"UIKeyboardAnimationDurationUserInfoKey"] doubleValue];
    
//    CGRect keyboardRect = [sender.userInfo[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    
//    CGFloat keyboardHeight = keyboardRect.size.height;
    
    [UIView animateWithDuration:durition animations:^{
        
        self.bgView.transform = CGAffineTransformMakeTranslation(0, -MARGIN*8);
    }];
}

-(void)didKboardDisappear:(NSNotification *)sender{
    
    CGFloat duration = [sender.userInfo[@"UIKeyboardAnimationDurationUserInfoKey"] doubleValue];
    
    [UIView animateWithDuration:duration animations:^{
        
        self.bgView.transform = CGAffineTransformIdentity;
        
    }];
}

@end
