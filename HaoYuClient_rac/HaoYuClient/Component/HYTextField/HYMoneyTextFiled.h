//
//  HYMoneyTextFiled.h
//  HaoYuClient
//
//  Created by 刘文强 on 2018/8/6.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYBaseTextFiled.h"

@interface HYMoneyTextFiled : HYBaseView<UITextFieldDelegate>

@property (nonatomic, strong) UITextField * textFiled;

+ (instancetype)creatMoneyTextFiledplaceHolder:(NSString *)placeHolder
                                          font:(UIFont *)font
                                     textColor:(UIColor *)textColor
                                      maxCount:(long)maxCount;

@end
