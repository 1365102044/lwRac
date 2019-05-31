//
//  HYIdCardItemView.h
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/20.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYBaseImageView.h"

@interface HYIdCardItemView : HYBaseImageView
@property (nonatomic, copy) HYEventCallBackBlock callBackBlock;
@property (nonatomic, strong) HYDefaultLabel * descLabel;

+ (instancetype)creatIdCardImageView:(NSString *)desc callBackBlock:(HYEventCallBackBlock)callBackBlock;
/**
 选择图片后 赋值
 */
- (void)setPicImage:(UIImage *)image;

/**
 上传成功后隐藏 蒙版
 */
- (void)dismissMaskLayer;
/**
 显示蒙版 （上传中/上传失败）
 */
- (void)showMaskLayer;
/**
 上传失败  赋值
 */
- (void)setMaksLayerAlearMsg:(NSString *)msg;
@end
