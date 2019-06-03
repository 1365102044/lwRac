//
//  HYHouseTopView.h
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/25.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYBaseView.h"
#import "HYRightImageButton.h"
#import "HYDefaultTextField.h"
#import "LWHouseListViewModel.h"
#import "HYHourseChooseListView.h"

#import <ReactiveObjC.h>
@interface HYHouseTopView : HYBaseView

//- (void)updateClearBtnContransWithisShow:(BOOL)isShow;

+ (instancetype)createTopViewBindViewModel:(LWHouseListViewModel *)viewModel;
@end
