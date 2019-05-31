//
//  HYHouseDeatilHuXingCollectionViewCell.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/11.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYHouseDeatilHuXingCollectionViewCell.h"

@implementation HYHouseDeatilHuXingCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _houseItemImageView = [[UIImageView alloc] init];
        [self addSubview:_houseItemImageView];
        [_houseItemImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self);
        }];
    }
    return self;
}
@end
