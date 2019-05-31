//
//  HYPhotoBrowserViewController.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/12.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYPhotoBrowserViewController.h"

@interface HYPhotoBrowserViewController ()<PBViewControllerDataSource, PBViewControllerDelegate>

@property (nonatomic, strong) NSArray *goodImageViewArray;

@end

@implementation HYPhotoBrowserViewController
#pragma mark - Fifth.控制器生命周期

/**
 获取图片预览控制器
 
 @return 图片预览控制器
 */
+ (instancetype)photoBrowserViewControllerImageUrlStingArray:(NSArray<NSString *> *)imageUrlStingArray
{
    HYPhotoBrowserViewController *pbViewController  = [HYPhotoBrowserViewController new];
    pbViewController.pb_dataSource                  = pbViewController;
    pbViewController.pb_delegate                    = pbViewController;
    //    NSAssert(imageUrlStingArray, @"图片URLString数组不能为空");
    pbViewController.imageUrlStringArray            = imageUrlStingArray;
    return pbViewController;
}

/**
 获取图片预览控制器
 
 @return 图片预览控制器
 */
+ (instancetype)photoBrowserViewControllerImageUrlStingArray:(NSArray<NSString *> *)imageUrlStingArray imageViewArray:(NSArray *)imageViewArray startIndex:(NSInteger)startIndex
{
    HYPhotoBrowserViewController *pbViewController  = [HYPhotoBrowserViewController new];
    pbViewController.pb_dataSource                  = pbViewController;
    pbViewController.pb_delegate                    = pbViewController;
    //    NSAssert(imageUrlStingArray, @"图片URLString数组不能为空");
    pbViewController.imageUrlStringArray            = imageUrlStingArray;
    pbViewController.startPage                      = startIndex;
    pbViewController.goodImageViewArray             = imageViewArray;
    return pbViewController;
}
- (UIView *)thumbViewForPageAtIndex:(NSInteger)index
{
    return _goodImageViewArray[index];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (void)setImageUrlStringArray:(NSArray *)imageUrlStringArray
{
    _imageUrlStringArray = imageUrlStringArray;
}

#pragma mark <PBViewControllerDataSource>

- (NSInteger)numberOfPagesInViewController:(PBViewController *)viewController
{
    return self.imageUrlStringArray.count ? self.imageUrlStringArray.count : 1 ;
}

- (void)viewController:(PBViewController *)viewController presentImageView:(UIImageView *)imageView forPageAtIndex:(NSInteger)index progressHandler:(void (^)(NSInteger, NSInteger))progressHandler
{
    if (!self.imageUrlStringArray.count) {
        return;
    }
    
    NSString *imageUrl = [self.imageUrlStringArray[index] isKindOfClass:[NSString class]] ? self.imageUrlStringArray[index] : self.imageUrlStringArray[index][@"imgUrl"];
    [imageView sd_setImageWithURL:[NSURL URLWithString: HYIMAGEURLSTRING(HYProjectImageURLStringDefault,
                                                                         imageUrl)]
                 placeholderImage:nil
                          options:SDWebImageRetryFailed];
    
}

#pragma mark <PBViewControllerDelegate>

- (void)viewController:(PBViewController *)viewController didSingleTapedPageAtIndex:(NSInteger)index presentedImage:(UIImage *)presentedImage {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
