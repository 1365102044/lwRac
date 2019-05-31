//
//  HYBaseLabelAttributeStringModel.h
//  HaoYuClient
//
//  Created by 刘文强 on 2018/5/22.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYBaseLabelAttributeStringModel : NSObject
/**
 文字颜色
 */
@property (nonatomic, strong) UIColor *color;

/**
 文字字体
 */
@property (nonatomic, strong) UIFont *size;

/**
 文字内容
 */
@property (nonatomic, copy) NSString *content;

/**
 行间距
 */
@property (nonatomic, strong) NSNumber *lineSpacing;

/**
 显示是否居中
 */
@property (nonatomic, copy) NSString *alignment;

@end
