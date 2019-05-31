//
//  HYProjectThemeImageFactory.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/5/18.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYProjectThemeImageFactory.h"

@implementation HYProjectThemeImageFactory
/**
 项目主题图片工厂方法
 
 @param image           图片
 @param type            图片样式
 @return                返回统一配置的图片
 */
//+ (UIImage *)projectThemeImageFatoryWithImage:(UIImage *)image
//                                    imageType:(HYProjectLoadImageType)type
//{
//    /** 做项目统一配置 */
//    
//    UIImage *confiImage;
//    
//    if (type == HYProjectViewStatusDefault) {
//        confiImage = image;
//    }
//    
//    if (type == HYProjectLoadImageFillet) {
//        confiImage = [self filletImage:image];
//    }
//    
//    return confiImage;
//}

/**
 绘制圆角图片
 
 @param image image
 @return 圆角图片
 */
+ (UIImage *)filletImage:(UIImage *)image
{
    return [image ex_drawCircleImage];
}

/**
 项目主题网络图片工厂方法
 
 @param URLString               图片URLString
 @param imageURLStringType      类型
 @return                        处理后统一的URL
 */
+ (NSString *)projectThemeImageFatoryWithImageURLString:(NSString *)URLString
                                     imageURLStringType:(HYProjectImageURLStringType)imageURLStringType
{
    NSString *confiImageURLString;
    
    confiImageURLString = URLString;
    return confiImageURLString;
    
    if (imageURLStringType == HYProjectLoadImageDefault) {
        confiImageURLString = URLString;
    }
    
    if (imageURLStringType == HYProjectImageURLStringWaterfallFlow) {
        if (![URLString containsString:@"?"]) {
            confiImageURLString = [NSString stringWithFormat:@"%@?x-oss-process=style/ah450", URLString];
        }else{
            confiImageURLString = URLString;
        }
    }
    
    if (imageURLStringType == HYProjectImageURLStringList) {
        if (![URLString containsString:@"?"]) {
            confiImageURLString = [NSString stringWithFormat:@"%@?x-oss-process=style/ss200",URLString];
        }else{
            confiImageURLString = URLString;
        }
    }
    
    if (imageURLStringType == HYProjectImageURLStringListMid) {
        if (![URLString containsString:@"?"]) {
            confiImageURLString = [NSString stringWithFormat:@"%@?x-oss-process=style/ss450",URLString];
        }else{
            confiImageURLString = URLString;
        }
    }
    
    if (imageURLStringType == HYProjectImageURLStringMid) {
        if (![URLString containsString:@"?"]) {
            confiImageURLString = [NSString stringWithFormat:@"%@?x-oss-process=style/ah450", URLString];
        }else{
            confiImageURLString = URLString;
        }
    }
    
    if (imageURLStringType == HYProjectImageURLStringLarge) {
        confiImageURLString = URLString;
    }
    
    if (imageURLStringType == HYProjectImageUrlStringHeaderIcon) {
        if (![URLString containsString:@"?"]) {
            confiImageURLString = [NSString stringWithFormat:@"%@?x-oss-process=style/ss200",URLString];
        }else{
            confiImageURLString = URLString;
        }
    }
    
    if (imageURLStringType == HYProjectImageUrlStringBankLogo) {
        if (![URLString containsString:@"?"]) {
            confiImageURLString = [NSString stringWithFormat:@"%@?x-oss-process=style/ss44",URLString];
        }else{
            confiImageURLString = URLString;
        }
    }
    
    return confiImageURLString;
}

@end
