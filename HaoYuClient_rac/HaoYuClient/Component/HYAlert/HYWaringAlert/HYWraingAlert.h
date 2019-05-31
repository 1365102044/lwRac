//
//  HYWraingAlert.h
//  HaoYuClient
//
//  Created by 刘文强 on 2018/5/24.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYWraingAlert : UIAlertController
/**
 展示中部弹窗（规范-警告弹窗两个按钮）
 
 @param controller                  当前控制器
 @param title                       标题
 @param message                     内容信息
 @param defaultButtonTitle          默认的buttonTitle
 @param cancelButtonTitle           取消buttonTitle
 @param defaultButtonCallBackBlock  默认按钮回调
 @param cancelButtonCallBackBlock   取消按钮回调
 */
+ (void)            showAlert:(UIViewController *)controller
                        title:(NSString *)title
                      message:(NSString *)message
           defaultButtonTitle:(NSString *)defaultButtonTitle
            cancelButtonTitle:(NSString *)cancelButtonTitle
   defaultButtonCallBackBlock:(HYEventCallBackBlock)defaultButtonCallBackBlock
    cancelButtonCallBackBlock:(HYEventCallBackBlock)cancelButtonCallBackBlock;

/**
 展示中部弹窗（规范-警告弹窗一个按钮）
 
 @param controller                  当前控制器
 @param title                       标题
 @param message                     内容信息
 @param cancelButtonTitle           取消buttonTitle
 @param cancelButtonCallBackBlock   取消按钮回调
 */
+ (void)            showAlert:(UIViewController *)controller
                        title:(NSString *)title
                      message:(NSString *)message
            cancelButtonTitle:(NSString *)cancelButtonTitle
    cancelButtonCallBackBlock:(HYEventCallBackBlock)cancelButtonCallBackBlock;

@end
