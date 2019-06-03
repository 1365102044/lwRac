//
//  LWHouseListTableViewManager.h
//  HaoYuClient
//
//  Created by 刘文强 on 2019/6/3.
//  Copyright © 2019年 LWQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LWHouseListViewModel.h"
#import <ReactiveObjC.h>

NS_ASSUME_NONNULL_BEGIN

@interface LWHouseListTableViewManager : NSObject<UITableViewDelegate,UITableViewDataSource>
+ (instancetype)createListTableViewManagerBindViewModel:(LWHouseListViewModel *)viewModel;
@property (nonatomic, strong) RACSubject * pushVcSubject;

@end

NS_ASSUME_NONNULL_END
