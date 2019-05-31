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

+ (instancetype)showDatePicker:(HYEventCallBackBlock)callBackBlock DateStyle:(WSDateStyle)DateStyle;

@end
