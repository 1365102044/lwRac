//
//  HYBillListItemView.h
//  HaoYuClient
//
//  Created by 刘文强 on 2018/5/25.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYBaseView.h"

@interface HYBillListItemView : HYBaseView

@property (nonatomic, strong) HYDefaultLabel * titleLable;
@property (nonatomic, strong) HYDefaultLabel * timeLable;
@property (nonatomic, strong) HYDefaultLabel * priceLable;
@property (nonatomic, strong) HYDefaultLabel * descLalbe;

+ (instancetype)creatItemView;
@end
