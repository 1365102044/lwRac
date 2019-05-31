//
//  HYAboutUsView.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/5/25.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYAboutUsView.h"
#import "HYAttributedStringLabel.h"
@interface HYAboutUsView()
@property (nonatomic, strong) UIImageView * logoView;
@property (nonatomic, strong) HYDefaultLabel * versionLable;
@property (nonatomic, strong) HYDefaultLabel * descLable;

@end
@implementation HYAboutUsView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.logoView = [[UIImageView alloc] init];
        self.logoView.image = IMAGENAME(@"aboutsicon");
        [self addSubview:self.logoView];
        
        self.versionLable = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(20) text:@"好寓 1.0" textColor:HYCOLOR.color_c4];
        [self addSubview:self.versionLable];
        self.versionLable.backgroundColor = [UIColor clearColor];
        self.descLable = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(13) text:@"" textColor:HYCOLOR.color_c4];
        self.descLable.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.descLable];
        self.descLable.backgroundColor = [UIColor clearColor];
        self.descLable.hidden = YES;
        
        NSString *tems = @"  好寓，一个有态度的都市青年共享社区，集舒适空间、智能家居、贴心服务、多元社交于一体，始终致力于为租客提供完美的居住体验。";
//        NSString *temp = @"成都铂颢公寓管理有限公司 © 2018-2019";
        HYAttributedStringLabel *banquan_L = [HYAttributedStringLabel labelWithFont:SYSTEM_REGULARFONT(12) text:tems textColor:HYCOLOR.color_c2];
        [self addSubview:banquan_L];
        banquan_L.numberOfLines = 0;
        [banquan_L setAttributedStringWithContentArray:@[@{@"color" : HYCOLOR.color_c2,
                                                             @"content" : tems,
                                                             @"size" : SYSTEM_REGULARFONT(12),
                                                             @"lineSpacing": @(5)},]];
        banquan_L.textAlignment = NSTextAlignmentCenter;
        [self.logoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top).mas_offset(ADJUST_PERCENT_FLOAT(130));
            make.size.mas_offset(CGSizeMake(ADJUST_PERCENT_FLOAT(160), ADJUST_PERCENT_FLOAT(80)));
            make.centerX.mas_equalTo(self.mas_centerX);
        }];
        [self.versionLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.height.mas_offset(ADJUST_PERCENT_FLOAT(20));
            make.top.mas_equalTo(self.logoView.mas_bottom).mas_offset(ADJUST_PERCENT_FLOAT(20));
        }];
        [self.descLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.left.mas_equalTo(self.mas_left).mas_offset(ADJUST_PERCENT_FLOAT(40));
            make.right.mas_equalTo(self.mas_right).mas_offset(-ADJUST_PERCENT_FLOAT(40));
            make.top.mas_equalTo(self.versionLable.mas_bottom).mas_offset(ADJUST_PERCENT_FLOAT(20));
        }];
        [banquan_L mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.bottom.mas_equalTo(self.mas_bottom).offset(-30);
            make.top.mas_equalTo(self.versionLable.mas_bottom).mas_offset(ADJUST_PERCENT_FLOAT(30));
            make.centerX.mas_equalTo(self.mas_centerX);
            make.left.mas_equalTo(self.mas_left).mas_offset(ADJUST_PERCENT_FLOAT(30));
            make.right.mas_equalTo(self.mas_right).mas_offset(ADJUST_PERCENT_FLOAT(-30));
        }];
        
        self.versionLable.text = [NSString stringWithFormat:@"好寓 %@", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
        
    }
    return self;
}

@end
