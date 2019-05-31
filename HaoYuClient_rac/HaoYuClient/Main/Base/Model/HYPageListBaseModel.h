//
//  HYPageListBaseModel.h
//  HaoYuClient
//
//  Created by 刘文强 on 2018/5/18.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYBaseModel.h"

@interface HYPageListBaseModel : HYBaseModel
@property(nonatomic,assign) NSInteger  curPage;
@property(nonatomic,assign) NSInteger  totalRows;
@property(nonatomic,strong) NSArray * data;
@property(nonatomic,assign) NSInteger  success;
@end
