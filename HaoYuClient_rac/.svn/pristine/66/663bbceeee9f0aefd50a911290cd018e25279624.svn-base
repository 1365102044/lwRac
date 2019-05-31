//
//  HYMessageDeatilCellView.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/5/28.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYMessageDeatilCellView.h"

@interface HYMessageDeatilCellView()


@end

@implementation HYMessageDeatilCellView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = HYCOLOR.color_c0;
        
        self.topLable = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(13) text:@"" textColor:HYCOLOR.color_c4];
        self.descLable = [HYAttributedStringLabel labelWithFont:SYSTEM_REGULARFONT(11) text:@"" textColor:HYCOLOR.color_c4];
        self.arrowIcon = [[UIImageView alloc] init];
        self.arrowIcon.image = IMAGENAME(@"shopping_point_n");
        [self addSubview:self.topLable];
        [self addSubview:self.descLable];
        [self addSubview:self.arrowIcon];
        
        [self.topLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top).mas_offset(ADJUST_PERCENT_FLOAT(10));
            make.left.mas_equalTo(self.mas_left).mas_offset(ADJUST_PERCENT_FLOAT(10));
            make.height.mas_offset(ADJUST_PERCENT_FLOAT(20));
        }];
        [self.arrowIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_offset(CGSizeMake(20, 20));
            make.centerY.mas_equalTo(self.topLable.mas_centerY);
            make.right.mas_equalTo(self.mas_right).mas_offset(-ADJUST_PERCENT_FLOAT(20));
        }];
        [self.descLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.topLable.mas_bottom).mas_offset(ADJUST_PERCENT_FLOAT(10));
            make.left.mas_equalTo(self.topLable.mas_left).mas_offset(ADJUST_PERCENT_FLOAT(10));
            make.right.mas_equalTo(self.arrowIcon.mas_left);
            make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-ADJUST_PERCENT_FLOAT(10));
        }];
    }
    return self;
}



@end
