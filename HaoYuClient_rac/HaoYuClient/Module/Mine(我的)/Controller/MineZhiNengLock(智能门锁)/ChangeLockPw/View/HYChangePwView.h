//
//  HYChangePwView.h
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/8.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYBaseView.h"
//typedef void(^postCodeBlock)();
typedef void(^getCodeBlock)(void);
@interface HYChangePwView : HYBaseView
@property (nonatomic, copy) HYEventCallBackBlock callBlock;
@property (nonatomic, copy) getCodeBlock  getCodeBlock;
- (void)startTimer;
@end
