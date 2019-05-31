//
//  LWTouSuJianYiReply.h
//  HaoYuClient
//
//  Created by 刘文强 on 2019/5/10.
//  Copyright © 2019年 LWQ. All rights reserved.
//

#import "HYBaseView.h"
#import "HYAttributedStringLabel.h"
NS_ASSUME_NONNULL_BEGIN

@interface LWTouSuJianYiReplyView : HYBaseView

@property (nonatomic, strong) HYAttributedStringLabel * contentLable;

- (void)setDataArray:(NSArray *)dataArray replyContent:(NSString *)replycontent paramForPingJia:(NSDictionary *)paramForPingJia hiddenPingJiaBtn:(BOOL)hiddenPingJiaBtn;

/** （维修、保洁）id */
@property (nonatomic, strong) NSDictionary * paraForPingJia;


@end

NS_ASSUME_NONNULL_END
