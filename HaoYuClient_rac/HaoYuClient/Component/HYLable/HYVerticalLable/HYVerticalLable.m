//
//  HYVerticalLable.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/1.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYVerticalLable.h"

@implementation HYVerticalLable

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.topLable = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(13) text:@"" textColor:HYCOLOR.color_c4];
       self.bottomLable = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(13) text:@"" textColor:HYCOLOR.color_c4];
        _topLable.textAlignment = NSTextAlignmentCenter;
        _bottomLable.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_topLable];
        [self addSubview:_bottomLable];
        [_topLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.top.mas_equalTo(self.mas_top).mas_offset(ADJUST_PERCENT_FLOAT(10));
        }];
        [_bottomLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.top.mas_equalTo(_topLable.mas_bottom).mas_offset(ADJUST_PERCENT_FLOAT(10));
            make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-ADJUST_PERCENT_FLOAT(10));
        }];
    }
    return self;
}

@end
