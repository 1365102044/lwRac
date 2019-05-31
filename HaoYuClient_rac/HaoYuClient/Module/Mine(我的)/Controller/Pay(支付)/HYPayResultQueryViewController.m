//
//  HYPayResultQueryViewController.m
//  HaoYuClient
//
//  Created by 刘文强 on 2019/1/24.
//  Copyright © 2019年 LWQ. All rights reserved.
//

#import "HYPayResultQueryViewController.h"
#import "HYCircleView.h"
#import "HYWraingAlert.h"
#import "HYOnLineYuDingViewController.h"
#import "HYMineYuDingViewController.h"
#import "HYWaterElectricSurfaceDeatilViewController.h"
#import "HYPayDeatilViewController.h"
#import "HYNoPayBillViewController.h"
#import "HYMineBillViewController.h"
#import "HYFuWuPingJiaViewController.h"

@interface HYPayResultQueryViewController ()

@property (nonatomic, strong) HYCircleView * cricleView;

/**
 状态（0-未支付；1-支付中；10-支付成功；-1-支付失败）
 */
@property (nonatomic, strong) NSString * resultStatus;

/**
 商户交易号
 */
@property (nonatomic, copy) NSString * outTradeNo;
@property (nonatomic, assign) PayMentType payType;
@property (nonatomic, strong) HYBaseViewController * sourceVC;

/**
 项目ID 账单支付成功后，跳转评价使用
 */
@property (nonatomic, strong) NSString * houseItemId;

@end

@implementation HYPayResultQueryViewController

#pragma mark - First.通知
/**
 根据支付不同跳转
 
 @param payType 支付方式
 @param fromVC 支付的来源控制器
 @param outTradeNo 商户交易号
 @param houseItemId 项目ID
 */
- (void)payMentResultHandleWithpayType:(PayMentType)payType
                                fromVC:(HYBaseViewController *)fromVC
                            outTradeNo:(NSString *)outTradeNo
                           houseItemId:(NSString *)houseItemId
{
    _outTradeNo = outTradeNo;
    _payType = payType;
    _sourceVC = fromVC;
    _houseItemId = houseItemId;
}

#pragma mark - Second.网络请求

- (void)queryPayResult
{
    if (!_outTradeNo) {
        ALERT(@"网络异常!");
        return;
    }
    PARA_CREART;
    PARA_SET(_outTradeNo, @"outTradeNo");
    NSLog(@"**********%@",_outTradeNo);
    [[HYServiceManager share] postRequestWithurl:QUERY_PAYMENT_RESULT_URL
                                       paramters:para
                                    successBlock:^(id objc, id requestInfo) {
                                        @try {
                                            NSString *resultStatus = objc[@"result"][@"resultStatus"];
                                            self.resultStatus = [NSString stringWithFormat:@"%@",resultStatus];
                                            NSLog(@"self.resultStatus:%@",self.resultStatus);
                                        } @catch (NSException *exception) {
                                            
                                        } @finally {
                                            
                                        }
                                        
                                    } failureBlock:^(id error, id requestInfo) {
                                        
                                    }];
}

#pragma mark - Third.点击事件

#pragma mark - Fourth.代理方法

#pragma mark - Fifth.视图生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"支付结果查询";
    
    [self queryPayResult];
    
    [self confiUI];
    
    // 10s超时
    WEAKSELF(self);
    self.cricleView.timerStopCallBlock = ^(id sender) {
        [HYWraingAlert showAlert:weakself
                           title:@""
                         message:@"数据请求超时，请选择其它时间查看缴费记录，如有问题，请及时联系管家处理"
               cancelButtonTitle:@"确定"
       cancelButtonCallBackBlock:^(id sender) {
           [weakself popFromVC:NO];
       }];
    };
    
    // 每秒返回一次
    self.cricleView.timerCallBlock = ^(id sender) {
        
        if ([weakself.resultStatus isEqualToString:@"0"]) {
            
            [weakself.cricleView stopTimer];
            
            [HYWraingAlert showAlert:weakself
                               title:@""
                             message:@"未获取到有效的支付行为，请稍后检查数据再次尝试。"
                   cancelButtonTitle:@"确定"
           cancelButtonCallBackBlock:^(id sender) {
               [weakself popFromVC:NO];
           }];
            
        } else if([weakself.resultStatus isEqualToString:@"1"]) {
            
            [[HYProjectNetRequestManager sharedNetRequestManager] cancelNetworkRequest];
            [weakself queryPayResult];
            
        }else if([weakself.resultStatus isEqualToString:@"10"]) {
           
            [weakself.cricleView stopTimer];
            // 支付成功！
            [weakself popFromVC:YES];
            
        }else if([weakself.resultStatus isEqualToString:@"-1"]) {
            
            [weakself.cricleView stopTimer];
            
            [HYWraingAlert showAlert:weakself
                               title:@""
                             message:@"由于不知名的的问题导致支付失败，请稍后再试。 o(∩_∩)o"
                   cancelButtonTitle:@"确定"
           cancelButtonCallBackBlock:^(id sender) {
               [weakself popFromVC:NO];
           }];
        }
    };
}

- (void)popFromVC:(BOOL)isSuccess
{
    if ([_sourceVC isKindOfClass:[HYOnLineYuDingViewController class]]) {
        //        直接预定后支付
        if(isSuccess) ALERT(@"预定成功！");
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else if ([_sourceVC isKindOfClass:[HYMineYuDingViewController class]]){
        //        预定列表
        if(isSuccess) ALERT(@"预定成功！");
        [self.navigationController popToViewController:_sourceVC animated:YES];
        [(HYMineYuDingViewController *)_sourceVC  requestListInfor];
    }else if ([_sourceVC isKindOfClass:[HYWaterElectricSurfaceDeatilViewController class]]){
        //        充值
        NSString *temp  = @"充值成功！";
        if(isSuccess) ALERT(temp);
        [self.navigationController popToViewController:_sourceVC animated:YES];
        [(HYWaterElectricSurfaceDeatilViewController *)_sourceVC requestInfor];
    }else if ([_sourceVC isKindOfClass:[HYPayDeatilViewController class]]){
        //        缴费
        NSString *temp = @"支付成功！";
        if (_payType == PAYMENTTYPE_RECHARGE) {
            temp = @"充值成功！";
        }else if (_payType == PAYMENTTYPE_BILLPAY ||
                  _payType == PAYMENTTYPE_DEPOSIT){
            temp = @"账单支付成功！";
            if(isSuccess) {
                ALERT(temp);
                [self mustPingJiaWithSourceVC:_sourceVC];
            }else{
                [self.navigationController popToViewController:_sourceVC animated:YES];
//                [self.sourceVC requestListInfor];
                POST_NOTI(PAYMENT_AFTER_REFRESH_BILLLIST_KEY, nil);
            }
            return;
        }
        if(isSuccess) ALERT(temp);
        [self.navigationController popToViewController:_sourceVC animated:YES];
//        [(HYPayDeatilViewController *)_sourceVC requestListInfor];
        POST_NOTI(PAYMENT_AFTER_REFRESH_BILLLIST_KEY, nil);
    }else if ([_sourceVC isKindOfClass:[HYNoPayBillViewController class]]){
        //        代缴账单列表
        NSArray *vcs = self.navigationController.viewControllers;
        NSInteger index = 0;
        for (UIViewController *vc in vcs) {
            if ([vc isKindOfClass:[HYMineBillViewController class]]) {
                index = [vcs indexOfObject:vc];
            }
        }
        if(isSuccess) {
            ALERT(@"账单支付成功！");
            [self mustPingJiaWithSourceVC:vcs[index]];
        }else{
            [self.navigationController popToViewController:vcs[index] animated:YES];
//            [self.sourceVC requestListInfor];
            POST_NOTI(PAYMENT_AFTER_REFRESH_BILLLIST_KEY, nil);
        }
    }else{
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

/**
 账单支付成功后，必须评价 2018年11月28日09:21:48
 */
- (void)mustPingJiaWithSourceVC:(HYBaseViewController *)sourceVC
{
    HYFuWuPingJiaViewController *pingjia = [HYFuWuPingJiaViewController creatFuWuPingJiaViewControllerWithhouseItemId:_houseItemId extend:@"100"];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:pingjia];
    WEAKSELF(self);
    pingjia.submitBlock = ^{
        [weakself.navigationController popToViewController:sourceVC animated:YES];
//        [weakself.sourceVC requestListInfor];
        POST_NOTI(PAYMENT_AFTER_REFRESH_BILLLIST_KEY, nil);
    };
    [self presentViewController:nav animated:YES completion:nil];
}

#pragma mark - Sixth.界面配置
- (void)confiUI{
    
    self.cricleView = [[HYCircleView alloc] init];
    [self.view addSubview:self.cricleView];
    [self.cricleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 80));
        make.centerX.equalTo(self.view);
        make.centerY.mas_equalTo(self.view.mas_centerY).offset(-ADJUST_PERCENT_FLOAT(40));
    }];
    
    HYDefaultLabel *des_L = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(15) text:@"支付请求已发起，正在等待支付结果。\n请勿离开此页面" textColor:HYCOLOR.color_c4];
    des_L.numberOfLines = 2;
    des_L.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:des_L];
    [des_L mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.cricleView.mas_bottom).mas_offset(ADJUST_PERCENT_FLOAT(50));
        make.left.equalTo(self.view.mas_left).mas_offset(20);
        make.right.equalTo(self.view.mas_right).mas_offset(-20);
    }];
}
#pragma mark - Seventh.懒加载

#pragma mark - Eigth.Other

@end
