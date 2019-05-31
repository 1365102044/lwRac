//
//  HYHeZuRenItemsView.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/5/31.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYHeZuRenItemsView.h"

@interface HYHeZuRenItemsView()
@property (nonatomic, strong) UIImageView * leftImageView;
@end

@implementation HYHeZuRenItemsView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _titleLable = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(12) text:@"" textColor:HYCOLOR.color_c4];
        _descLable = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(12) text:@"" textColor:HYCOLOR.color_c4];
        _descLable.textAlignment = NSTextAlignmentRight;
        _leftImageView = [[UIImageView alloc] init];
        _leftImageView.backgroundColor = HYCOLOR.color_c0;
        [self addSubview:_leftImageView];
        [self addSubview:_titleLable];
        [self addSubview:_descLable];
        [_titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).mas_offset(ADJUST_PERCENT_FLOAT(55));
            make.top.bottom.mas_equalTo(self);
            make.height.mas_offset(ADJUST_PERCENT_FLOAT(35));
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        [_descLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mas_right).mas_offset(-ADJUST_PERCENT_FLOAT(30));
            make.top.bottom.mas_equalTo(self);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        [_leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_offset(CGSizeMake(ADJUST_PERCENT_FLOAT(14), ADJUST_PERCENT_FLOAT(14)));
            make.right.mas_equalTo(_titleLable.mas_left).mas_offset(-ADJUST_PERCENT_FLOAT(10));
            make.centerY.mas_equalTo(_titleLable.mas_centerY);
        }];
        [self.leftImageView setBoundWidth:1 cornerRadius:ADJUST_PERCENT_FLOAT(7) boardColor:HYCOLOR.color_c4];
    }
    return self;
}

- (void)noIsFirst
{
    self.leftImageView.backgroundColor = [UIColor blackColor];
}
@end
