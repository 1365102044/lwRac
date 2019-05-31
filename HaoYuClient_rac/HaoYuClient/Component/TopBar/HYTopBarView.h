//
//  HYTopBarView.h
//  HaoYuClient
//
//  Created by 刘文强 on 2018/5/28.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYBaseView.h"

typedef void(^callBackBlock)(NSInteger index);

@interface HYTopBarView : HYBaseView
+ (instancetype)creatTopBarWithDataArr:(NSArray *)dataArr selectColor:(UIColor *)selectColor callBack:(callBackBlock)callBackBlock;
- (void)selectIndex:(NSInteger)index;

@property (nonatomic, assign) BOOL isNotCanClickBool;

@end
