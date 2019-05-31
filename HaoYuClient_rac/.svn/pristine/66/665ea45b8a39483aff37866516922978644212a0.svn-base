//
//  HYWaterSurfaceCellView.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/5/31.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYWaterSurfaceCellView.h"

@implementation HYWaterSurfaceCellView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.bgView = [[UIView alloc] init];
        self.houseImage = [[UIImageView alloc] init];
        self.houseNameLable = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(15) text:@"" textColor:HYCOLOR.color_c4];
        self.houseWhereLable = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(12) text:@"" textColor:HYCOLOR.color_c4];
        self.houseLayoutLable = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(12) text:@"" textColor:HYCOLOR.color_c4];
        self.bgView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.bgView];
        [self.bgView addSubview:self.houseImage];
        [self.bgView addSubview:self.houseWhereLable];
        [self.bgView addSubview:self.houseLayoutLable];
        [self.bgView addSubview:self.houseNameLable];
        
        CGFloat MAGR = ADJUST_PERCENT_FLOAT(10);
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(self).mas_offset(MAGR);
            make.right.mas_equalTo(self.mas_right).mas_offset(-MAGR);
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

        self.bgView.layer.cornerRadius = 4;
        self.bgView.layer.masksToBounds = YES;
    }
    return self;
}

@end
