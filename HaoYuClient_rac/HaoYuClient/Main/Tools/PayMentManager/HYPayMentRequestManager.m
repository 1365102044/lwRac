//
//  HYPayMentRequestManager.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/8/3.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYPayMentRequestManager.h"
#import "HYPayMentManager.h"
//部门id
#define DEPTID @"DBB65BB67208DC4BDD5A341NAB2A1C748C8C"
@interface HYPayMentRequestManager ()

@property (nonatomic, copy) HYEventCallBackBlock successBlock;
@property (nonatomic, copy) HYEventCallBackBlock failBlock;

@end

@implementation HYPayMentRequestManager

/**
 订单 / 定金 预支付订单
 @"payMethod" == 1 微信 else 支付宝
 @"payMentType"    账单类型 -> PayMentType
 */
+ (instancetype)payCreatPrePaymentForBillDespositWithPara:(NSMutableDictionary *)param
{
    HYPayMentRequestManager *instance = [[HYPayMentRequestManager alloc]init];
    PARA_CREART;
    [para addEntriesFromDictionary:param]; 
    NSString *urls = PAYMENT_CREATPREPAYMENT_BILLANDDESPOSIT_ALIP_URL; //支付宝
    if ([param[@"payMethod"] integerValue] == 1) {
        urls = PAYMENT_CREATPREPAYMENT_BILLANDDESPOSIT_URL; //微信
        PARA_SET([HYStringTool checkString:[HYStringTool getDeviceIPAddresses]], @"ipv4");//客户端终端ip
    }
    
    //优惠券账单
    if ([para[@"payMentType"] integerValue] == 4 &&
        [para[@"payMethod"] integerValue] == 1) {
        urls = PAYMENT_CREATPREPAYMENT_BILL_DISCOUNT_WEIXIN_URL;
    }else if ([para[@"payMentType"] integerValue] == 4){
        urls = PAYMENT_CREATPREPAYMENT_BILL_DISCOUNT_ALIP_URL;
    }
    
    //全部使用优惠券账单金额，不走支付
    if([para[@"isAllDisc"] isEqualToString:@"1"]){
        urls = BILL_WHEN_CHOOSEDISOCUNTMONEY_DAYUDENGYU_INPUNTMONEY_URL;
    }
    LWLog(@"\n\n\n+++++++++para:%@",para);
    [[HYServiceManager share] postRequestAnWithurl:urls
                                         paramters:para
                                      successBlock:^(id objc, id requestInfo) {
                                          LWLog(@"\n\n============生成与支付订单的objc:%@",objc);
                                          //全部使用优惠券充值，不走支付
                                          if([para[@"isAllDisc"] isEqualToString:@"1"]){
                                              NSString *code = @"100";
                                              NSString *msg = nil;
                                              if ([objc[@"result"] isKindOfClass:[NSDictionary class]]) {
                                                  msg = objc[@"result"][@"msg"];
                                              }
                                              if (msg) {
                                                  ALERT(msg);
                                                  code = @"99";
                                              }
                                              if (instance.successBlock) {
                                                  instance.successBlock(code);
                                              }
                                              return ;
                                          }
                                          
                                          // 微信支付
                                          if ([param[@"payMethod"] integerValue] == 1) {
                                              NSDictionary *map_dic = objc[@"result"][@"map"];
                                              NSDictionary *status_dic = objc[@"result"][@"status"];
                                              if (status_dic) {
                                                  ALERT(status_dic[@"msg"]);
                                                  
                                                  if (instance.failBlock) {
                                                      instance.failBlock(nil);
                                                  }
                                                  return ;
                                              }
                                              PARA_CREART;
                                              [para addEntriesFromDictionary:map_dic];
                                              if(para[@"packageValue"]){
                                                  [para removeObjectForKey:@"packageValue"];
                                                  para[@"package"] = map_dic[@"packageValue"];
                                              }
                                              [[HYPayMentManager shareManager] WechatPay:para];
                                              NSString *outTradeNo = para[@"outTradeNo"];
                                              if (instance.paramCallBlackBlock) {
                                                  instance.paramCallBlackBlock(outTradeNo);
                                              }
                                          }else{
                                              //支付宝
                                              [[HYPayMentManager shareManager] alipayWithorderSign:objc[@"result"][@"orderStr"]];
                                              NSString *outTradeNo =  objc[@"result"][@"outTradeNo"];
                                              if (instance.paramCallBlackBlock) {
                                                  instance.paramCallBlackBlock(outTradeNo);
                                              }
                                          }
                                          if (instance.successBlock) {
                                              instance.successBlock(objc);
                                          }
                                      } failureBlock:^(id error, id requestInfo) {
                                          if (instance.failBlock) {
                                              instance.failBlock(error);
                                          }
                                      }];
    return instance;
}

/**
 充值 生成预支付订单
 */
+ (instancetype)payCreatPrePaymentForRechargeWithPara:(NSMutableDictionary *)param
{
    HYPayMentRequestManager *instance = [[HYPayMentRequestManager alloc]init];
    PARA_CREART;
    [para addEntriesFromDictionary:param];
    
    //支付宝
    NSString *urls = PAYMENT_CREATPREPAYMENT_RECHARGE_DISCOUNT_ALIP_URL;
    para[@"payType"] = para[@"payMethod"];//微信/支付宝
    
    //优惠券账单 微信支付
    if ([para[@"payMethod"] integerValue] == 1) {
        PARA_SET([HYStringTool checkString:[HYStringTool getDeviceIPAddresses]], @"ipv4");//客户端终端ip
        urls = PAYMENT_CREATPREPAYMENT_RECHARGE_DISCOUNT_WEIXIN_URL;
    }
    
    //全部使用优惠券充值，不走支付
    if([para[@"isAllDisc"] isEqualToString:@"1"]){
        urls = RECHARGE_WHEN_CHOOSEDISOCUNTMONEY_DAYUDENGYU_INPUNTMONEY_URL;
        //支付方式1:微信2:支付宝0:优惠券 2018年11月19日16:44:39
        para[@"payType"] = @"0";
    }
        
    LWLog(@"\n\n\n+++++++++para:%@",para);
    [[HYServiceManager share] postRequestAnWithurl:urls
                                         paramters:para
                                      successBlock:^(id objc, id requestInfo) {
                                          LWLog(@"============%@",objc);
                                          //全部使用优惠券充值，不走支付
                                          if([para[@"isAllDisc"] isEqualToString:@"1"]){
                                              NSString *code = @"100";
                                              NSString *msg = nil;
                                              if ([objc[@"result"] isKindOfClass:[NSDictionary class]]) {
                                                  msg = objc[@"result"][@"msg"];
                                              }
                                              if (msg) {
                                                  ALERT(msg);
                                                  code = @"99";
                                              }
                                              if (instance.successBlock) {
                                                  instance.successBlock(code);
                                              }
                                              return ;
                                          }
                                          
                                          if ([param[@"payMethod"] integerValue] == 1) {
                                              NSDictionary *map_dic = objc[@"result"][@"map"];
                                              PARA_CREART;
                                              [para addEntriesFromDictionary:map_dic];
                                              if(para[@"packageValue"]){
                                                  [para removeObjectForKey:@"packageValue"];
                                                  para[@"package"] = map_dic[@"packageValue"];
                                              }
                                              [[HYPayMentManager shareManager] WechatPay:para];
                                              NSString *outTradeNo = para[@"outTradeNo"];
                                              if (instance.paramCallBlackBlock) {
                                                  instance.paramCallBlackBlock(outTradeNo);
                                              }
                                              LWLog(@"*************微信outTradeNo:%@",outTradeNo);
                                          }else{
                                              [[HYPayMentManager shareManager] alipayWithorderSign:objc[@"result"][@"orderStr"]];
                                              NSString *outTradeNo =  objc[@"result"][@"outTradeNo"];
                                              if (instance.paramCallBlackBlock) {
                                                  instance.paramCallBlackBlock(outTradeNo);
                                              }
                                              LWLog(@"*************支付宝outTradeNo:%@",outTradeNo);
                                          }
                                          
                                          if (instance.successBlock) {
                                              instance.successBlock(objc);
                                          }
                                      } failureBlock:^(id error, id requestInfo) {
                                          if (instance.failBlock) {
                                              instance.failBlock(error);
                                          }
                                      }];
    return instance;
}

- (void)payResultSuccessBlock:(HYEventCallBackBlock)successBlock
                    failBlock:(HYEventCallBackBlock)failBlock
{
    self.successBlock    = successBlock;
    self.failBlock       = failBlock;
}

@end