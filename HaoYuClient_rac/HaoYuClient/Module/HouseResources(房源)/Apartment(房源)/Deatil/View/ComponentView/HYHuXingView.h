//
//  HYHuXingView.h
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/11.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYBaseView.h"
#import "HYBaseCollectionView.h"
@interface HYHuXingView : HYBaseView
@property (nonatomic, strong) HYDefaultLabel * moreLable;
@property (nonatomic, copy) HYEventCallBackBlock clickCellBlock;
@property (nonatomic, strong) NSArray * dataArray;

@end
