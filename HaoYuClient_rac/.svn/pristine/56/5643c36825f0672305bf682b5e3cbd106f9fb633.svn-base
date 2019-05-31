//
//  HYZhouBianItemView.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/11.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYZhouBianItemView.h"

@implementation HYZhouBianItemView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _titleLable = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(13)
                                               text:@""
                                          textColor:HYCOLOR.color_c4];
        _titleLable.textAlignment = NSTextAlignmentCenter;
        _titleImageView = [[UIImageView alloc] init];
        _contentLable = [HYAttributedStringLabel labelWithFont:SYSTEM_REGULARFONT(15)
                                               text:@""
                                          textColor:HYCOLOR.color_c4];
        _titleLable.numberOfLines = 0;
        UIView*line = [[UIView alloc] init];
        line.backgroundColor = HYCOLOR.color_c6;
        [self addSubview:line];
        [self addSubview:_titleImageView];
        [self addSubview:_titleLable];
        [self addSubview:_contentLable];
        
        [_titleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_offset(CGSizeMake(MARGIN*4, MARGIN*4));
//            make.left.mas_equalTo(self.mas_left).mas_offset(MARGIN/2);
            make.centerY.mas_equalTo(self.mas_centerY).mas_offset(-MARGIN*2);
            make.centerX.mas_equalTo(_titleLable.mas_centerX);
        }];
        [_titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_offset(MARGIN*5);
            make.left.mas_equalTo(self.mas_left).mas_offset(MARGIN/2);
            make.centerY.mas_equalTo(self.mas_centerY).mas_offset(MARGIN*2);
        }];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top).mas_offset(MARGIN);
            make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-MARGIN);
            make.left.mas_equalTo(_titleLable.mas_right).mas_offset(MARGIN);
            make.width.mas_offset(1);
        }];
        [_contentLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top).mas_offset(MARGIN*2);
            make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-MARGIN*2);
            make.right.mas_equalTo(self.mas_right).mas_offset(-MARGIN);
            make.left.mas_equalTo(line.mas_right).mas_offset(MARGIN);
        }];
    }
    return self;
}
@end
