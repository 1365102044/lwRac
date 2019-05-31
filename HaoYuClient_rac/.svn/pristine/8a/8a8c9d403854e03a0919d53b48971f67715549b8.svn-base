//
//  UITextField+Extension.m
//  Project
//
//  Created by 郑键 on 17/1/11.
//  Copyright © 2017年 zhengjian. All rights reserved.
//

#import "UITextField+Extension.h"
#import "HYStringTool.h"

@implementation UITextField (Extension)

- (NSRange)ex_selectedRange
{
    UITextPosition *beginning       = self.beginningOfDocument;
    UITextRange *selectedRange      = self.selectedTextRange;
    UITextPosition *selectionStart  = selectedRange.start;
    UITextPosition *selectionEnd    = selectedRange.end;
    const NSInteger location        = [self offsetFromPosition:beginning toPosition:selectionStart];
    const NSInteger length          = [self offsetFromPosition:selectionStart toPosition:selectionEnd];
    return NSMakeRange(location, length);
}

- (void)ex_setSelectedRange:(NSRange)range
{
    UITextPosition *beginning           = self.beginningOfDocument;
    UITextPosition *startPosition       = [self positionFromPosition:beginning offset:range.location];
    UITextPosition *endPosition         = [self positionFromPosition:beginning offset:range.location + range.length];
    UITextRange *selectionRange         = [self textRangeFromPosition:startPosition toPosition:endPosition];
    [self setSelectedTextRange:selectionRange];
}

/**
 *  切换明文密文展示方式
 *
 *  @param secureTextEnter 是否为密文
 */
- (void)ex_changeSecureTextEntry:(BOOL)secureTextEnter
{
    self.secureTextEntry            = secureTextEnter;
    NSString* text                  = self.text;
    UIKeyboardType keyboardType     = self.keyboardType;
    self.text                       = @" ";
    self.keyboardType               = UIKeyboardTypeDefault;
    self.text                       = text;
    self.keyboardType               = keyboardType;
}

/**
 *  金额输入框开始输入
 */
- (void)ex_amontTextBeginEdit
{
    NSString *amontString = self.text;
    if ([amontString containsString:@"¥"]) {
        amontString = [amontString stringByReplacingOccurrencesOfString:@"¥" withString:@""];
    }
    
    if ([amontString containsString:@","]) {
        amontString = [amontString stringByReplacingOccurrencesOfString:@"," withString:@""];
    }
    
    if ([amontString containsString:@"."]
        && [[amontString componentsSeparatedByString:@"."].lastObject isEqualToString:@"00"]) {
        amontString = [amontString componentsSeparatedByString:@"."].firstObject;
    }
    
    self.text = amontString;
}

/**
 *  金额输入框结束输入
 */
- (void)ex_amontTextEndEdit
{
    NSString *amontString = [self ex_amontText];
    self.text = [NSString stringWithFormat:@"¥%@",
                 [[HYStringTool share] strmethodCommaWith:[NSString stringWithFormat:@"%.2f",
                                                           amontString.doubleValue * 100]]];
}

/**
 *  金额输入框结束输入带人民币标志
 */
- (void)ex_amontTextEndEditNOFlag
{
    NSString *amontString = [self ex_amontText];
    self.text = [NSString stringWithFormat:@"%@",
                 [[HYStringTool share] strmethodCommaWith:[NSString stringWithFormat:@"%.2f",
                                                           amontString.doubleValue * 100]]];
}

/**
 *  金额输入框获取金额
 */
- (NSString *)ex_amontText
{
    NSString *amontString = self.text;
    if ([amontString containsString:@"¥"]) {
        amontString = [amontString stringByReplacingOccurrencesOfString:@"¥" withString:@""];
    }
    
    if ([amontString containsString:@","]) {
        amontString = [amontString stringByReplacingOccurrencesOfString:@"," withString:@""];
    }
    
    return amontString;
}

/**
 输入的位数限制
 */
-(void)limitTextFiledEditLimitNumber:(NSInteger)Number
{
    // 需要限制的长度
    NSUInteger maxLength = 0;
    maxLength = Number;
    if (maxLength == 0) return;
    
    // text field 的内容
    NSString *contentText = self.text;
    // 获取高亮内容的范围
    UITextRange *selectedRange = [self markedTextRange];
    // 这行代码 可以认为是 获取高亮内容的长度
    NSInteger markedTextLength = [self offsetFromPosition:selectedRange.start toPosition:selectedRange.end];
    // 没有高亮内容时,对已输入的文字进行操作
    if (markedTextLength == 0) {
        // 如果 text field 的内容长度大于我们限制的内容长度
        if (contentText.length > maxLength) {
            // 截取从前面开始maxLength长度的字符串
            //            textField.text = [contentText substringToIndex:maxLength];
            // 此方法用于在字符串的一个range范围内，返回此range范围内完整的字符串的range
            NSRange rangeRange = [contentText rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, maxLength)];
            self.text = [contentText substringWithRange:rangeRange];
        }
    }
}

@end
