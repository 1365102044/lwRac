

//
//  HYTouSuJianYiMainView.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/5.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYTouSuJianYiMainView.h"
#import "HYAttributedStringLabel.h"
#import "HYActionSheet.h"

@interface HYTouSuJianYiMainView()

@end

@implementation HYTouSuJianYiMainView

- (void)clickTitle
{
    /**
     投诉类型0.员工服务类1.维修类2.费用类3.配套设施类4.环境卫生类
     */
    NSArray *datas = @[@"员工服务类",@"维修类",@"费用类",@"配套设施类",@"环境卫生类"];
    [HYActionSheet showBottomCancelAlert:self.currentViewController title:@"选择投诉类型"
                                callBack:^(id sender) {
                                    if ([sender integerValue] == 0) return ;
                                    _complaintType = [sender integerValue];
                                    _titleTextFiled.textFiled.text = datas[_complaintType - 1];
                                } buttonArray:datas];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self confiUI];
        _titleView.rightLable.text = USERDEFAULTS_GET(USER_INFOR_PHONE);
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTitle)];
        [_titleTextFiled addGestureRecognizer:tap];
        
        _complaintType = 0;
    }
    return self;
}

- (void)confiUI
{
    HYBaseView *bgView = [[HYBaseView alloc] init];
    [self addSubview:bgView];
    [bgView setBoundWidth:0 cornerRadius:6];
    
    HYLeftRightArrowView *titleView = [HYLeftRightArrowView creatLeftRightLableArrowViewWithLeftStr:@"手机号码"
                                                                                           rightStr: USERDEFAULTS_GET(USER_INFOR_PHONE) ? USERDEFAULTS_GET(USER_INFOR_PHONE) : @""
                                                                                      showArrowIcon:NO
                                                                                      CallBackBlock:nil];
    _titleView = titleView;
    HYAttributedStringLabel *desLable = [HYAttributedStringLabel labelWithFont:SYSTEM_REGULARFONT(13)
                                                                          text:@""
                                                                     textColor:HYCOLOR.color_c4];
    [desLable setAttributedStringWithContentArray:@[@{@"color" : HYCOLOR.color_c4,
                                                      @"content" : @"请输入您的意见和建议，以便我们可以不断的改进，更好的服务于您。",
                                                      @"size" : SYSTEM_REGULARFONT(14),
                                                      @"lineSpacing": @5},]];
    HYDefaultTextField *titleTextFiled = [HYDefaultTextField creatDefaultTextField:@"选择投诉类型"
                                                                              font:SYSTEM_REGULARFONT(14)
                                                                         textColor:HYCOLOR.color_c4];
    [titleTextFiled setBoundWidth:1 cornerRadius:4 boardColor:HYCOLOR.color_c3];
    titleTextFiled.maxCount = 15;
    HYPlaceHolderTextView *textview = [HYPlaceHolderTextView creatPlaceHolderTextViewWithPlaceHolder:@"请输入您的意见和建议"];
    UIImageView *rig_icon = [[UIImageView alloc] initWithImage:IMAGENAME(@"shopping_point_n")];
    
//    HYDefaultLabel *pic_title = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(13) text:@"" textColor:HYCOLOR.color_c4];
    
    HYDefaultLabel *commitLable = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(15)
                                                           text:@"提交"
                                                      textColor:HYCOLOR.color_c4];
    commitLable.textAlignment = NSTextAlignmentCenter;
    [commitLable setBoundWidth:1 cornerRadius:4 boardColor:HYCOLOR.color_c3];
    
    _titleTextFiled = titleTextFiled;
    _textview = textview;
    _titleTextFiled.textFiled.enabled = NO;
    [_titleTextFiled addSubviews:@[rig_icon]];
    [bgView addSubviews:@[titleView,desLable,titleTextFiled,textview,self.addPhotoView,commitLable]];
    
    textview.maxCount = 200;
    [rig_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(24, 24));
        make.right.equalTo(_titleTextFiled.mas_right).offset(-5);
        make.centerY.equalTo(titleTextFiled.mas_centerY);
    }];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(self);
        make.right.mas_equalTo(self.mas_right).mas_offset(-MARGIN);
        make.left.mas_equalTo(self.mas_left).mas_offset(MARGIN);
    }];
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(bgView).mas_offset(MARGIN);
        make.right.mas_equalTo(bgView.mas_right).mas_offset(-MARGIN);
        make.height.mas_offset(ADJUST_PERCENT_FLOAT(40));
    }];
    [desLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.mas_equalTo(titleView);
        make.top.mas_equalTo(titleView.mas_bottom).mas_offset(MARGIN*1.5);
    }];
    [titleTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.mas_equalTo(titleView);
        make.top.mas_equalTo(desLable.mas_bottom).mas_offset(MARGIN*1.5);
        make.height.mas_offset(ADJUST_PERCENT_FLOAT(35));
    }];
    [textview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.mas_equalTo(titleView);
        make.top.mas_equalTo(titleTextFiled.mas_bottom).mas_offset(MARGIN*1.5);
        make.height.mas_offset(ADJUST_PERCENT_FLOAT(150));
    }];
    
    [self.addPhotoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(textview);
        make.top.equalTo(textview.mas_bottom).offset(10);
    }];
    [commitLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.mas_equalTo(titleView);
        make.top.mas_equalTo(_addPhotoView.mas_bottom).mas_offset(MARGIN*2);
        make.height.mas_offset(ADJUST_PERCENT_FLOAT(40));
        make.bottom.mas_equalTo(bgView).mas_offset(-MARGIN*3);
    }];
    
    commitLable.userInteractionEnabled = YES;
    [commitLable bk_whenTapped:^{
        if ([[titleTextFiled.textFiled.text isNullToString] isEqualToString:@""]) {
            ALERT(@"请选择投诉类型");
            return ;
        }
        if (titleTextFiled.textFiled.text.length > 15) {
            ALERT(@"输入标题只在是15个字符内");
            return ;
        }
        if ([[_textview.TextView.text isNullToString] isEqualToString:@""]) {
            ALERT(@"请输入内容");
            return ;
        }
    
        if (self.callBackBlock) {
            self.callBackBlock(nil);
        }
    }];
}

- (HYAddPhotoView*)addPhotoView
{
    if (!_addPhotoView) {
        _addPhotoView = [[HYAddPhotoView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - MARGIN *2, 1)];;
        _addPhotoView.titleLable.text = @"添加照片：(最大数量3张)";
        
    }
    return _addPhotoView;
}

@end
