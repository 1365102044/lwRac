//
//  HYHouseDeatilHuXingCollectionViewCell.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/11.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYHouseDeatilHuXingCollectionViewCell.h"

@implementation HYHouseDeatilHuXingCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        _houseItemName = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(14)
                                                  text:@"" textColor:HYCOLOR.color_c4];
        _houseItemImageView = [[UIImageView alloc] init];
        [self addSubview:_houseItemImageView];
        [self addSubview:_houseItemName];
        [_houseItemImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_offset(CGSizeMake(ADJUST_PERCENT_FLOAT(240), ADJUST_PERCENT_FLOAT(120)));
            make.left.top.mas_equalTo(self);
        }];
        [_houseItemName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_houseItemImageView.mas_bottom).mas_offset(ADJUST_PERCENT_FLOAT(10));
            make.left.right.mas_equalTo(self);
        }];
    }
    return self;
}
@end
