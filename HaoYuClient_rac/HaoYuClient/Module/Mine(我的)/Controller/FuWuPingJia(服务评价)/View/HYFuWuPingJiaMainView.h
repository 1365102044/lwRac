//
//  HYFuWuPingJiaMainView.h
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/5.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYBaseView.h"
#import "HYScoreView.h"
#import "HYPlaceHolderTextView.h"
@interface HYFuWuPingJiaMainView : HYBaseView
@property (nonatomic, strong) HYDefaultLabel * commitLable;
@property (nonatomic, copy) HYScoreView * scoreView;
@property (nonatomic, strong) HYPlaceHolderTextView * textView;
@end
