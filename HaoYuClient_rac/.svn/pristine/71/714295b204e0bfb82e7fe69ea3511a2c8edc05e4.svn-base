//
//  LWImagePicker.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/8/10.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "LWImagePicker.h"
#import <AVFoundation/AVFoundation.h>
#import "UIImage+Extension.h"
#import "HYBaseBarButtonItem.h"

#import "ZLPhotoActionSheet.h"

@interface LWImagePicker ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>
//@property (nonatomic, strong) UIImagePickerController * picker;
@property (nonatomic, strong) UIViewController * sourceVC;
@property (nonatomic, copy) HYEventCallBackBlock  callBlock;
@property (nonatomic, assign) BOOL allowsEditing;

@end

@implementation LWImagePicker

+ (instancetype)share
{
    static LWImagePicker *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[LWImagePicker alloc ]init];
    });
    return instance;
}

/**
 sourceVc                   来源控制器
 allowsEditing               是否编辑
 callBlock                   返回图片
 */
- (void)imagePickerWithSourceVc:(UIViewController *)sourceVc allowsEditing:(BOOL)allowsEditing callBlock:(HYEventCallBackBlock)callBlock
{
//    self.picker  = [[UIImagePickerController alloc] init];
//    self.picker.navigationBar.tintColor  = [UIColor redColor];
//    self.picker.allowsEditing = allowsEditing;
//    self.picker.delegate = self;
//    self.sourceVC = sourceVc;
//    [self showAlerView];
    self.callBlock  = callBlock;
    
    ZLPhotoActionSheet *ac = [[ZLPhotoActionSheet alloc] init];
    //相册参数配置，configuration有默认值，可直接使用并对其属性进行修改
    ac.configuration.maxSelectCount = 1;
    ac.configuration.maxPreviewCount = 0;
    ac.configuration.statusBarStyle = UIStatusBarStyleLightContent;
    ac.configuration.allowSelectGif = NO;
    ac.configuration.allowSelectVideo = NO;
    //如调用的方法无sender参数，则该参数必传
    ac.sender = sourceVc;
    //选择回调
    [ac setSelectImageBlock:^(NSArray<UIImage *> * _Nonnull images, NSArray<PHAsset *> * _Nonnull assets, BOOL isOriginal) {
        //your codes
        if (self.callBlock) {
            self.callBlock(images.firstObject);
        }
    }];
    //调用相册
    [ac showPreviewAnimated:NO];
}

#pragma mark --------- 代理  ---------

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *image;
    NSArray *array = @[@"UIImagePickerControllerMediaType",
                       @"UIImagePickerControllerOriginalImage",
                       @"UIImagePickerControllerEditedImage",
                       @"UIImagePickerControllerCropRect",
                       @"UIImagePickerControllerMediaURL",
                       @"UIImagePickerControllerReferenceURL",
                       @"UIImagePickerControllerMediaMetadata",
                       @"UIImagePickerControllerLivePhoto"];
    
    if (self.allowsEditing) {
        image = [info objectForKey:array[2]];
    }else {
        image = [info objectForKey:array[1]];
    }
    if (self.callBlock) {
        self.callBlock([image ex_fixOrientation]);
    }
    [self.sourceVC dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self.sourceVC dismissViewControllerAnimated:YES completion:nil];
}

- (void)showAlerView
{
    UIAlertController *temp = [UIAlertController alertControllerWithTitle:@"" message:@"请选择打开方式" preferredStyle:(UIAlertControllerStyleActionSheet)];
    UIAlertAction *sure = [UIAlertAction actionWithTitle:@"拍照" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        [self clickedButtonAtIndex:1];
    }];
    UIAlertAction *sure0 = [UIAlertAction actionWithTitle:@"从相册选择" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        [self clickedButtonAtIndex:2];
    }];
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
    }];
    [temp addAction:sure];
    [temp addAction:sure0];
    [temp addAction:cancle];
    [self.sourceVC presentViewController:temp animated:YES completion:nil];
}

- (void)clickedButtonAtIndex:(NSInteger)buttonIndex {
    
  
    
    if (buttonIndex == 1) {
        
        UIImagePickerController * picker = [[UIImagePickerController alloc] init];
        picker.navigationBar.tintColor = [UIColor redColor];
        picker.allowsEditing = _allowsEditing;
        picker.delegate = self;
        
        //    iOS 判断应用是否有使用相机的权限
        NSString *mediaType = AVMediaTypeVideo;//读取媒体类型
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];//读取设备授权状态
        if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
            NSString *errorStr = @"应用相机权限受限,请在设置中启用";
            [HYWraingAlert showAlert:self.sourceVC title:@"提示" message:errorStr defaultButtonTitle:@"取消" cancelButtonTitle:@"去设置" defaultButtonCallBackBlock:^(id sender) {
            } cancelButtonCallBackBlock:^(id sender) {
                //跳转到设置界面
                NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                if ([[UIApplication sharedApplication] canOpenURL:url]) {
                    [[UIApplication sharedApplication] openURL:url];
                }
            }];
            return;
        }
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self.sourceVC presentViewController:picker animated:YES completion:nil];
    }else if (buttonIndex == 2) {
        
        UIImagePickerController * picker = [[UIImagePickerController alloc] init];
        picker.navigationBar.tintColor = [UIColor redColor];
        picker.allowsEditing = _allowsEditing;
        picker.delegate = self;
        
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self.sourceVC presentViewController:picker animated:YES completion:^{
            
        }];
    }
}

@end
