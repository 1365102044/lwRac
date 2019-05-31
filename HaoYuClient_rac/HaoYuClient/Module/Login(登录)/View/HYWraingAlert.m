//
//  HYWraingAlert.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/5/24.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYWraingAlert.h"
#import "JXTAlertManagerHeader.h"
#import "HYAlertCenterView.h"
@interface HYWraingAlert ()

@end

@implementation HYWraingAlert

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
+ (void)                showAlert:(UIViewController *)controller
                            title:(NSString *)title
                          message:(NSString *)message
               defaultButtonTitle:(NSString *)defaultButtonTitle
                cancelButtonTitle:(NSString *)cancelButtonTitle
       defaultButtonCallBackBlock:(HYEventCallBackBlock)defaultButtonCallBackBlock
        cancelButtonCallBackBlock:(HYEventCallBackBlock)cancelButtonCallBackBlock
{
    [controller jxt_showAlertWithTitle:title
                               message:message
                     appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
                         
                         /**
                          *  改变title的大小和颜色
                          */
                         NSMutableAttributedString *titleAtt = [[NSMutableAttributedString alloc] initWithString:title];
                         [titleAtt addAttribute:NSFontAttributeName value:SYSTEM_MEDIUMFONT(17.f) range:NSMakeRange(0, title.length)];
                         [titleAtt addAttribute:NSForegroundColorAttributeName value:HYCOLOR.color_c4 range:NSMakeRange(0, title.length)];
                         [alertMaker setValue:titleAtt forKey:@"attributedTitle"];
                         
                         /**
                          *  改变message的大小和颜色
                          */
                         NSMutableAttributedString *messageAtt = [[NSMutableAttributedString alloc] initWithString:message];
                         [messageAtt addAttribute:NSFontAttributeName value:SYSTEM_REGULARFONT(14.f) range:NSMakeRange(0, message.length)];
                         [messageAtt addAttribute:NSForegroundColorAttributeName value:HYCOLOR.color_c4 range:NSMakeRange(0, message.length)];
                         [alertMaker setValue:messageAtt forKey:@"attributedMessage"];
                         
                         alertMaker.
                         addActionDefaultTitle(cancelButtonTitle).
                         addActionCancelTitle(defaultButtonTitle);
                         
                         alertMaker.view.tintColor = HYCOLOR.color_c26;
                         
                     } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, JXTAlertController * _Nonnull alertSelf) {
                         
                         if (buttonIndex == 0) {
                             cancelButtonCallBackBlock(nil);
                         }
                         
                         if (buttonIndex == 1) {
                             defaultButtonCallBackBlock(nil);
                         }
                         
                     }];
}

/**
 展示中部弹窗（规范-警告弹窗一个按钮）
 
 @param controller                  当前控制器
 @param title                       标题
 @param message                     内容信息
 @param cancelButtonTitle           取消buttonTitle
 @param cancelButtonCallBackBlock   取消按钮回调
 */
+ (void)showAlert:(UIViewController *)controller
            title:(NSString *)title
          message:(NSString *)message
cancelButtonTitle:(NSString *)cancelButtonTitle
cancelButtonCallBackBlock:(HYEventCallBackBlock)cancelButtonCallBackBlock
{
    [controller jxt_showAlertWithTitle:title
                               message:message
                     appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
                         
                         /**
                          *  改变title的大小和颜色
                          */
                         NSMutableAttributedString *titleAtt = [[NSMutableAttributedString alloc] initWithString:title];
                         [titleAtt addAttribute:NSFontAttributeName value:SYSTEM_MEDIUMFONT(17.f) range:NSMakeRange(0, title.length)];
                         [titleAtt addAttribute:NSForegroundColorAttributeName value:HYCOLOR.color_c4 range:NSMakeRange(0, title.length)];
                         [alertMaker setValue:titleAtt forKey:@"attributedTitle"];
                         
                         /**
                          *  改变message的大小和颜色
                          */
                         NSMutableAttributedString *messageAtt = [[NSMutableAttributedString alloc] initWithString:message];
                         [messageAtt addAttribute:NSFontAttributeName value:SYSTEM_REGULARFONT(14.f) range:NSMakeRange(0, message.length)];
                         [messageAtt addAttribute:NSForegroundColorAttributeName value:HYCOLOR.color_c4 range:NSMakeRange(0, message.length)];
                         [alertMaker setValue:messageAtt forKey:@"attributedMessage"];
                         
                         alertMaker.
                         addActionCancelTitle(cancelButtonTitle);
                         
                         alertMaker.view.tintColor = HYCOLOR.color_c26;
                         
                     } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, JXTAlertController * _Nonnull alertSelf) {
                         
                         cancelButtonCallBackBlock(nil);
                     }];
    
}


/**
 展示中部弹窗（规范-警告弹窗两个按钮）
 TextAlignment                      文字的方向
 @param controller                  当前控制器
 @param title                       标题
 @param message                     内容信息
 @param defaultButtonTitle          默认的buttonTitle
 @param cancelButtonTitle           取消buttonTitle
 @param leftButtonCallBackBlock     默认按钮回调
 @param rightButtonCallBackBlock   取消按钮回调
 */
+ (void)                showAlert:(UIViewController *)controller
                            title:(NSString *)title
                          message:(NSString *)message
                  leftButtonTitle:(NSString *)leftButtonTitle
                 rightButtonTitle:(NSString *)rightButtonTitle
                    TextAlignment:(NSTextAlignment)TextAlignment
          leftButtonCallBackBlock:(HYEventCallBackBlock)leftButtonCallBackBlock
         rightButtonCallBackBlock:(HYEventCallBackBlock)rightButtonCallBackBlock
{
    HYAlertCenterView *alertView = [[HYAlertCenterView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:alertView];
    
    alertView.titleLable.text = title;
    [alertView.messageLable setAttributedStringWithContentArray:@[@{@"color" : HYCOLOR.color_c4,
                                                                    @"content" : message,
                                                                    @"size" : SYSTEM_REGULARFONT(12),
                                                                    @"lineSpacing": @(5)},]];
    alertView.messageLable.textAlignment = TextAlignment;
    alertView.leftBtn_Lable.text = leftButtonTitle;
    alertView.rightBtn_Lable.text = rightButtonTitle;
    
    [alertView.backView bk_whenTapped:^{
        [alertView removeAllSubviews];
        [alertView removeFromSuperview];
    }];
    [alertView.leftBtn_Lable bk_whenTapped:^{
        [alertView removeAllSubviews];
        [alertView removeFromSuperview];
        leftButtonCallBackBlock(leftButtonTitle);
    }];
    [alertView.rightBtn_Lable bk_whenTapped:^{
        [alertView removeAllSubviews];
        [alertView removeFromSuperview];
        rightButtonCallBackBlock(rightButtonTitle);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

@end
