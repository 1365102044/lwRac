//
//  HYTopInforView.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/11.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYTopInforView.h"

@implementation HYTopInforView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _titileLable = [HYDefaultLabel labelWithFont:SYSTEM_MEDIUMFONT(15)
                                                text:@""
                                           textColor:HYCOLOR.color_c4];
        _baozhangLable = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(13)
                                                text:@""
                                           textColor:HYCOLOR.color_c4];
        _yongjinLable = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(13)
                                                text:@""
                                           textColor:HYCOLOR.color_c4];
        [self addSubview:_titileLable];
        [self addSubview:_baozhangLable];
        [self addSubview:_yongjinLable];
        
        [_titileLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.mas_equalTo(self).mas_offset(MARGIN*1.5);
        }];
        [_baozhangLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_titileLable.mas_bottom).mas_offset(MARGIN*2);
            make.left.mas_equalTo(_titileLable.mas_left);
        }];
        [_yongjinLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(_baozhangLable.mas_centerY);
            make.right.mas_equalTo(self.mas_right).mas_offset(-MARGIN);
            make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-MARGIN*1.5);
        }];
    }
    return self;
}

@end
