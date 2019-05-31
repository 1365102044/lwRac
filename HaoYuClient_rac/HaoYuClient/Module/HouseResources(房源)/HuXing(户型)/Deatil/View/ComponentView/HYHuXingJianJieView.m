//
//  HYHuXingJianJieView.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/12.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYHuXingJianJieView.h"

@implementation HYHuXingJianJieView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = HYCOLOR.color_c3;
        HYDefaultLabel *titleLable = [HYDefaultLabel labelWithFont:SYSTEM_MEDIUMFONT(15)
                                                              text:@"房型简介"
                                                         textColor:HYCOLOR.color_c4];
        _contentLable = [HYAttributedStringLabel labelWithFont:SYSTEM_REGULARFONT(13)
                                                            text:@""
                                                       textColor:HYCOLOR.color_c4];
        [self addSubview:line];
        [self addSubview:titleLable];
        [self addSubview:_contentLable];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_offset(1);
            make.left.top.mas_equalTo(self).mas_offset(MARGIN);
            make.height.mas_offset(ADJUST_PERCENT_FLOAT(25));
        }];
        [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(line.mas_right).mas_offset(MARGIN);
            make.centerY.mas_equalTo(line.mas_centerY);
        }];
        [_contentLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(titleLable.mas_bottom).mas_offset(MARGIN*2);
            make.right.mas_equalTo(self.mas_right).mas_offset(-MARGIN);
            make.left.mas_equalTo(self.mas_left).mas_offset(MARGIN);
            make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-MARGIN);
        }];
    }
    return self;
}
@end
