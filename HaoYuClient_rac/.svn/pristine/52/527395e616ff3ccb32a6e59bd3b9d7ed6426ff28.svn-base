//
//  LWHomeHotTableViewCell.m
//  HaoYuClient
//
//  Created by 刘文强 on 2019/5/10.
//  Copyright © 2019年 LWQ. All rights reserved.
//

#import "LWHomeHotTableViewCell.h"

@implementation LWHomeHotTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _cellView = [[LWHomeHotTableViewCellView alloc] init];
        [self.contentView addSubview:_cellView];
        [_cellView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.contentView);
        }];
    }
    return self;
}
- (void)setDataArray:(NSArray *)data
{
    _cellView.dataModelArrary = data;
}
@end
