//
//  HYTouSuJianYiCellView.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/9.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYTouSuJianYiCellView.h"

@interface HYTouSuJianYiCellView ()
@property (nonatomic, strong) HYBaseView * bgView;
@property (nonatomic, assign) BOOL isShow;

@end

@implementation HYTouSuJianYiCellView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setSubUI];
        self.backgroundColor = HYCOLOR.color_c1;
        _isShow = NO;
    }
    return self;
}

- (void)setSubUI
{
    _bgView = [[HYBaseView alloc] init];
    
    _titleLable = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(15)
                                           text:@""
                                      textColor:HYCOLOR.color_c4];
    _phoneLable = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(13)
                                                 text:@""
                                            textColor:HYCOLOR.color_c4];
    _descLable = [HYAttributedStringLabel labelWithFont:SYSTEM_REGULARFONT(13)
                                                    text:@""
                                               textColor:HYCOLOR.color_c4];
    _lineView = [[UIView alloc] init];
    _lineView.backgroundColor = HYCOLOR.color_c6;
    
    _cancleBtn = [HYDefaultButton buttonWithTitleStringKey:@"删除"
                                                titleColor:HYCOLOR.color_c3
                                                 titleFont:SYSTEM_REGULARFONT(14)
                                                    target:self
                                                  selector:nil];
    
    [self addSubview:_bgView];
    [_bgView addSubviews:@[_titleLable,_phoneLable,_descLable,_lineView,self.fanKuiInforView]];
    
    
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(self).mas_offset(MARGIN);
        make.right.mas_equalTo(self.mas_right).mas_offset(-MARGIN);
        make.bottom.mas_equalTo(self.mas_bottom);
    }];
    [_titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_bgView.mas_top).mas_offset(MARGIN);
        make.left.mas_equalTo(_bgView.mas_left).mas_offset(MARGIN);
        make.right.mas_equalTo(_bgView.mas_right).mas_offset(-MARGIN*2);
    }];
    [_phoneLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_titleLable.mas_bottom).mas_offset(MARGIN);
        make.left.mas_equalTo(_titleLable.mas_left);
    }];
    [_descLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_phoneLable.mas_bottom).mas_offset(MARGIN);
        make.left.mas_equalTo(_titleLable.mas_left);
        make.right.mas_equalTo(_bgView.mas_right).mas_offset(-MARGIN);
    }];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_descLable.mas_bottom).mas_offset(MARGIN);
        make.height.mas_offset(0.5);
        make.left.right.mas_equalTo(_descLable);
    }];

//    [self.fanKuiInforView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(_descLable.mas_bottom).mas_offset(MARGIN);
//        make.left.right.equalTo(_bgView);
//        make.bottom.mas_equalTo(_bgView.mas_bottom).mas_offset(-MARGIN/2).priorityHigh();
//    }];
    
    [_bgView setBoundWidth:0 cornerRadius:6];

    _statusImageView = [[UIImageView alloc] init];
    [_bgView addSubview:_statusImageView];
    [_statusImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(MARGIN*5, MARGIN*5));
        make.top.right.mas_equalTo(_bgView);
    }];
   
    [_bgView addSubview:_cancleBtn];
    
    [_cancleBtn setBoundWidth:0.5 cornerRadius:4 boardColor:[UIColor redColor]];

    _cancleBtn.hidden = YES;
    self.fanKuiInforView.hidden = YES;
}

- (void)hiddenReplyView
{
    if (self.fanKuiInforView.hidden) {
        [_descLable mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_phoneLable.mas_bottom).mas_offset(MARGIN);
            make.left.mas_equalTo(_titleLable.mas_left);
            make.right.mas_equalTo(_bgView.mas_right).mas_offset(-MARGIN);
            make.bottom.mas_equalTo(_bgView.mas_bottom).mas_offset(-MARGIN).priorityHigh();
        }];
    }else{
        [_descLable mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_phoneLable.mas_bottom).mas_offset(MARGIN);
            make.left.mas_equalTo(_titleLable.mas_left);
            make.right.mas_equalTo(_bgView.mas_right).mas_offset(-MARGIN);
        }];
        [self.fanKuiInforView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_descLable.mas_bottom).mas_offset(MARGIN);
            make.left.right.equalTo(_bgView);
            make.bottom.mas_equalTo(_bgView.mas_bottom).mas_offset(-MARGIN).priorityHigh();
        }];
    }
}

- (void)hiddenBtn:(BOOL)hidden hiddenReplyView:(BOOL)hiddenReplyView
{
    self.cancleBtn.hidden = self.lineView.hidden = hidden;
    self.fanKuiInforView.hidden = hiddenReplyView;
    if (hidden) {
        [self hiddenReplyView];
    }else{
        [_cancleBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_offset(CGSizeMake(MARGIN*5, MARGIN*2));
            make.top.mas_equalTo(_lineView.mas_bottom).mas_offset(MARGIN);
            make.right.mas_equalTo(_lineView.mas_right).mas_offset(-MARGIN);
            make.bottom.mas_equalTo(_bgView.mas_bottom).mas_offset(-MARGIN);
        }];
    }
}


- (LWTouSuJianYiReplyView*)fanKuiInforView
{
    if (!_fanKuiInforView) {
        _fanKuiInforView = [[LWTouSuJianYiReplyView alloc] init];
    }
    return _fanKuiInforView;
}
@end

