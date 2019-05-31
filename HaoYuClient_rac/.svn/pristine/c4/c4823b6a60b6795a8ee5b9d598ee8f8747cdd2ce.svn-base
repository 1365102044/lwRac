//
//  HYBaseViewController.h
//  HaoYuClient
//
//  Created by 刘文强 on 2018/5/18.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYBaseScrollView.h"
#import "HYBaseTableView.h"
#import "HYBaseView.h"
@interface HYBaseViewController : UIViewController
{
    CGFloat MARGIN;
}

@property (weak, nonatomic) id<UIGestureRecognizerDelegate> restoreInteractivePopGestureDelegate;

@property (nonatomic, strong) HYBaseScrollView * MainScrollView;
/**
 数据源
 */
@property (nonatomic, strong) NSMutableArray * dataMutableArray;

/**
 列表的刷新
 */
- (void)requestListInfor;

/**
 是否能够点击 （默认是NO，按钮跳转时，在网络请求后 YES）
 */
@property (nonatomic, assign) BOOL isCanClickBooL;

/**
 是否禁止返回手势
 */
@property (nonatomic, assign) BOOL closePopGesture;


@end
