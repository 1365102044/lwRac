//
//  HYProjectThemeManager.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/5/18.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYProjectThemeManager.h"

@implementation HYProjectThemeManager

- (HYProjectThemeColorFactory *)themeColorFatory
{
    if (!_themeColorFatory) {
        NSString *colorFilePath = [NSString stringWithFormat:@"%@/%@/%@",
                                   [NSBundle ex_colorBundlePath],
                                   PROJECT_THEME_DEFAULT,
                                   @"Color.json"];
        _themeColorFatory = [HYProjectThemeColorFactory projectThemeColorFatoryWithFilePath:colorFilePath];
    }
    return _themeColorFatory;
}

#pragma mark - 初始化

/**
 获取单利
 
 @return 对象
 */
+ (instancetype)sharedManager
{
    static dispatch_once_t onceToken;
    static HYProjectThemeManager *instance;
    dispatch_once(&onceToken, ^{
        instance = [[HYProjectThemeManager alloc] init];
    });
    return instance;
}

#pragma maark - 配置图片

///**
// 加载图片
//
// @param fileName        bundle内 模块图片文件夹名称, 如有多层文件夹嵌套写多层文件夹
// @param imageNamed      图片名
// @param type            图片样式（具体参见HYProjectLoadImageType注释）
//
// @return                返回图片数组，firstObject普通图片/lastObject高亮图片/array[1]禁用图片
// */
//- (NSArray *)loadImageWithFileName:(NSString *)fileName
//                        imageNamed:(NSString *)imageNamed
//                         imageType:(HYProjectLoadImageType)type
//{
//    NSString *filePathNor;
//    NSString *filePathHig;
//    NSString *filePathDis;
//    if (fileName) {
//        filePathNor = [NSString stringWithFormat:@"%@/%@/%@/%@_%@",
//                       [NSBundle ex_imageBundlePath],
//                       PROJECT_THEME_DEFAULT,
//                       fileName,
//                       imageNamed,
//                       PROJECT_THEME_IMAGE_NOR];
//
//        filePathHig = [NSString stringWithFormat:@"%@/%@/%@/%@_%@",
//                       [NSBundle ex_imageBundlePath],
//                       PROJECT_THEME_DEFAULT,
//                       fileName,
//                       imageNamed,
//                       PROJECT_THEME_IMAGE_HIG];
//        filePathDis = [NSString stringWithFormat:@"%@/%@/%@/%@_%@",
//                       [NSBundle ex_imageBundlePath],
//                       PROJECT_THEME_DEFAULT,
//                       fileName,
//                       imageNamed,
//                       PROJECT_THEME_IMAGE_DIS];
//    }else{
//        filePathNor = [NSString stringWithFormat:@"%@/%@/%@_%@",
//                       [NSBundle ex_imageBundlePath],
//                       PROJECT_THEME_DEFAULT,
//                       imageNamed,
//                       PROJECT_THEME_IMAGE_NOR];
//        filePathHig = [NSString stringWithFormat:@"%@/%@/%@_%@",
//                       [NSBundle ex_imageBundlePath],
//                       PROJECT_THEME_DEFAULT,
//                       imageNamed,
//                       PROJECT_THEME_IMAGE_HIG];
//        filePathDis = [NSString stringWithFormat:@"%@/%@/%@_%@",
//                       [NSBundle ex_imageBundlePath],
//                       PROJECT_THEME_DEFAULT,
//                       imageNamed,
//                       PROJECT_THEME_IMAGE_DIS];
//    }
//
//    UIImage *norImage = [HYProjectThemeImageFatory projectThemeImageFatoryWithImage:[UIImage imageNamed:filePathNor]
//                                                                          imageType:type];
//
//    UIImage *disImage = [HYProjectThemeImageFatory projectThemeImageFatoryWithImage:[UIImage imageNamed:filePathDis]
//                                                                          imageType:type];
//
//    UIImage *higImage = [HYProjectThemeImageFatory projectThemeImageFatoryWithImage:[UIImage imageNamed:filePathHig]
//                                                                          imageType:type];
//
//    return @[norImage ? norImage : [UIImage new],
//             disImage ? disImage : [UIImage new],
//             higImage ? higImage : [UIImage new]];
//}
//
///**
// 加载单张图片
//
// @param fileName        bundle内 模块图片文件夹名称, 如有多层文件夹嵌套写多层文件夹
// @param imageNamed      图片名
// @param type            图片样式（具体参见HYProjectLoadImageType注释）
//
// @return                返回图片数组，firstObject普通图片/lastObject高亮图片
// */
//- (UIImage *)loadCurrentImageWithFileName:(NSString *)fileName
//                               imageNamed:(NSString *)imageNamed
//                                imageType:(HYProjectLoadImageType)type
//{
//    NSString *filePathNor;
//    if (fileName) {
//        filePathNor = [NSString stringWithFormat:@"%@/%@/%@/%@",
//                       [NSBundle ex_imageBundlePath],
//                       PROJECT_THEME_DEFAULT,
//                       fileName,
//                       imageNamed];
//    }else{
//        filePathNor = [NSString stringWithFormat:@"%@/%@/%@",
//                       [NSBundle ex_imageBundlePath],
//                       PROJECT_THEME_DEFAULT,
//                       imageNamed];
//    }
//
//
//
//    return [HYProjectThemeImageFatory projectThemeImageFatoryWithImage:
//            [UIImage imageWithContentsOfFile: filePathNor]
//                                                             imageType:type];
//
//}

/**
 加载网络图片URL处理
 
 @param imageURLStringType  HYProjectImageURLStringType
 @param URLString           图片的URLString
 @return                    处理好的URL
 */
- (NSString *)resetImageURLStringWithImageType:(HYProjectImageURLStringType)imageURLStringType
                                     URLString:(NSString *)URLString
{
    return [HYProjectThemeImageFactory projectThemeImageFatoryWithImageURLString:URLString
                                                             imageURLStringType:imageURLStringType];
}
@end
