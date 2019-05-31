//
//  HYDatePickerManager.h
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/8.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WSDatePickerView.h"
@interface HYDatePickerManager : NSObject

@property (nonatomic, copy) HYEventCallBackBlock callBackDateBlock;

@property (nonatomic, strong) WSDatePickerView * dateView;

+ (instancetype)showDatePicker:(HYEventCallBackBlock)callBackBlock DateStyle:(WSDateStyle)DateStyle;

/**
 滚动到指定的的日期
 */
+ (instancetype)showDatePick:(HYEventCallBackBlock)callBackBlock scrollToDate:(NSDate *)scrollToDate DateStyle:(WSDateStyle)DateStyle;

@end
