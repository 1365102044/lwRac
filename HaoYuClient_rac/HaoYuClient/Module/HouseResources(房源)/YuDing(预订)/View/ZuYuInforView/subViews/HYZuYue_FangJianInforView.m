//
//  HYZuYue_FangJianInforView.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/14.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYZuYue_FangJianInforView.h"

@interface HYZuYue_FangJianInforView ()
@property (nonatomic, strong) HYBaseView * addInforView;

@end
@implementation HYZuYue_FangJianInforView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _baseView = [[HYZuYue_InforBaseView alloc] init];
        _baseView.titleLable.text = @"房间信息";
       
        [self addSubview:_baseView];
        [_baseView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self);
        }];
        [_baseView addSubview:self.addInforView];
        [_addInforView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_baseView.titleLable.mas_bottom).mas_offset(MARGIN/2);
            make.left.mas_equalTo(_baseView.mas_left).mas_offset(MARGIN);
            make.right.mas_equalTo(_baseView.mas_right).mas_offset(-MARGIN);
        }];
        [_baseView.itemView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_addInforView.mas_bottom).mas_offset(0);
            make.left.right.mas_equalTo(_baseView);
            make.bottom.mas_equalTo(_baseView.mas_bottom).mas_offset(-MARGIN);
        }];
        [_baseView setBoundWidth:1 cornerRadius:6 boardColor:HYCOLOR.color_c6];
//        _menDianLable.text = @"北京牡丹园店";
//        _louDongHaoLable.text = @"1栋110号";
    }
    return self;
}

- (HYBaseView*)addInforView
{
    if (!_addInforView) {
        _addInforView = [[HYBaseView alloc] init];
        _menDianLable = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(14)
                                                 text:@""
                                            textColor:HYCOLOR.color_c4];
        _louDongHaoLable = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(13)
                                                 text:@""
                                            textColor:HYCOLOR.color_c4];
        [_addInforView addSubview:_menDianLable];
        [_addInforView addSubview:_louDongHaoLable];
        
        [_menDianLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_addInforView.mas_left).mas_offset(MARGIN);
            make.top.mas_equalTo(_addInforView).mas_offset(MARGIN);
        }];
        [_louDongHaoLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_addInforView.mas_left).mas_offset(MARGIN);
            make.top.mas_equalTo(_menDianLable.mas_bottom).mas_offset(MARGIN);
            make.bottom.mas_equalTo(_addInforView.mas_bottom).mas_offset(-MARGIN);
        }];
    }
    return _addInforView;
}
@end
