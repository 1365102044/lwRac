//
//  HYChooseBaseView.h
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/19.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYBaseView.h"

@interface HYChooseBaseView : HYBaseView
@property (nonatomic, strong) HYBaseView * bgView;
@property (nonatomic, strong) HYBaseView * maskView;
@property (nonatomic, strong) UIWindow * window;
@property (nonatomic, copy) HYEventCallBackBlock  callBackBlock;
@property (nonatomic, copy) HYEventCallBackBlock  clickDismissBlock;
- (void)dismiss;

@end
