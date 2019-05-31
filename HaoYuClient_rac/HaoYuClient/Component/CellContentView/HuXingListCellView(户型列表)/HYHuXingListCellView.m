//
//  HYHuXingListCellView.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/12.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYHuXingListCellView.h"

@implementation HYHuXingListCellView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        [self addSubview:self.bgView];
        [self.bgView addSubview:self.houseImage];
        [self.bgView addSubview:self.houseWhereLable];
        [self.bgView addSubview:self.houseLayoutLable];
        [self.bgView addSubview:self.houseNameLable];
        [self.bgView addSubview:self.priceLable];
        [self.bgView addSubview:self.funcLabel];
        
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(self).mas_offset(0);
            make.right.mas_equalTo(self.mas_right).mas_offset(-0);
            make.bottom.mas_equalTo(self.mas_bottom);
        }];
        [self.houseImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_offset(CGSizeMake(ADJUST_PERCENT_FLOAT(100), ADJUST_PERCENT_FLOAT(100)));
            make.left.mas_equalTo(self.bgView.mas_left).mas_offset(MAGR);
            make.top.mas_equalTo(self.bgView.mas_top).mas_offset(MAGR);
        }];
        [self.houseNameLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.houseImage.mas_right).mas_offset(MAGR);
            make.top.mas_equalTo(self.houseImage.mas_top);
        }];
        [self.houseWhereLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.houseNameLable.mas_left);
            make.top.mas_equalTo(self.houseNameLable.mas_bottom).mas_offset(MAGR);
        }];
        [self.houseLayoutLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.houseNameLable.mas_left);
            make.top.mas_equalTo(self.houseWhereLable.mas_bottom).mas_offset(MAGR);
        }];
        [self.priceLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.bgView.mas_right).mas_offset(-MARGIN);
            make.centerY.mas_equalTo(self.houseLayoutLable.mas_centerY);
        }];
        [self.funcLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.houseNameLable.mas_left);
            make.top.mas_equalTo(self.houseLayoutLable.mas_bottom).mas_offset(MARGIN);
            make.size.mas_offset(CGSizeMake(MARGIN*6, MARGIN*2));
        }];
        self.funcLabel.textColor = HYCOLOR.color_c4;
        self.funcLabel.textAlignment = NSTextAlignmentCenter;
        [self.funcLabel setBoundWidth:0.5 cornerRadius:4 boardColor:HYCOLOR.color_c6];
    }
    return self;
}

@end
