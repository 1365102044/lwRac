//
//  HYTouSuJianYiListTableViewCell.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/9.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYTouSuJianYiListTableViewCell.h"

@interface HYTouSuJianYiListTableViewCell ()
@end
@implementation HYTouSuJianYiListTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self.cellView hiddenReplyView];
        [self layoutIfNeeded];
        [self setNeedsLayout];
        
        [self.cellView.cancleBtn addTarget:self action:@selector(clickCancleBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)clickCancleBtn
{
    if (self.clickBlock) {
        self.clickBlock(self.indexPath);
    }
}

@end
