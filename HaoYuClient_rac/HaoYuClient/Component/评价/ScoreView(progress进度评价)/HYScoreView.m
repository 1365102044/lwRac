//
//  HYScoreView.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/5.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYScoreView.h"
@interface HYScoreView ()
@property (nonatomic, strong) HYDefaultLabel * titleLable;
@property (nonatomic, strong) UIView * lineview;
@property (nonatomic, strong) HYScoreItemView * itemView1;
@property (nonatomic, strong) HYScoreItemView * itemView2;
@property (nonatomic, strong) HYScoreItemView * itemView3;
@property (nonatomic, strong) HYScoreItemView * itemView4;
@property (nonatomic, strong) HYScoreItemView * itemView5;
@end

@implementation HYScoreView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}

- (void)setUI
{
    _titleLable = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(15)
                                           text:@"服务评分"
                                      textColor:HYCOLOR.color_c4];
    _lineview = [[UIView alloc] init];
    _lineview.backgroundColor = HYCOLOR.color_c6;
    
    _itemView1 = [HYScoreItemView creatScoreItemView:@"服务态度" changeValue:^(id sender) {
        _score1 = StringWithFormat(sender);
    }];
    _itemView2 = [HYScoreItemView creatScoreItemView:@"处理速度" changeValue:^(id sender) {
        _score2 = StringWithFormat(sender);
    }];
    _itemView3 = [HYScoreItemView creatScoreItemView:@"硬件设施" changeValue:^(id sender) {
        _score3 = StringWithFormat(sender);
    }];
    _itemView4 = [HYScoreItemView creatScoreItemView:@"环境卫生" changeValue:^(id sender) {
        _score4 = StringWithFormat(sender);
    }];
    _itemView5 = [HYScoreItemView creatScoreItemView:@"安全管理" changeValue:^(id sender) {
        _score5 = StringWithFormat(sender);
    }];
    
    [self addSubview:_titleLable];
    [self addSubview:_lineview];
    [self addSubview:_itemView1];
    [self addSubview:_itemView2];
    [self addSubview:_itemView3];
    [self addSubview:_itemView4];
    [self addSubview:_itemView5];
    
    [_titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(self);
    }];
    [_lineview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_titleLable.mas_bottom).mas_offset(MARGIN);
        make.height.mas_offset(0.5);
        make.left.mas_equalTo(self.mas_left).mas_offset(0);
        make.right.mas_equalTo(self.mas_right).mas_offset(-0);
    }];
    [_itemView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(50);
        make.left.mas_equalTo(_titleLable.mas_left);
        make.right.mas_equalTo(self.mas_right).mas_offset(-MARGIN);
        make.top.mas_equalTo(_lineview.mas_bottom).mas_offset(MARGIN);
    }];
    [_itemView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.left.right.mas_equalTo(_itemView1);
        make.top.mas_equalTo(_itemView1.mas_bottom).mas_offset(MARGIN);
    }];
    [_itemView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.left.right.mas_equalTo(_itemView1);
        make.top.mas_equalTo(_itemView2.mas_bottom).mas_offset(MARGIN);
    }];
    [_itemView4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.left.right.mas_equalTo(_itemView1);
        make.top.mas_equalTo(_itemView3.mas_bottom).mas_offset(MARGIN);
    }];
    [_itemView5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.left.right.mas_equalTo(_itemView1);
        make.top.mas_equalTo(_itemView4.mas_bottom).mas_offset(MARGIN);
        make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-MARGIN);
    }];
}

@end
