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
@property(nonatomic,strong) UIView * centerView;
@property(nonatomic,strong) HYDefaultLabel * titleLable;
@property(nonatomic,strong)  HYAttributedStringLabel* messageLable;
@property(nonatomic,strong) HYDefaultLabel * leftBtn_Lable;
@property(nonatomic,strong) HYDefaultLabel * rightBtn_Lable;
@property(nonatomic,strong) UIView * backView;
@end
