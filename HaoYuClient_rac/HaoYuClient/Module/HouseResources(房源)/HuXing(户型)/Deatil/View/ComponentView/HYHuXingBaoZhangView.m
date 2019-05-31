//
//  HYHuXingBaoZhangView.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/12.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYHuXingBaoZhangView.h"

@implementation HYHuXingBaoZhangView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = HYCOLOR.color_c3;
        HYDefaultLabel *titleLable = [HYDefaultLabel labelWithFont:SYSTEM_MEDIUMFONT(15)
                                                              text:@"保障"
                                                         textColor:HYCOLOR.color_c4];
        _yongjinLable = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(12)
                                                          text:@""
                                                     textColor:HYCOLOR.color_c3];
        _baozhangLable = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(12)
                                                 text:@""
                                            textColor:HYCOLOR.color_c3];
        [self addSubview:line];
        [self addSubview:titleLable];
        [self addSubview:_yongjinLable];
        [self addSubview:_baozhangLable];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_offset(1);
            make.left.top.mas_equalTo(self).mas_offset(MARGIN);
            make.height.mas_offset(ADJUST_PERCENT_FLOAT(25));
        }];
        [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(line.mas_right).mas_offset(MARGIN);
            make.centerY.mas_equalTo(line.mas_centerY);
        }];
        [_baozhangLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(titleLable.mas_bottom).mas_offset(MARGIN*2);
            make.left.mas_equalTo(self.mas_left).mas_offset(MARGIN);
            make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-MARGIN*2);
        }];
        [_yongjinLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_baozhangLable.mas_right).mas_offset(MARGIN*2);
            make.centerY.mas_equalTo(_baozhangLable.mas_centerY);
        }];
    }
    return self;
}

@end
