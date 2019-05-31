//
//  HYAlertCenterView.h
//  HaoYuClient
//
//  Created by 刘文强 on 2018/5/24.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYBaseView.h"
#import "HYAttributedStringLabel.h"
@interface HYAlertCenterView : HYBaseView

@property(nonatomic,strong)  HYAttributedStringLabel* messageLable;
//是否 点击按钮后就关闭， 默认是YES
@property (nonatomic, assign) BOOL AutoDismiss;

/**
 中部弹框 mesg 文字居左的
 */
+ (instancetype)showAlerCenterViewWithTitle:(NSString *)title
                            message:(NSString *)message
                         titleArray:(NSArray *)titleArray
                          callBlock:(HYEventCallBackBlock)callBlock;

@end
