//
//  HYLevelLable.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/9/19.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYLevelLable.h"

@implementation HYLevelLable

+ (instancetype)creatLevelLable:(NSString *)leftStr rightStr:(NSString *)rightStr
{
    HYLevelLable *instance = [[HYLevelLable alloc] init];
    [instance addUI];
    instance.left_L.text = leftStr;
    instance.right_L.text = rightStr;
    return instance;
}

- (void)addUI
{
    self.left_L = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(15)
                                           text:@"" textColor:HYCOLOR.color_c4];
    self.right_L = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(15)
                                           text:@"" textColor:HYCOLOR.color_c4];
    [self addSubview:_left_L];
    [self addSubview:_right_L];
    
    [_left_L mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).mas_offset(2);
        make.left.mas_equalTo(self.mas_left);
        make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-2);
    }];
    [_right_L mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).mas_offset(2);
        make.right.mas_equalTo(self.mas_right);
        make.centerY.mas_equalTo(_left_L.mas_centerY);
    }];
}
@end
