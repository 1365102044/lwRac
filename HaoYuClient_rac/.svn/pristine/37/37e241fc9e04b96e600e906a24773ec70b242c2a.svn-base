//
//  HYYuYueMainView.h
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/12.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYBaseView.h"

@interface HYYuYueMainView : HYBaseView
@property (nonatomic, strong) NSMutableDictionary * param;
@property (nonatomic, copy) HYEventCallBackBlock clickMenDianBlock;
@property (nonatomic, copy) HYEventCallBackBlock clickHuXingBlock;
//项目数据
@property (nonatomic, strong) NSArray * projectDatas;
// 户型数据
@property (nonatomic, strong) NSArray * huxingDatas;
/**
 检查参数
 */
- (BOOL)checkPara;
/**
 来之房源详情 固定项目不能选择
 */
- (void)setProjectWhenFromProjectDeatil:(id)projectModel;

@end
