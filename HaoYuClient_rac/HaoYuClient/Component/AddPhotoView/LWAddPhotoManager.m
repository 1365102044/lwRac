
//
//  LWAddPhotoManager.m
//  HaoYuClient
//
//  Created by 刘文强 on 2019/5/21.
//  Copyright © 2019年 LWQ. All rights reserved.
//

#import "LWAddPhotoManager.h"
#import "LWImagePicker.h"
@interface LWAddPhotoManager ()
@property (nonatomic, strong) HYAddPhotoView * addPhotoView;

@end
@implementation LWAddPhotoManager

- (void)setAddPicManager:(HYAddPhotoView *)addPhotoView
{
    _addPhotoView = addPhotoView;
    _addPhotoView.delegate = self;
}

/**
 选择图片
 */
- (void)gotoChooseImages
{
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    WEAKSELF(self);
    [[LWImagePicker share] imagePickerWithSourceVc:self.addPhotoView.currentViewController ? :self.curVC allowsEditing:NO callBlock:^(id sender) {
        [weakself.addPhotoView chooseImages:@[(UIImage *)sender]];
        [self uploadImage:(UIImage *)sender];
    }];
}

//删除图片
- (void)deleImage:(UIImage *)image
{
    NSArray *allkey = self.selImageUrlDict.allKeys;
    if ([allkey containsObject:image]) {
        [self.selImageUrlDict removeObjectForKey:image];
    }
}

//重新上传
- (void)reUploadImage:(UIImage *)image
{
    if(!image) return;
    [self uploadImage:image];
}
/**
 上传图片
 */
- (void)uploadImage:(UIImage *)image
{
    [[HYServiceManager share] uploadSingleImageWithurl:UPLOAD_MINEWEIXIU_IMAGE_URL
                                                 Image:image
                                              fileName:nil
                                            parameters:nil
                                         progressBlock:^(id sender) {
                                             
                                             LWLog(@"--------------上传进度：%f",[sender floatValue]);
                                             NSMutableDictionary *tem = [[NSMutableDictionary alloc]init];
                                             tem[@"progress"] = sender;
                                             tem[@"image"] = image;
                                             POST_NOTI(@"uploadresult_baoxiu_progress", tem);
                                             
                                         }Success:^(id objc, id requestInfo) {
                                             NSString *imgeurl = objc[@"url"];
                                             NSLog(@"----------------image:%@------------imageurl:%@",image,imgeurl);
                                             if (imgeurl) {
                                                 [self.selImageUrlDict setObject:imgeurl forKey:(id)image];
                                             }
                                             NSLog(@"----------------self.selImageUrlDict:%@",self.selImageUrlDict);
                                             NSMutableDictionary *tem = [[NSMutableDictionary alloc]init];
                                             tem[@"result"] = @"1";
                                             tem[@"image"] = image;
                                             POST_NOTI(@"uploadresult_baoxiu", tem);
                                         } fail:^(id error, id requestInfo) {
                                             NSMutableDictionary *tem = [[NSMutableDictionary alloc]init];
                                             tem[@"result"] = @"0";
                                             tem[@"image"] = image;
                                             POST_NOTI(@"uploadresult_baoxiu", tem);
                                         }];
}

-(NSArray *)selectImages
{
    if (self.addPhotoView.ImagesDataArr.count != self.selImageUrlDict.allKeys.count) {
        ALERT(@"图片上传中或失败，请等待完成后重试~");
        return nil;
    }
    return self.selImageUrlDict.allValues;
}
- (NSMutableDictionary*)selImageUrlDict
{
    if (!_selImageUrlDict) {
        _selImageUrlDict = [[NSMutableDictionary alloc] init];
    }
    return _selImageUrlDict;
}

@end
