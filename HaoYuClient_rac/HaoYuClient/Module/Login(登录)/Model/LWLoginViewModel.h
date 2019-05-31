//
//  LWLoginViewModel.h
//  HaoYuClient
//
//  Created by 刘文强 on 2019/5/31.
//  Copyright © 2019年 LWQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LWAccountModel.h"
#import "LWLoginMainView.h"
#import <ReactiveObjC.h>

NS_ASSUME_NONNULL_BEGIN

@interface LWLoginViewModel : NSObject
/** 1.注册 2 忘记密码 3.登录*/
@property (nonatomic, assign) NSInteger viewType;
@property (nonatomic, assign) NSInteger loginType;

@property (nonatomic, strong) LWAccountModel * accountModel;

@property (nonatomic, strong) LWLoginMainView * mainView;

@property (nonatomic, strong) RACSubject * delegateSubject;


+ (instancetype)createLoginViewModelWithMainView:(UIView *)mainView;
@end

NS_ASSUME_NONNULL_END
