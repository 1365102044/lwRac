

//
//  HYTouSuJianYiMainView.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/5.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYTouSuJianYiMainView.h"
#import "HYLeftRightArrowView.h"
#import "HYPlaceHolderTextView.h"
#import "HYAttributedStringLabel.h"
#import "HYDefaultTextField.h"
@interface HYTouSuJianYiMainView()

@end

@implementation HYTouSuJianYiMainView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        HYBaseView *bgView = [[HYBaseView alloc] init];
        [self addSubview:bgView];
        [bgView setBoundWidth:0 cornerRadius:6];
        
        HYLeftRightArrowView *titleView = [HYLeftRightArrowView creatLeftRightLableArrowViewWithLeftStr:@"手机号码"
                                                                                               rightStr: USERDEFAULTS_GET(USER_INFOR_PHONE) ? USERDEFAULTS_GET(USER_INFOR_PHONE) : @""
                                                                                          showArrowIcon:NO
                                                                                          CallBackBlock:nil];
        HYAttributedStringLabel *desLable = [HYAttributedStringLabel labelWithFont:SYSTEM_REGULARFONT(13)
                                                                              text:@""
                                                                         textColor:HYCOLOR.color_c4];
        [desLable setAttributedStringWithContentArray:@[@{@"color" : HYCOLOR.color_c4,
                                                          @"content" : @"请输入您的意见和建议，以便我们可以不断的改进，更好的服务于您。",
                                                          @"size" : SYSTEM_REGULARFONT(14),
                                                          @"lineSpacing": @5},]];
        HYDefaultTextField *titleTextFiled = [HYDefaultTextField creatDefaultTextField:@"请输入标题（15字）"
                                                                                  font:SYSTEM_REGULARFONT(14)
                                                                             textColor:HYCOLOR.color_c4];
        [titleTextFiled setBoundWidth:1 cornerRadius:4 boardColor:HYCOLOR.color_c3];
        titleTextFiled.maxCount = 15;
        HYPlaceHolderTextView *textview = [HYPlaceHolderTextView creatPlaceHolderTextViewWithPlaceHolder:@"请输入您的意见和建议"];
        HYDefaultLabel *commitLable = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(15)
                                                               text:@"提交"
                                                          textColor:HYCOLOR.color_c4];
        commitLable.textAlignment = NSTextAlignmentCenter;
        [commitLable setBoundWidth:1 cornerRadius:4 boardColor:HYCOLOR.color_c3];
        [bgView addSubview:commitLable];
        [bgView addSubview:titleView];
        [bgView addSubview:desLable];
        [bgView addSubview:titleTextFiled];
        [bgView addSubview:textview];
        textview.maxCount = 200;
        
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
        [titleView.rightLable mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(titleView.mas_centerY);
            make.right.mas_equalTo(titleView.mas_right).mas_offset(-MARGIN*0.5);
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
        [commitLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.left.mas_equalTo(titleView);
            make.top.mas_equalTo(textview.mas_bottom).mas_offset(MARGIN*2);
            make.height.mas_offset(ADJUST_PERCENT_FLOAT(40));
            make.bottom.mas_equalTo(bgView).mas_offset(-MARGIN*3);
        }];
        
    }
    return self;
}

@end
