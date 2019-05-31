//
//  HYTongZhuRenView.h
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/20.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYBaseView.h"

@interface HYTongZhuRenView : HYBaseView
@property (nonatomic, strong) HYBaseView * tongZhuRenSubView;
@property (nonatomic, assign) BOOL isHiddenAdd;
@property (nonatomic, strong) NSMutableArray * dataArr;
- (instancetype)initWithFrame:(CGRect)frame sourcevc:(HYBaseViewController *)sourcevc;
@end
