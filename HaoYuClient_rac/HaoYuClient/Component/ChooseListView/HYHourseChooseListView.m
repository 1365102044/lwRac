//
//  HYHourseChooseListView.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/7/13.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYHourseChooseListView.h"

@implementation HYHourseChooseListView

+ (instancetype)showChooseListView:(NSArray *)dataArr
                     referenceView:(id)referenceView
                     callBackBlock:(HYEventCallBackBlock)callBackBlock
{
    HYHourseChooseListView *listview =  [self showChooseListView:dataArr callBackBlock:callBackBlock];
    [listview updateContrans:(UIView *)referenceView];
    return listview;
}


@end
