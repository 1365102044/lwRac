//
//  HYPayListCellView.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/1.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYPayListCellView.h"

@implementation HYPayListCellView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self.bgView addSubview:self.hetongDescLable];
        
        [self.hetongDescLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.houseNameLable.mas_left);
            make.top.mas_equalTo(self.houseLayoutLable.mas_bottom).mas_offset(MAGR);
        }];
        [self.bgView updateConstraints];
    }
    return self;
}

@end
