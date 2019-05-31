//
//  UITextField+Extension.h
//  Project
//
//  Created by 郑键 on 17/1/11.
//  Copyright © 2017年 zhengjian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (Extension)

- (NSRange)ex_selectedRange;
- (void)ex_setSelectedRange:(NSRange)range;

/**
 *  切换明文密文展示方式
 *
 *  @param secureTextEnter 是否为密文
 */
- (void)ex_changeSecureTextEntry:(BOOL)secureTextEnter;

/**
 *  金额输入框开始输入
 */
- (void)ex_amontTextBeginEdit;

/**
 *  金额输入框结束输入
 */
- (void)ex_amontTextEndEdit;

/**
 *  金额输入框结束输入带人民币标志
 */
- (void)ex_amontTextEndEditNOFlag;

/**
 *  金额输入框获取金额 返回元为单位的金额
 */
- (NSString *)ex_amontText;

/**
 *  输入的位数限制
 */
- (void)limitTextFiledEditLimitNumber:(NSInteger)Number;

@end
