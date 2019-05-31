//
//  LWLoginMainView.h
//  HaoYuClient
//
//  Created by 刘文强 on 2019/3/13.
//  Copyright © 2019年 LWQ. All rights reserved.
//

#import "HYBaseView.h"
#import "HYDefaultTextField.h"

@interface LWLoginMainView : HYBaseView
@property (nonatomic, strong) HYDefaultButton * lastbtn;
@property (nonatomic, strong) HYDefaultTextField * phone_pwTF;
@property (nonatomic, strong) HYDefaultTextField * phone_codeTF;
@property (nonatomic, strong) HYDefaultTextField * pwTF;
@property (nonatomic, strong) HYDefaultTextField * codeTF;
@property (nonatomic, strong) HYDefaultTextField * setpwTF;

@property (nonatomic, strong) HYFillLongButton *submitbtn;
@property (nonatomic, strong) HYFillLongButton *submitRebtn;
@property (nonatomic, copy) HYDefaultButton * sendcodebtn;
@property (nonatomic, assign) NSInteger codecount;

/** 1.注册 2 忘记密码 3.登录*/
@property (nonatomic, assign) NSInteger viewType;

@property (nonatomic, copy) HYEventCallBackBlock submitBlock;

+ (instancetype)loginMainView;
+ (instancetype)registerMainView:(NSInteger)registerOrForgetpwType;

- (void)updateScrollviewOfferset;
@end


