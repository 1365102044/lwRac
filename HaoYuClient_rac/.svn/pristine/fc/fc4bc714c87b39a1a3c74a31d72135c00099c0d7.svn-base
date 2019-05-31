//
//  HYChooseListView.h
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/7.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYChooseBaseView.h"

@interface HYChooseListView : HYChooseBaseView
@property (nonatomic, strong) HYBaseTableView * tableView;
@property (nonatomic, strong) NSArray * dataArr;
@property (nonatomic, strong) HYDefaultLabel * titleL;

+ (instancetype)showChooseListView:(NSArray *)dataArr callBackBlock:(HYEventCallBackBlock)callBackBlock;
- (void)updateContrans:(UIView *)referenceView;
- (void)setUI;
@end
