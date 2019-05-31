//
//  HYFuWuPingJiaMainView.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/5.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYFuWuPingJiaMainView.h"

@interface HYFuWuPingJiaMainView()
@property (nonatomic, strong) UIView * bgView;
@end

@implementation HYFuWuPingJiaMainView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = HYCOLOR.color_c0;
        [self addSubview:_bgView];
        _scoreView = [[HYScoreView alloc] init];
        [_bgView addSubview:_scoreView];
        _textView = [HYPlaceHolderTextView creatPlaceHolderTextViewWithPlaceHolder:@"请输入您的评价"];
        [_bgView addSubview:_textView];
        _textView.maxCount = 200;
        HYDefaultLabel *titlelable = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(15)
                                                              text:@"评价留言："
                                                         textColor:HYCOLOR.color_c4];
        [_bgView addSubview:titlelable];
        _commitLable = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(15)
                                                text:@"提交"
                                           textColor:HYCOLOR.color_c4];
        [_bgView addSubview:_commitLable];
        _commitLable.textAlignment = NSTextAlignmentCenter;
        [_commitLable setBoundWidth:1 cornerRadius:4 boardColor:HYCOLOR.color_c5];
        _commitLable.userInteractionEnabled = YES;
        [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.mas_equalTo(self).mas_offset(MARGIN);
            make.right.bottom.mas_equalTo(self).mas_offset(-MARGIN);
        }];
        [_scoreView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.mas_equalTo(_bgView).mas_offset(MARGIN);
            make.right.mas_equalTo(_bgView).mas_offset(-MARGIN);
        }];
        [titlelable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_scoreView.mas_bottom).mas_offset(MARGIN * 2);
            make.left.mas_equalTo(_bgView.mas_left).mas_offset(MARGIN);
        }];
        [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(titlelable.mas_bottom).mas_offset(MARGIN);
            make.left.mas_equalTo(_bgView.mas_left).mas_offset(MARGIN*1.5);
            make.right.mas_equalTo(_bgView.mas_right).mas_offset(-MARGIN*1.5);
            make.height.mas_offset(ADJUST_PERCENT_FLOAT(150));
        }];
        [_commitLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_offset(ADJUST_PERCENT_FLOAT(44));
            make.left.right.mas_equalTo(_textView);
            make.top.mas_equalTo(_textView.mas_bottom).mas_offset(MARGIN);
            make.bottom.mas_equalTo(_bgView.mas_bottom).mas_offset(-MARGIN*3);
        }];
        
    }
    return self;
}

@end
