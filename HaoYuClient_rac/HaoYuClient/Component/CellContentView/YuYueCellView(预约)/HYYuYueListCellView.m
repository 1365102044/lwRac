//
//  HYYuYueListCellView.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/5.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYYuYueListCellView.h"

@implementation HYYuYueListCellView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.zuyueStarTimeLable.hidden = YES;
        self.yuyuestatrtimeIcon.hidden = YES;
        [self.dingweiIcon mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_offset(CGSizeMake(ADJUST_PERCENT_FLOAT(15), ADJUST_PERCENT_FLOAT(15)));
            make.top.mas_equalTo(self.yudingtimeIcon.mas_bottom).mas_offset(MARGIN);
            make.left.mas_equalTo(self.yudingtimeIcon.mas_left);
        }];
    }
    return self;
}
@end
