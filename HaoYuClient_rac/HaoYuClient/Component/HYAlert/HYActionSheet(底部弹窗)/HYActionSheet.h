//
//  HYActionSheet.h
//  HaoYuClient
//
//  Created by 刘文强 on 2018/5/25.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYActionSheet : UIAlertController
/**
 底部选择弹窗（规范-选择弹窗带标题）
 
 @param controller          当前控制器
 @param title               标题
 @param callBack            回调（根据index来判断）
 @param buttonTitle         选项
 */
+ (void)showAlert:(UIViewController *)controller
            title:(NSString *)title
         callBack:(HYEventCallBackBlock)callBack
      buttonTitle:(NSString *)buttonTitle, ... NS_REQUIRES_NIL_TERMINATION;

/**
 底部选择弹窗（规范-底部取消）
 
 @param controller          当前控制器
 @param destructiveTitle    最上面警告作用按钮
 @param callBack            回调（根据index来判断）
 @param buttonTitle         选项
 */
+ (void)showAlert:(UIViewController *)controller
 destructiveTitle:(NSString *)destructiveTitle
         callBack:(HYEventCallBackBlock)callBack
      buttonTitle:(NSString *)buttonTitle, ... NS_REQUIRES_NIL_TERMINATION;

/**
 底部选择弹窗（无规范-底部取消）
 
 @param controller          当前控制器
 @param callBack            回调（根据index来判断）
 @param buttonTitle         选项
 */
+ (void)showAlert:(UIViewController *)controller
         callBack:(HYEventCallBackBlock)callBack
      buttonTitle:(NSString *)buttonTitle, ... NS_REQUIRES_NIL_TERMINATION;

/**
 底部选择弹窗（无规范-底部取消）
 
 @param controller          当前控制器
 @param title               标题
 @param callBack            回调（根据index来判断）
 @param buttonArray         选项
 */
+ (void)showBottomCancelAlert:(UIViewController *)controller
                        title:(NSString *)title
                     callBack:(HYEventCallBackBlock)callBack
                  buttonArray:(NSArray *)buttonArray;

///**
// 带标题，有取消-------------
// */
//+ (void)showAlert:(UIViewController *)controller
//            title:(NSString *)title
//        buttonArr:(NSArray *)buttonArr
//         callBack:(HYEventCallBackBlock)callBack;
//
///**
// 没有标题 有取消-------------
// */
//+ (void)showAlert:(UIViewController *)controller
//        buttonArr:(NSArray *)buttonArr
//         callBack:(HYEventCallBackBlock)callBack;

+ (void)showDefaultAlert:(UIViewController *)controller
                titleKey:(NSString *)titleKey
               buttonArr:(NSArray *)buttonArr
                callBack:(HYEventCallBackBlock)callBack;
@end
