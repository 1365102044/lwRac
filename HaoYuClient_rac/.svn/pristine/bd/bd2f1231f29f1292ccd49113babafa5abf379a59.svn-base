//
//  HYPhotoBrowserViewController.h
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/12.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "PBViewController.h"

@interface HYPhotoBrowserViewController : PBViewController
/**
 图片URLString数组
 */
@property (nonatomic, strong) NSArray *imageUrlStringArray;

/**
 指定滚动到的位置
 */
@property (nonatomic, assign) NSInteger startPage;

/**
 获取图片预览控制器
 
 @return 图片预览控制器
 */
+ (instancetype)photoBrowserViewControllerImageUrlStingArray:(NSArray<NSString *> *)imageUrlStingArray;

/**
 获取图片预览控制器
 
 @return 图片预览控制器
 */
+ (instancetype)photoBrowserViewControllerImageUrlStingArray:(NSArray<NSString *> *)imageUrlStingArray
                                              imageViewArray:(NSArray *)imageViewArray
                                                  startIndex:(NSInteger)startIndex;
@end
