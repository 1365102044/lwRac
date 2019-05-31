//
//  HYBaseWebViewController.h
//  HaoYuClient
//
//  Created by 刘文强 on 2018/5/18.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYBaseViewController.h"

@interface HYBaseWebViewController : HYBaseViewController

/**
 签约协议  1
 预订协议  2
 */
- (void)setWebUrlWithType:(NSInteger)type;

@end
