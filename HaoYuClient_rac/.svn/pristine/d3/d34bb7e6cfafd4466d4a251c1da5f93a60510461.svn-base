//
//  HYContactUsView.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/11.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYContactUsView.h"
@interface HYContactUsView ()
@property (nonatomic, strong) UIImageView * dingweiicon;
@property (nonatomic, strong) UIView * line1;

@end
@implementation HYContactUsView
/**
 设置定位 更新地图
 */
- (void)setMyLocationCoordinateWithlat:(double)lat lng:(double)lng
{
    [self.mapView removeFromSuperview];
    [self addSubview:self.mapView];
    [_mapView addPointViewWithlat:lat lng:lng];
    [_dingweiicon mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(MARGIN*2, MARGIN*2));
        make.top.mas_equalTo(_line1.mas_bottom).mas_offset(MARGIN);
        make.left.mas_equalTo(self.mas_left).mas_offset(MARGIN);
    }];
    [self.mapView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).mas_offset(MARGIN);
        make.top.mas_equalTo(_dingweiicon.mas_bottom).mas_offset(MARGIN);
        make.right.mas_equalTo(self.mas_right).mas_offset(-MARGIN);
        make.height.mas_offset(MARGIN*12);
        make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-MARGIN);
    }];
}

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
        _line1 = line1;
        UIImageView *kefuicon = [[UIImageView alloc] init];
        kefuicon.image = IMAGENAME(@"house_phone_icon");
        [self addSubview:kefuicon];
        UIImageView *dingweiicon = [[UIImageView alloc] init];
        dingweiicon.image = IMAGENAME(@"location_icon");
        [self addSubview:dingweiicon];
        _dingweiicon = dingweiicon;
        HYDefaultLabel *titleLable = [HYDefaultLabel labelWithFont:SYSTEM_MEDIUMFONT(15)
                                                              text:@"联系我们"
                                                         textColor:HYCOLOR.color_c4];
        
        [self addSubview:titleLable];
        [self addSubview:_addressLable];
        [self addSubview:_kefuPhoneLable];
        [self addSubview:line];
        [self addSubview:line1];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_offset(1);
            make.left.top.mas_equalTo(self).mas_offset(MARGIN);
            make.height.mas_offset(ADJUST_PERCENT_FLOAT(20));
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
            make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-MARGIN*2);
        }];
        [_addressLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(dingweiicon.mas_centerY);
            make.left.mas_equalTo(dingweiicon.mas_right).mas_offset(MARGIN);
        }];
    }
    return self;
}

- (HYMapView*)mapView
{
    if (!_mapView) {
        _mapView = [HYMapView creatMyMapView:CGRectMake(MARGIN, 0, SCREEN_WIDTH-MARGIN*2, MARGIN*12) mapType:LWlocationType];
    }
    return _mapView;
}
@end
