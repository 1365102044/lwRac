//
//  HYChooseListTitleTableViewCell.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/9/21.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYChooseListTitleTableViewCell.h"

@implementation HYChooseListTitleTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _inforLable = [HYLevelLable creatLevelLable:@"" rightStr:@""];
        [self.contentView addSubview:_inforLable];
        [self.inforLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(self.contentView).mas_offset(ADJUST_PERCENT_FLOAT(10)/2);
            make.right.bottom.mas_equalTo(self.contentView).mas_offset(-ADJUST_PERCENT_FLOAT(10)/2);
        }];
    }
    return self;
}

@end
