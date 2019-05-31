//
//  HYAddImageItemView.h
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/4.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYBaseView.h"
#import "HYBaseImageView.h"
@interface HYAddImageItemView : HYBaseView
@property (nonatomic, strong) HYBaseImageView * itemImageView;
@property (nonatomic, strong) HYDefaultButton * masklayer;
@property (nonatomic, copy) HYEventCallBackBlock deleBlock;
- (void)showMasklayer;
- (void)dismissMasklayer;
- (void)uploadWithProgress:(CGFloat)progress;
- (void)setMaskerTitle:(NSString *)title;
@end
