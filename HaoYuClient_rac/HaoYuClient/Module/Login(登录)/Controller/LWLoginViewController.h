//
//  LWLoginViewController.h
//  HaoYuClient
//
//  Created by 刘文强 on 2019/3/13.
//  Copyright © 2019年 LWQ. All rights reserved.
//

#import "HYBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface LWLoginViewController : HYBaseViewController
@property (nonatomic, copy) HYEventCallBackBlock  PushMineBlock;
/**
 点击过来的 tabbarindex
 */
@property (nonatomic, assign) NSInteger sourceTabbarIndex;
@end

NS_ASSUME_NONNULL_END
