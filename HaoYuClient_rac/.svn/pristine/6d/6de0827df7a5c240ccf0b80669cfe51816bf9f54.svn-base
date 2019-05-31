//
//  HYPaoView.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/7/16.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYPaoView.h"
@interface HYPaoView ()
@property (nonatomic, strong) UILabel * titleLable;

@end
@implementation HYPaoView
- (void)setPointModel:(HYPointModel *)pointModel
{
    _titleLable.text = pointModel.name;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _titleLable = [[UILabel alloc] init];
        _titleLable.textAlignment = NSTextAlignmentCenter;
        _titleLable.font = SYSTEM_REGULARFONT(14);
        _titleLable.textColor = [UIColor whiteColor];
        _titleLable.backgroundColor = [UIColor greenColor];
        [self addSubview:_titleLable];
        [_titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self);
        }];
    }
    return self;
}

@end
