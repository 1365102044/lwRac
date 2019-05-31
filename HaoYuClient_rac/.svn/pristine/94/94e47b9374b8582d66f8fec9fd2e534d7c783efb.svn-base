//
//  HYDoorLockCellView.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/1.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYDoorLockCellView.h"

@implementation HYDoorLockCellView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       
        self.funcLabel.backgroundColor           = [UIColor redColor];
        self.funcLabel.userInteractionEnabled    = YES;
        self.funcLabel.textAlignment             = NSTextAlignmentCenter;
        [self.bgView addSubview:self.funcLabel];
        [self.funcLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.houseImage.mas_bottom).mas_offset(MAGR);
            make.size.mas_offset(CGSizeMake(ADJUST_PERCENT_FLOAT(80), ADJUST_PERCENT_FLOAT(25)));
            make.right.mas_equalTo(self.bgView.mas_right).mas_offset(-MAGR*2);
        }];
        [self.bgView updateConstraints];
        [self.funcLabel setBoundWidth:0 cornerRadius:4];
    }
    return self;
}

@end
