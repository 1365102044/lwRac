//
//  HYQianYueCellView.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/19.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYQianYueCellView.h"

@interface HYQianYueCellView  ()

@end
@implementation HYQianYueCellView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _leftLable = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(15)
                                              text:@""
                                         textColor:HYCOLOR.color_c4];
        _rightTextField = [HYDefaultTextField creatDefaultTextField:@""
                                                               font:SYSTEM_REGULARFONT(15)
                                                          textColor:HYCOLOR.color_c4];
        _bottomLine = [[UIView alloc] init];
        _bottomLine.backgroundColor = HYCOLOR.color_c6;
        [self addSubview:_bottomLine];
        [self addSubview:_leftLable];
        [self addSubview:_rightTextField];
        
        [_leftLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(self.mas_left).mas_offset(MARGIN);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        [_rightTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(self.mas_right).mas_offset(-MARGIN);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.width.mas_offset(MARGIN*10);
        }];
        [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_offset(10);
            make.left.right.mas_equalTo(self);
            make.bottom.mas_equalTo(self.mas_bottom);
        }];
        
    }
    return self;
}

@end
