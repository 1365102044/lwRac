//
//  HYHomeCollectionViewCell.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/7/12.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYHomeCollectionViewCell.h"

@implementation HYHomeCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _houseItemImageView = [[UIImageView alloc] init];
        _houseNameLable = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(15)
                                                   text:@""
                                              textColor:HYCOLOR.color_c2];
        _housePriceLable = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(13)
                                                    text:@""
                                               textColor:HYCOLOR.color_c2];
        [self.contentView addSubview:_houseItemImageView];
        [self.contentView addSubview:_housePriceLable];
        [self.contentView addSubview:_houseNameLable];
        
        [_houseItemImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self.contentView);
            make.top.mas_equalTo(self.contentView.mas_top).mas_offset(ADJUST_PERCENT_FLOAT(10));
            make.height.mas_offset(ADJUST_PERCENT_FLOAT(160));
        }];
        [_houseNameLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_houseItemImageView.mas_left);
            make.top.mas_equalTo(_houseItemImageView.mas_bottom).mas_offset(ADJUST_PERCENT_FLOAT(10));
        }];
        [_housePriceLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_houseItemImageView.mas_left);
            make.top.mas_equalTo(_houseNameLable.mas_bottom).mas_offset(ADJUST_PERCENT_FLOAT(5));
        }];
        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self);
        }];
        [_houseItemImageView setBoundWidth:0 cornerRadius:6];
    }
    return self;
}
@end
