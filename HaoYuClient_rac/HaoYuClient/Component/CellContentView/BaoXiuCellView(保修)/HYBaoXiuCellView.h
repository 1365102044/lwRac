//
//  HYBaoXiuCellView.h
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/1.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYBaseCellView.h"
#import "LWTouSuJianYiReplyView.h"
@interface HYBaoXiuCellView : HYBaseCellView
@property (nonatomic, strong) LWTouSuJianYiReplyView * replyView;
- (void)hiddenReplyView:(BOOL)hidden;
@end
