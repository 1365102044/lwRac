//
//  HYYuYueListTableViewCell.h
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/5.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYBaseTableViewCell.h"

@interface HYYuYueListTableViewCell : HYBaseTableViewCell
@property (nonatomic, copy) void(^clickFuncBlock)(NSIndexPath *indexpath,NSString * funcStr) ;
/**
 赋值  
 */
@property (nonatomic, strong) NSDictionary * dataDict;

@end
