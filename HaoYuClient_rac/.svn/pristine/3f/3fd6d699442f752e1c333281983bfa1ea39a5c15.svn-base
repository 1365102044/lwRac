//
//  HYDatePickerManager.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/8.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYDatePickerManager.h"
#import "WSDatePickerView.h"
@interface HYDatePickerManager ()
@property (nonatomic, copy) HYEventCallBackBlock  callBackBlock;
@end

@implementation HYDatePickerManager

+ (instancetype)showDatePicker:(HYEventCallBackBlock)callBackBlock DateStyle:(WSDateStyle)DateStyle
{
    HYDatePickerManager *temp = [[HYDatePickerManager alloc] init];
    temp.callBackBlock = callBackBlock;
    //年-月-日-时-分
    WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyle CompleteBlock:^(NSDate *selectDate) {
        NSString *dateString = [selectDate stringWithFormat:@"yyyy-MM-dd HH:mm"];
        LWLog(@"选择的日期：%@",dateString);
        if (temp.callBackBlock) {
            temp.callBackBlock(dateString);
        }
    }];
    datepicker.minLimitDate  = [NSDate date];
    datepicker.dateLabelColor = [UIColor orangeColor];//年-月-日-时-分 颜色
    datepicker.datePickerColor = [UIColor blackColor];//滚轮日期颜色
    datepicker.doneButtonColor = [UIColor orangeColor];//确定按钮的颜色
    [datepicker show];
    return temp;
}
@end
