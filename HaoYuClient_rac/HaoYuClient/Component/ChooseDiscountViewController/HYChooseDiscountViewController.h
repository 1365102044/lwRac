//
//  HYChooseDiscountViewController.h
//  HaoYuClient
//
//  Created by 刘文强 on 2018/9/25.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYBaseTableViewController.h"

@protocol chooseDiscountDelegate <NSObject>
- (void)alearySelectDicount:(NSArray *)discounts indexPath:(NSIndexPath *)indexPath;
@end
@interface HYChooseDiscountViewController : HYBaseTableViewController
@property (nonatomic, strong) NSIndexPath * indexpath;

@property (nonatomic, weak) id<chooseDiscountDelegate> delegate;

+ (instancetype)creatChooseDiscountVCWithDatas:(NSArray *)datas sourceVC:(HYBaseViewController *)sourceVC extend:(id)extend;

@end
