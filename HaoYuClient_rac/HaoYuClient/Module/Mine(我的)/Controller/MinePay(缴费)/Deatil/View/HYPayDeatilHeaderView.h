//
//  HYPayDeatilHeaderView.h
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/1.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYBaseView.h"
#import "HYContractModel.h"

@interface HYPayDeatilHeaderView : HYBaseView
@property (nonatomic, strong) HYDefaultLabel *bottom_func;

@property (nonatomic, strong) HYContractModel * contractModel;
@property (nonatomic, copy) HYEventCallBackBlock clickSurfaceIconBlock;
@end
