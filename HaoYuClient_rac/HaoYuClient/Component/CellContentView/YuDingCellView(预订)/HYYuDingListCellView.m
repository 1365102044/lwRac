//
//  HYYuDingListCellView.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/5.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYYuDingListCellView.h"

@interface HYYuDingListCellView ()

@end
@implementation HYYuDingListCellView

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
    _yudingtimeIcon = [[UIImageView alloc]initWithImage:IMAGENAME(@"mine_yuding_yuyue")];
    _yuyuestatrtimeIcon = [[UIImageView alloc]initWithImage:IMAGENAME(@"mine_yuding_yuyuestartime")];
    _dingweiIcon = [[UIImageView alloc]initWithImage:IMAGENAME(@"mine_yuding_dingwei")];

    [self addSubview:_yudingtimeIcon];
    [self addSubview:_yuyuestatrtimeIcon];
    [self addSubview:_dingweiIcon];
    
    _yudingTimeLable = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(13)
                                                text:@"预订时间："
                                           textColor:HYCOLOR.color_c2];
    _zuyueStarTimeLable = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(13)
                                                   text:@"租约开始时间："
                                              textColor:HYCOLOR.color_c2];
    _dingweiLable = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(13)
                                             text:@"北京海淀牡丹园店"
                                        textColor:HYCOLOR.color_c2];
    _lineview = [[HYBaseView alloc] init];
    _lineview.backgroundColor = HYCOLOR.color_c6;
    
    [self addSubview:_yudingTimeLable];
    [self addSubview:_zuyueStarTimeLable];
    [self addSubview:_dingweiLable];
    [self addSubview:_lineview];
    
    [self.houseImage mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(ADJUST_PERCENT_FLOAT(120), ADJUST_PERCENT_FLOAT(80)));
        make.left.mas_equalTo(self.bgView.mas_left).mas_offset(MAGR);
        make.top.mas_equalTo(self.bgView.mas_top).mas_offset(MAGR);
    }];
    CGFloat ICON_W_H = MARGIN*1.5;
    [_yudingtimeIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(ICON_W_H, ICON_W_H));
        make.top.mas_equalTo(self.houseImage.mas_bottom).mas_offset(MARGIN);
        make.left.mas_equalTo(self.houseImage.mas_left);
    }];
    [_yuyuestatrtimeIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(ICON_W_H, ICON_W_H));
        make.top.mas_equalTo(_yudingtimeIcon.mas_bottom).mas_offset(MARGIN);
        make.left.mas_equalTo(self.yudingtimeIcon.mas_left);
    }];
    [_dingweiIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(ICON_W_H, ICON_W_H));
        make.top.mas_equalTo(_yuyuestatrtimeIcon.mas_bottom).mas_offset(MARGIN);
        make.left.mas_equalTo(self.yudingtimeIcon.mas_left);
    }];
    [_yudingTimeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_yudingtimeIcon.mas_centerY);
        make.left.mas_equalTo(self.yudingtimeIcon.mas_right).mas_offset(MARGIN);
        make.right.mas_equalTo(self.mas_right).mas_offset(-MARGIN);
    }];
    [_zuyueStarTimeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.yudingtimeIcon.mas_right).mas_offset(MARGIN);
        make.centerY.mas_equalTo(_yuyuestatrtimeIcon.mas_centerY);
        make.right.mas_equalTo(self.mas_right).mas_offset(-MARGIN);
    }];
    [_dingweiLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_yudingtimeIcon.mas_right).mas_offset(MARGIN);
        make.centerY.mas_equalTo(_dingweiIcon.mas_centerY);
        make.right.mas_equalTo(self.mas_right).mas_offset(-MARGIN);
    }];
    [_lineview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_dingweiLable.mas_bottom).mas_offset(MARGIN);
        make.left.mas_equalTo(self.bgView.mas_left).mas_offset(MARGIN);
        make.right.mas_equalTo(self.bgView.mas_right).mas_offset(-MARGIN);
        make.height.mas_offset(0.5);
    }];
    
    self.funcBtnArray = [[NSMutableArray alloc] init];
    for (int i = 0 ; i < 4; i++) {
        HYFillLongButton *btn = [HYFillLongButton buttonCorWithTitleStringKey:@""
                                                             target:self
                                                           selector:@selector(clickBottomBtn:)];
        [self.funcBtnArray addObject:btn];
        [self addSubview:btn];
        CGFloat btn_W = MARGIN * 6;
        CGFloat btn_H = MARGIN * 3;
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_offset(CGSizeMake(btn_W, btn_H));
            make.top.mas_equalTo(_lineview.mas_bottom).mas_offset(MARGIN);
            make.right.mas_equalTo(self.bgView.mas_right).mas_offset(-MARGIN *(i + 1) - btn_W*i);
        }];
    }
}

/**
 设置按钮数组 [@“取消”，@“支付”，@“去电”]
 */
- (void)setBtnArray:(NSArray *)array
{
    for (int i = 0 ; i< _funcBtnArray.count; i ++) {
        HYFillLongButton *btn = _funcBtnArray[i];
        if (i < array.count) {
            btn.hidden = NO;
            [btn setTitle:array[i] forState:UIControlStateNormal];
        }else{
            btn.hidden = YES;
        }
    }
}

- (void)clickBottomBtn:(UIButton *)sender
{
    if(self.clickFuncBtnBlock){
        self.clickFuncBtnBlock(sender.currentTitle);
    }
}

@end
