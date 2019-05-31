//
//  UILabel+Extension.h
//  inborn
//
//  Created by 郑键 on 17/3/16.
//  Copyright © 2017年 inborn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Extension)

/**
 *  设置行距
 */
- (void)setRowSpace:(CGFloat)rowSpace;

/**
 *  设置行间距，单行时，不设置
 *  add by 郑键 2017年09月01日16:58:46 精简代码
 */
- (void)setMultipleRowSpace:(CGFloat)rowSpace;

- (void)setTextWithLinkAttribute:(NSString *)text;

/**
 添加删除线
 */
- (void)strikeLableWith:(NSString *)textStr;

@end
