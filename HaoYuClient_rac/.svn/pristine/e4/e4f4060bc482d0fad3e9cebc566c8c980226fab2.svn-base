//
//  HYCellContentBaseView.h
//  HaoYuClient
//
//  Created by 刘文强 on 2018/5/25.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYBaseView.h"
#import "HYDefaultTextField.h"
/**
 ---------------------------------高度 外界控制 --------------------------------------
 */

typedef enum : NSUInteger {
    rightLableType,
    rightTextFieldType,
    rightIconType,
}rightViewType ;

@interface HYCellContentBaseView : HYBaseView

@property (nonatomic, strong) HYDefaultLabel * leftLable;
@property (nonatomic, strong) HYDefaultLabel * rightLable;
@property (nonatomic, strong) HYDefaultTextField * rightTextField;
@property (nonatomic, strong) UIImageView * rightImageView;
@property (nonatomic, strong) UIImageView * arrowImageview;
@property (nonatomic, strong) UIView * bottomLine;
/**
 点击回调
 */
@property (nonatomic, copy) HYEventCallBackBlock  CallBackBlock;
@property (nonatomic, assign) rightViewType  ViewType;
//隐藏尖头
@property (nonatomic, assign) BOOL isHiddenR_icon;

@end
