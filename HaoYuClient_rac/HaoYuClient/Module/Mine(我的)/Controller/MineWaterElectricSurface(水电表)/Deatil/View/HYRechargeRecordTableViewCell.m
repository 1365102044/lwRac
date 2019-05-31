//
//  HYRechargeRecordTableViewCell.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/10/31.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYRechargeRecordTableViewCell.h"

@interface HYRechargeRecordTableViewCell ()
@property (nonatomic, strong) HYDefaultLabel * moneyLable;
@property (nonatomic, strong) HYDefaultLabel * timeLable;
@property (nonatomic, strong) UIImageView * icon;

@end

@implementation HYRechargeRecordTableViewCell

- (void)setRechargeRecordModel:(HYRechargeRecordListInforModel *)rechargeRecordModel
{
    _moneyLable.text = [NSString stringWithFormat:@"%@元",rechargeRecordModel.rechargeCount];
    _timeLable.text = rechargeRecordModel.rechargeDate;
    if (rechargeRecordModel.surfaceType == 2) {
        _icon.image = IMAGENAME(@"jiaofei_dian_icon");
    }else{
        if(rechargeRecordModel.waterMeter == 20){
            _icon.image = IMAGENAME(@"jiaofeo_re_shui_icon");
        }else{
            _icon.image = IMAGENAME(@"jiaofei_shui_icon");
        }
    }
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = HYCOLOR.color_c1;
        self.contentView.backgroundColor = HYCOLOR.color_c0;
        [self confiUI];
    }
    return self;
}

- (void)confiUI
{
    _icon = [[UIImageView alloc] init];
    
    _moneyLable = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(15) text:@"" textColor:HYCOLOR.color_c4];
    _timeLable = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(15) text:@"" textColor:HYCOLOR.color_c4];
    [self.contentView addSubviews:@[_icon,_moneyLable,_timeLable]];
    
    [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(MARGIN*2, MARGIN*2));
        make.left.mas_equalTo(self.contentView.mas_left).mas_offset(MARGIN);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
    }];
    [_moneyLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_icon.mas_right).mas_offset(MARGIN*2);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
    }];
    [_timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-MARGIN/2);
        make.width.mas_offset(MARGIN*16);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
    }];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).mas_offset(MARGIN);
        make.right.mas_equalTo(self.mas_right).mas_offset(-MARGIN);
        make.top.mas_equalTo(self.mas_top).mas_offset(MARGIN/2);
        make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-MARGIN/2);
    }];
}
@end
