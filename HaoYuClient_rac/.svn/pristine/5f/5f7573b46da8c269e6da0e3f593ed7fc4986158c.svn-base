//
//  HYContactUsView.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/11.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYContactUsView.h"

@implementation HYContactUsView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _kefuPhoneLable = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(13)
                                                   text:@""
                                              textColor:HYCOLOR.color_c2];
        _addressLable = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(13)
                                                   text:@""
                                              textColor:HYCOLOR.color_c2];
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = HYCOLOR.color_c3;
        UIView *line1 = [[UIView alloc] init];
        line1.backgroundColor = HYCOLOR.color_c6;
        
        UIImageView *kefuicon = [[UIImageView alloc] init];
        kefuicon.image = IMAGENAME(@"mine_yuding_n");
        [self addSubview:kefuicon];
        UIImageView *dingweiicon = [[UIImageView alloc] init];
        dingweiicon.image = IMAGENAME(@"mine_yuding_n");
        [self addSubview:dingweiicon];
        
        HYDefaultLabel *titleLable = [HYDefaultLabel labelWithFont:SYSTEM_MEDIUMFONT(15)
                                                              text:@"联系我们"
                                                         textColor:HYCOLOR.color_c4];
        
//        MKMapView *mapView = [[MKMapView alloc] init];
        UIView  *mapView = [[UIView alloc] init];
        
        [self addSubview:mapView];
        [self addSubview:titleLable];
        [self addSubview:_addressLable];
        [self addSubview:_kefuPhoneLable];
        [self addSubview:line];
        [self addSubview:line1];
        
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_offset(1);
            make.left.top.mas_equalTo(self).mas_offset(MARGIN);
            make.height.mas_offset(ADJUST_PERCENT_FLOAT(25));
        }];
        [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(line.mas_right).mas_offset(MARGIN);
            make.centerY.mas_equalTo(line.mas_centerY);
        }];
        [kefuicon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_offset(CGSizeMake(MARGIN*2, MARGIN*2));
            make.top.mas_equalTo(titleLable.mas_bottom).mas_offset(MARGIN*2);
            make.left.mas_equalTo(self.mas_left).mas_offset(MARGIN);
        }];
        [_kefuPhoneLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(kefuicon.mas_centerY);
            make.left.mas_equalTo(kefuicon.mas_right).mas_offset(MARGIN);
        }];
        [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_offset(0.5);
            make.left.mas_equalTo(self.mas_left).mas_offset(MARGIN);
            make.right.mas_equalTo(self.mas_right).mas_offset(-MARGIN);
            make.top.mas_equalTo(kefuicon.mas_bottom).mas_offset(MARGIN);
        }];
        [dingweiicon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_offset(CGSizeMake(MARGIN*2, MARGIN*2));
            make.top.mas_equalTo(line1.mas_bottom).mas_offset(MARGIN);
            make.left.mas_equalTo(self.mas_left).mas_offset(MARGIN);
        }];
        [_addressLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(dingweiicon.mas_centerY);
            make.left.mas_equalTo(dingweiicon.mas_right).mas_offset(MARGIN);
        }];
        [mapView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).mas_offset(MARGIN);
            make.top.mas_equalTo(dingweiicon.mas_bottom).mas_offset(MARGIN);
            make.right.mas_equalTo(self.mas_right).mas_offset(-MARGIN);
            make.height.mas_offset(MARGIN*12);
            make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-MARGIN);
        }];
    }
    return self;
}

@end
