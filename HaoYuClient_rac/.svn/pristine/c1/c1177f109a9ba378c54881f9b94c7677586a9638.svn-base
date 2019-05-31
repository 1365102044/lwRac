//
//  LWTouSuJianYiReplyTableViewCell.m
//  HaoYuClient
//
//  Created by 刘文强 on 2019/5/10.
//  Copyright © 2019年 LWQ. All rights reserved.
//

#import "LWTouSuJianYiReplyTableViewCell.h"

@implementation LWTouSuJianYiReplyTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        
    }
    return self;
}
-(void)setDataModel:(HYTouSuJianYiModel *)dataModel
{
    [super setDataModel:dataModel];
    
    BOOL res = (dataModel.grade && ![dataModel.grade isEqualToString:@""])?YES:NO;
    [self.cellView.fanKuiInforView setDataArray:dataModel.picurlArray replyContent:dataModel.repairDetail paramForPingJia:@{@"id":dataModel.customId?:@"",@"type":@"3"} hiddenPingJiaBtn:res];
}
@end
