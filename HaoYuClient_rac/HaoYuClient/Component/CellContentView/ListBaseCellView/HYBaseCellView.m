//
//  HYBaseCellView.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/1.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYBaseCellView.h"

@implementation HYBaseCellView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        MAGR = ADJUST_PERCENT_FLOAT(10);
        self.bgView                     = [[UIView alloc] init];
        self.houseImage                 = [[UIImageView alloc] init];
        self.statuImageView                 = [[UIImageView alloc] init];
        self.houseNameLable             = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(15)
                                                                   text:@""
                                                              textColor:HYCOLOR.color_c4];
        self.houseWhereLable            = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(12)
                                                                   text:@""
                                                              textColor:HYCOLOR.color_c4];
        self.houseLayoutLable           = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(12)
                                                                   text:@""
                                                              textColor:HYCOLOR.color_c4];
        self.bgView.backgroundColor      = [UIColor whiteColor];
        self.funcLabel                   = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(13)
                                                                    text:@""
                                                               textColor:HYCOLOR.color_c0];
        self.hetongDescLable            = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(12)
                                                                   text:@""
                                                              textColor:HYCOLOR.color_c4];
        self.priceLable                 = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(15)
                                                                   text:@""
                                                              textColor:HYCOLOR.color_c3];
    }
    return self;
}
@end
