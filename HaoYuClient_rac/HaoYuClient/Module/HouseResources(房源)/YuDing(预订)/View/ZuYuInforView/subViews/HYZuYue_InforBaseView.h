//
//  HYZuYue_InforBaseView.h
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/14.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYBaseView.h"
#import "HYAttributedStringLabel.h"
@interface HYZuYue_InforBaseView : HYBaseView
@property (nonatomic, strong) HYAttributedStringLabel * titleLable;
@property (nonatomic, strong) HYBaseView * itemView;
/**
 [{@"leftStr":@"",
   @"rightStr":@""
 }]
 */
@property (nonatomic, strong) NSArray * dataArray;
@property (nonatomic, copy) HYEventCallBackBlock callBackBlock;

@end
