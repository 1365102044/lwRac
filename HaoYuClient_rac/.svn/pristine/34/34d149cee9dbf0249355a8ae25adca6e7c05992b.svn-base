//
//  HYPayViewController.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/13.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYPaymentViewController.h"
#import "HYPayMainView.h"
#import "HYPayMentRequestManager.h"
#import "HYPayMentManager.h"
#import "HYOnLineYuDingViewController.h"
#import "HYMineYuDingViewController.h"
#import "HYWaterElectricSurfaceDeatilViewController.h"
#import "HYPayDeatilViewController.h"
#import "HYNoPayBillViewController.h"
#import "HYBaseBarButtonItem.h"
#import "HYMineBillViewController.h"
#import "HYRequstGlobalDataTool.h"
#import "HYChooseDiscountViewController.h"
#import "HYDiscountModel.h"
#import "DecimalNumberTool.h"
#import "HYFuWuPingJiaViewController.h"
#import "LWPayMainView.h"
#import "HYPayResultQueryViewController.h"
#import "LWChoosePayMentView.h"
@interface HYPaymentViewController ()<payMentResultDelegate,payMainViewDelegate,chooseDiscountDelegate>
//@property (nonatomic, strong) HYPayMainView * mainView;
@property (nonatomic, strong) LWPayMainView * payMainView;

@property (nonatomic, strong) HYFillLongButton * payBtn;
@property (nonatomic, strong) id  extend;

/**
 项目ID 账单支付成功后，跳转评价使用
 */
@property (nonatomic, strong) NSString * houseItemId;

//支付类型（充值/缴租）
@property (nonatomic, assign) PayMentType  payType;
/**
 来源控制器
 */
@property (nonatomic, strong) HYBaseViewController * sourceVC;
/**
 充值水电表的优惠券
 */
@property (nonatomic, strong) NSMutableArray * DiscountMutableArray;
/**
 选择的优惠券
 */
@property (nonatomic, strong) NSMutableArray * selecDiscMutableArray;
/**
 选择的优惠券的总金额
 */
@property (nonatomic, strong) NSString * discAllMoney;
/**
 账单使用完优惠券后的应付金额
 */
@property (nonatomic, strong) NSString * billUseDiscShiuldPayMoney;

/**
 商户交易号
 */
@property (nonatomic, strong) NSString * outTradeNo;
/**
 充值方式（1：充值电费 2：充值冷水费 4：充值热水费）
 */
@property (nonatomic, assign) NSInteger rechargeTag;

/**
 支付方式：1 微信； 2 支付宝
 */
@property (nonatomic, assign) NSInteger payMethodTag;

@property (nonatomic, strong) LWChoosePayMentView * PayMethodView;

@end

@implementation HYPaymentViewController

#pragma mark - First.通知

/**
 充值水电表时 支付时 修改金额后，重新选择优惠券
 */
- (void)changeInputMoney:(NSNotification *)noti
{
    [self.selecDiscMutableArray removeAllObjects];
}

#pragma mark - Second.网络请求
/**
 获取支付水电费优惠券
 */
- (void)requestDiscountInforForRechargePay
{
    [self.selecDiscMutableArray removeAllObjects];
    [self.DiscountMutableArray removeAllObjects];
    NSString *inputMoney = _payMainView.moneyTextFlied.textFiled.text;
    if (![self checkMoneyLegal:inputMoney])  return;
    
    NSString *houseId = @"";
    if ([_extend isKindOfClass:[NSDictionary class]]) {
        houseId = [_extend objectForKey:@"houseId"];
    }
    [[HYRequstGlobalDataTool new] requestDiscountInforForRechargeWithHouseId:houseId money:inputMoney CallBackBlock:^(id sender) {
        //清空已选择的优惠券
        _payMainView.discountDatas = nil;
        
        NSArray *datas = (NSArray *)sender;
        for (NSDictionary *dic in datas) {
            [self.DiscountMutableArray addObject:[HYDiscountModel modelWithJSON:dic]];
        }
        if (self.DiscountMutableArray == nil ||
            self.DiscountMutableArray.count == 0) {
            ALERT(@"未查询到可用的优惠券");
            return ;
        }
        HYChooseDiscountViewController *discountVC = [HYChooseDiscountViewController creatChooseDiscountVCWithDatas:self.DiscountMutableArray sourceVC:self extend:nil];
        discountVC.delegate = self;
        [self.navigationController pushViewController:discountVC animated:YES];
    } failureBlock:^(id sender) {
        
    }];
}

/**
 计算 账单的优惠金额
 */
- (void)requestMoneyAfterDiscountDiKou{
    if (![_extend isKindOfClass:[NSDictionary class]]) {
        return;
    }
    [[HYRequstGlobalDataTool new] requestMoneyWhenUseDiscountDikouWithjson:_extend[@"json"] CallBackBlock:^(id sender) {
        LWLog(@"\n\n*****计算优惠金额objc:%@",sender);
        NSDictionary *objc = (NSDictionary *)sender;
        if ([objc isKindOfClass:[NSDictionary class]]) {
            self.payMainView.infor = objc;
        }
    } failureBlock:^(id sender) {
        LWLog(@"\n\n*****计算优惠金额error:%@",sender);
    }];
}

/**
 支付失败后，更新优惠券状态
 */
- (void)updateCouponStatusWhenPayFail
{
    NSString *keys = [NSString stringWithFormat:@"%@_coupon",USERDEFAULTS_GET(USER_INFOR_USERID)];
    NSArray *selectCouponArray = USERDEFAULTS_GET(keys);
    if (!selectCouponArray || ![selectCouponArray isKindOfClass:[NSArray class]] || selectCouponArray.count == 0) {
        return;
    }
    PARA_CREART;
    PARA_SET(selectCouponArray, @"ids");
    LWLog(@"********修改优惠券状态的参数para:%@",para);
    [[HYServiceManager share] postRequestAnWithurl:UPDATE_COUPON_USESTATUS_URL paramters:para successBlock:^(id objc, id requestInfo) {
        LWLog(@"***********更新优惠券状态成功 %@",objc);
        
        USERDEFAULTS_RE(keys);
    } failureBlock:^(id error, id requestInfo) {
        LWLog(@"***********更新优惠券状态失败 %@",error);
    }];
    
}

#pragma mark - Third.点击事件


/**
 点击下一步
 */
- (void)clickNextBtn
{
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    
    if (_payType == PAYMENTTYPE_RECHARGE) {
        NSString *inputMoney = _payMainView.moneyTextFlied.textFiled.text;
        if(![self checkMoneyLegal:inputMoney]) return;
        //优惠券的总金额 不小于 输入的金额时 不再走支付，直接使用优惠充值，
        if ([_discAllMoney doubleValue] >= [inputMoney doubleValue]) {
            [HYWraingAlert showAlert:self
                               title:@"提示"
                             message:@"本次充值可被优惠券完全抵扣,是否继续操作？"
                  defaultButtonTitle:@"取消"
                   cancelButtonTitle:@"确定"
          defaultButtonCallBackBlock:^(id sender) {
          } cancelButtonCallBackBlock:^(id sender) {
              [self RechargePay:YES];
          }];
            return;
        }
    }
    
    NSString *typeStr = @"";
    NSString *moneyAmount = @"";
    if (_payType == PAYMENTTYPE_DEPOSIT) {
        typeStr = @"定金缴费";
        moneyAmount = @"金额:￥ 1000";
        
    }else if (_payType == PAYMENTTYPE_RECHARGE){
        if(_rechargeTag == 1){
            typeStr = @"电费充值";
        }else if(_rechargeTag == 2 || _rechargeTag == 4){
            typeStr = @"水费充值";
        }
        moneyAmount = [NSString stringWithFormat:@"金额:￥ %@",self.payMainView.moneyTextFlied.textFiled.text];
        if (_payMainView.discountDatas && _payMainView.discountDatas.count > 0) {
            moneyAmount = @"金额: 已使用优惠券，以实际支付金额为准";
        }
    }else{
        typeStr = @"房租缴费";
        moneyAmount = [NSString stringWithFormat:@"金额:￥ %@",_payMainView.infor[@"iosPay"]];
    }
    WEAKSELF(self);
   _PayMethodView =  [LWChoosePayMentView showChoosePayMethodViewWithTitle:typeStr desc:moneyAmount imageName:[self.payMainView getLogoImageName]
                          callBlackBlock:^(id sender) {
                              if ([sender integerValue] == 2 && weakself.payMethodTag == 0) {
                                  ALERT(@"请选择支付方式");
                                  return ;
                              }
                              if ([sender integerValue] == 2) {
                                  // 确认支付
                                  [weakself clickPaybtn];
                              }
                          }];
    _PayMethodView.selectPayMethodBlock = ^(id sender) {
        weakself.payMethodTag = [sender integerValue];
    };
    
}

/**
 确认支付
 */
- (void)clickPaybtn
{
    if (_payType == PAYMENTTYPE_RECHARGE) {
        [self RechargePay:NO];
    }else if(_payType == PAYMENTTYPE_BILLPAY ||
             _payType == PAYMENTTYPE_BILLDISCOUNTPAY ||
             _payType == PAYMENTTYPE_DEPOSIT){
        [self billOrDespoistPay];
    }
}

/**
 账单/定金支付  配置参数
 */
- (void)billOrDespoistPay
{
    //    1:收支id;2:预订id
    NSInteger index = 1;//收支
    if(_payType == PAYMENTTYPE_DEPOSIT) index = 2;
    PARA_CREART;
    PARA_SET(@(index), @"type");
    if ([_extend isKindOfClass:[NSDictionary class]]) {
        if (_extend[@"ids"]) {
            PARA_SET(_extend[@"ids"], @"ids");
        }
        PARA_SET([HYStringTool checkString:_extend[@"deptId"]], @"deptId");
    }
    PARA_SET(@(_payMethodTag), @"payMethod");
    PARA_SET(@(_payType), @"payMentType");
    //json 优惠券账单支付
    if(_payType == PAYMENTTYPE_BILLDISCOUNTPAY &&
       [_extend isKindOfClass:[NSDictionary class]]){
        PARA_SET(_extend[@"json"], @"json");
    }
    //判断是否账单
    if ((_payType == PAYMENTTYPE_BILLPAY ||
         _payType == PAYMENTTYPE_BILLDISCOUNTPAY) &&
        self.billUseDiscShiuldPayMoney != nil &&
        [self.billUseDiscShiuldPayMoney doubleValue] == 0)
    {
        PARA_SET(@"1", @"isAllDisc");
    }
    [self toPayWithParam:para type:2];
}

/**
 充值支付 配置参数 （水费/电费）
 */
- (void)RechargePay:(BOOL)isAllDisc
{
    PARA_CREART;
    
    NSString *inputMoney = _payMainView.moneyTextFlied.textFiled.text;
    if (![self checkMoneyLegal:inputMoney])  return;
    
    PARA_SET(@(_payMethodTag), @"payMethod");
    PARA_SET(@(_payType), @"payMentType");
    PARA_SET(_payMainView.moneyTextFlied.textFiled.text, @"totalFee");
    if ([_extend isKindOfClass:[NSDictionary class]]) {
        [para addEntriesFromDictionary:_extend];
    }
    //优惠券
    PARA_SET(self.selecDiscMutableArray, @"couponids");
    
    //是否 全部使用优惠券
    if (isAllDisc) {
        PARA_SET(@"1", @"isAllDisc");
    }
    [self toPayWithParam:para type:1];
}

/**
 去调支付
 1.充值；
 2.账单/定金
 */
- (void)toPayWithParam:(NSMutableDictionary *)para type:(NSInteger)type
{
    HYPayMentRequestManager *instance;
    if (type == 1) {
        instance = [HYPayMentRequestManager payCreatPrePaymentForRechargeWithPara:para];
    }else if (type == 2){
        instance = [HYPayMentRequestManager payCreatPrePaymentForBillDespositWithPara:para];
    }
    //控制点击
    _payBtn.userInteractionEnabled = NO;
    WEAKSELF(self);
    [instance payResultSuccessBlock:^(id sender) {
        // 全额优惠券抵扣
        if([sender isKindOfClass:[NSString class]] && [sender integerValue] == 100){
            [weakself payMentResultHandleWithpayMethod:@"DISC"
                                                  code:100
                                             errordesc:@""];
        }
        weakself.payBtn.userInteractionEnabled = YES;
        
        
        if(_payType == PAYMENTTYPE_RECHARGE){
            // 充值
            if (_selecDiscMutableArray && _selecDiscMutableArray.count > 0) {
                NSString *key = [NSString stringWithFormat:@"%@_coupon",USERDEFAULTS_GET(USER_INFOR_USERID)];
                USERDEFAULTS_SET(_selecDiscMutableArray, key);
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
        }else if (_payType == PAYMENTTYPE_BILLDISCOUNTPAY)
        {
            // 账单
            @try {
                NSArray *jsons = _extend[@"json"];
                NSMutableArray *cidsMutableArray = [[NSMutableArray alloc] init];
                for (NSDictionary *dict in jsons) {
                    NSArray *cids = dict[@"cid"];
                    [cidsMutableArray addObjectsFromArray:cids];
                }
                NSString *keys = [NSString stringWithFormat:@"%@_coupon",USERDEFAULTS_GET(USER_INFOR_USERID)];
                USERDEFAULTS_SET(cidsMutableArray, keys);
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                LWLog(@"*********** %@",USERDEFAULTS_GET(keys));
                
            } @catch (NSException *exception) {
                
            } @finally {
                
            }
        }
        
    } failBlock:^(id sender) {
        weakself.payBtn.userInteractionEnabled = YES;
    }];
    instance.paramCallBlackBlock = ^(id sender) {
        weakself.outTradeNo = (NSString *)sender;
        LWLog(@"+++++++++++++++%@",weakself.outTradeNo);
    };
}

#pragma mark - Fourth.代理方法

#pragma  =============== 支付结果 代理 ==================
- (void)payMentResultHandleWithpayMethod:(NSString *)payMethod
                                    code:(NSInteger)code
                               errordesc:(NSString *)errordesc
{
    LWLog(@"\n\n\n\n**********HYMineYuDingViewController:%@******code:%ld****errordesc:%@",payMethod,code,errordesc);
    
//    [_PayMethodView dismiss];
    
    if (([payMethod isEqualToString:@"WX"] && code == 100) ||
        ([payMethod isEqualToString:@"ALI"] && code == 9000) ||
        [payMethod isEqualToString:@"DISC"]) {
        
        // 全额优惠券抵扣
        if ([payMethod isEqualToString:@"DISC"]) {
            if ([_sourceVC isKindOfClass:[HYOnLineYuDingViewController class]]) {
                ALERT(@"预定成功！");
                [self.navigationController popToRootViewControllerAnimated:YES];
            }else if ([_sourceVC isKindOfClass:[HYMineYuDingViewController class]]){
                ALERT(@"预定成功！");
                [self.navigationController popToViewController:_sourceVC animated:YES];
                [(HYMineYuDingViewController *)_sourceVC  requestListInfor];
            }else if ([_sourceVC isKindOfClass:[HYWaterElectricSurfaceDeatilViewController class]]){
                NSString *temp  = @"充值成功！";
                ALERT(temp);
                [self.navigationController popToViewController:_sourceVC animated:YES];
                [(HYWaterElectricSurfaceDeatilViewController *)_sourceVC requestInfor];
            }else if ([_sourceVC isKindOfClass:[HYPayDeatilViewController class]]){
                NSString *temp = @"";
                if (_payType == PAYMENTTYPE_RECHARGE) {
                    temp = @"充值成功！";
                }else if (_payType == PAYMENTTYPE_BILLPAY ||
                          _payType == PAYMENTTYPE_DEPOSIT){
                    temp = @"账单支付成功！";
                    ALERT(temp);
                    [self mustPingJiaWithSourceVC:_sourceVC];
                    return;
                }
                ALERT(temp);
                [self.navigationController popToViewController:_sourceVC animated:YES];
                [(HYPayDeatilViewController *)_sourceVC requestListInfor];
            }else if ([_sourceVC isKindOfClass:[HYNoPayBillViewController class]]){
                ALERT(@"账单支付成功！");
                NSArray *vcs = self.navigationController.viewControllers;
                NSInteger index = 0;
                for (UIViewController *vc in vcs) {
                    if ([vc isKindOfClass:[HYMineBillViewController class]]) {
                        index = [vcs indexOfObject:vc];
                    }
                }
                [self mustPingJiaWithSourceVC:vcs[index]];
            }else{
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
            return;
        }
        HYPayResultQueryViewController *queryPayResultVC = [[HYPayResultQueryViewController alloc] init];
        [queryPayResultVC payMentResultHandleWithpayType:self.payType fromVC:_sourceVC outTradeNo:_outTradeNo houseItemId:_houseItemId];
        [self.navigationController pushViewController:queryPayResultVC animated:YES];
        
    }else{
        [self updateCouponStatusWhenPayFail];
        NSString *msg = [NSString stringWithFormat:@"支付失败 code:%ld,",(long)code];
        ALERT(msg);
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

#pragma  ================= payMainViewDelegate ==================
/**
 充值水电表 输入金额后，请求优惠券后 -> 选择优惠券
 */
- (void)pushChooseDiscountViewController
{
    [self requestDiscountInforForRechargePay];
}

#pragma ================= chooseDiscountDelegate ============

- (void)alearySelectDicount:(NSArray *)discounts indexPath:(NSIndexPath *)indexPath
{
    _discAllMoney = @"0";
    for (HYDiscountModel *disc_M in discounts) {
        [self.selecDiscMutableArray addObject:disc_M.customId];
        _discAllMoney = [[DecimalNumberTool share] SumWithStr1:_discAllMoney Str2:disc_M.iosDedicated];
    }
    _payMainView.discountDatas = discounts;
    
}

/**
 检查输入的money 是否合法
 */
- (BOOL)checkMoneyLegal:(NSString *)amount
{
    NSDecimalNumber *number = [NSDecimalNumber decimalNumberWithString:[HYStringTool checkString:amount]];
    NSDecimalNumber *number0 = [NSDecimalNumber decimalNumberWithString:@"0"];
    if ([amount isEqualToString:@""] ||
        [number compare:number0] == kCFCompareEqualTo) {
        ALERT(@"请输入金额");
        return NO;
    }
    return YES;
}


#pragma mark - Fifth.视图生命周期
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    _payMainView.discountDatas = nil;
}

+ (void)pushPayViewController:(HYBaseViewController *)soruceVC
                  PayMentType:(PayMentType)PayMentType
                       extend:(id)extend
{
    HYPaymentViewController *instance    = [[HYPaymentViewController alloc] init];
    instance.extend                      = extend;
    instance.payType                     = PayMentType;
    instance.sourceVC                    = soruceVC;
    [soruceVC.navigationController pushViewController:instance animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.closePopGesture = YES;
    self.view.backgroundColor = HYCOLOR.color_c1;
    
    [self setUI];
    [self confi];
}

/**
 功能配置
 */
- (void)confi
{
    [HYPayMentManager shareManager].resultDelegate = self;
    
    WEAKSELF(self);
    _payMainView.clickBtn = ^(id sender) {
        NSInteger tags = [sender integerValue];
        if (tags == 3){
            // 选中优惠券
            [weakself pushChooseDiscountViewController];
        }else if (tags == 4){
            [weakself clickNextBtn];
        }
    };
    
    /**
     充值水电表时 支付时 修改金额后，重新选择优惠券
     */
    ADD_NOTI(changeInputMoney:, CHANGE_INPUTMONEY_FOR_RECHARGE_DISCOUNT_KEY);
}

#pragma mark - Sixth.界面配置

/**
 设置标题
 */
- (void)setNavigatorTitle
{
    NSString *tis = @"支付";
    if (_payType == PAYMENTTYPE_BILLDISCOUNTPAY ||
        _payType == PAYMENTTYPE_BILLPAY) {
        tis = @"支付账单";
        if ([_extend isKindOfClass:[NSDictionary class]]) {
            _houseItemId = _extend[@"houseItemId"];
            [self requestMoneyAfterDiscountDiKou];
        }
    }
    if (_payType == PAYMENTTYPE_DEPOSIT) tis = @"支付定金";
    if  (_payType == PAYMENTTYPE_RECHARGE &&
         [_extend isKindOfClass:[NSDictionary class]]){
        NSInteger num = [_extend[@"num"] integerValue];
        if(num == 1) tis = @"充值电费";
        if(num == 2) tis = @"充值冷水费";
        if(num == 4) tis = @"充值热水费";
        self.payMainView.rechargeTag = self.rechargeTag = num;
    }
    self.title = tis;
}

- (void)setNavi
{
    self.navigationItem.leftBarButtonItem = [HYBaseBarButtonItem backbarButtonItemWithCallBack:^(id sender) {
        [HYWraingAlert showAlert:self
                           title:@"确定退出支付？"
                         message:@""
              defaultButtonTitle:@"取消"
               cancelButtonTitle:@"确定"
      defaultButtonCallBackBlock:^(id sender) {
      } cancelButtonCallBackBlock:^(id sender) {
          NSArray *nav_Vcs = self.navigationController.viewControllers;
          __block BOOL isHave = NO;
          [nav_Vcs enumerateObjectsUsingBlock:^(UIViewController *  _Nonnull vc, NSUInteger idx, BOOL * _Nonnull stop) {
              if ([vc isKindOfClass:[HYOnLineYuDingViewController class]]) {
                  [self.navigationController popToViewController:nav_Vcs[nav_Vcs.count - 3] animated:YES];
                  isHave = YES;
                  *stop = YES;
              }
          }];
          if (!isHave) {
              [self.navigationController popViewControllerAnimated:YES];
          }
      }];
    }];
}

- (void)setUI
{
    [self setNavi];
    [self setNavigatorTitle];
    [self.view addSubview:self.payMainView];
    [self.payMainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(SCREEN_WIDTH);
        make.edges.mas_equalTo(self.view);
    }];
}

#pragma mark - Seventh.懒加载

- (LWPayMainView*)payMainView
{
    if (!_payMainView) {
        _payMainView = [LWPayMainView getPayMainView:_payType];
    }
    return _payMainView;
}

- (HYFillLongButton*)payBtn
{
    if (!_payBtn) {
        _payBtn = [HYFillLongButton buttonCorWithTitleStringKey:@"确认支付"
                                                         target:self
                                                       selector:@selector(clickPaybtn)];
    }
    return _payBtn;
}
/**
 充值水电表的优惠券
 */
- (NSMutableArray*)DiscountMutableArray
{
    if (!_DiscountMutableArray) {
        _DiscountMutableArray = [[NSMutableArray alloc] init];
    }
    return _DiscountMutableArray;
}

- (NSMutableArray*)selecDiscMutableArray
{
    if (!_selecDiscMutableArray) {
        _selecDiscMutableArray = [[NSMutableArray alloc] init];
    }
    return _selecDiscMutableArray;
}
#pragma mark - Eigth.Other


@end
