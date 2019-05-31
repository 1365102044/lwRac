//
//  HYMineViewController.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/5/21.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYMineViewController.h"
#import "HYMineMainView.h"
#import "HYMineContractViewController.h"
#import "HYMineBillViewController.h"
#import "HYBaoXiuViewController.h"
#import "HYWaterElectricSurfaceViewController.h"
#import "HYMineYuYueViewController.h"
#import "HYMineYuDingViewController.h"
#import "HYYouHuiQuanViewController.h"
#import "HYMineJiFenViewController.h"
#import "HYMineActivityViewController.h"
#import "HYMineCollectViewController.h"
#import "HYFuWuPingJiaViewController.h"
#import "HYTouSuJianYiViewController.h"
#import "HYContractModel.h"
#import "HYWaterElectricSurfaceDeatilViewController.h"
#import "HYChangeLockPwViewController.h"
#import "HYPayDeatilViewController.h"
#import "HYRequstGlobalDataTool.h"
#import "LWLoginViewController.h"
#import "HYBaseNavigationController.h"
@interface HYMineViewController ()
@property (nonatomic, strong) HYMineMainView * mineMainView;
@end

@implementation HYMineViewController

#pragma mark - First.通知

#pragma mark - Second.赋值

#pragma mark - Third.点击事件
- (void)pushWhereVC:(NSString *)TitleKey
{
    HYBaseViewController *VC ;
    NSArray *heTongArr = [[HYUserInfor_LocalData share] getHeTongInfor];
    
    NSArray *hetongMutableArray_2 = [HYUserInfor_LocalData share].getHeTong2Infor;
    
    if (hetongMutableArray_2.count == 0 && ([TitleKey isEqualToString:@"水表"]    ||
                                            [TitleKey isEqualToString:@"电表"]    ||
                                            [TitleKey isEqualToString:@"智能门锁"] ||
                                            [TitleKey isEqualToString:@"缴费"]    ||
                                            [TitleKey isEqualToString:@"报修"]    ||
                                            [TitleKey isEqualToString:@"保洁"]    ||
                                            [TitleKey isEqualToString:@"账单"]    ||
                                            [TitleKey isEqualToString:@"投诉建议"] ||
                                            [TitleKey isEqualToString:@"服务评价"])) {
        ALERT(@"没有有效合同");
        return;
    }
    if (hetongMutableArray_2.count >= 2 && ([TitleKey isEqualToString:@"水表"]     ||
                                            [TitleKey isEqualToString:@"电表"]     ||
                                            [TitleKey isEqualToString:@"智能门锁"]  ||
                                            [TitleKey isEqualToString:@"缴费"]     ||
                                            [TitleKey isEqualToString:@"账单"])) {
        HYWaterElectricSurfaceViewController * surfaceVC =  [HYWaterElectricSurfaceViewController pushWaterElectricSurfaceVCwith:@"请选择合同"];
        surfaceVC.HeTongDataArr     =  hetongMutableArray_2 ;
        surfaceVC.sourceType        = TitleKey;
        surfaceVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:surfaceVC animated:YES];
        return;
    }
    if(hetongMutableArray_2.count == 1 && ([TitleKey isEqualToString:@"水表"]      ||
                                           [TitleKey isEqualToString:@"电表"]      ||
                                           [TitleKey isEqualToString:@"智能门锁"]   ||
                                           [TitleKey isEqualToString:@"缴费"]      ||
                                           [TitleKey isEqualToString:@"账单"])){
        HYContractModel *contractModel = hetongMutableArray_2.firstObject;
        
        // 分散式不能使用水电表、智能门锁 2018年12月25日09:54:54
        if ([contractModel.isJiZhong integerValue] != 1 && ([TitleKey isEqualToString:@"水表"] ||
                                                            [TitleKey isEqualToString:@"电表"] ||
                                                            [TitleKey isEqualToString:@"智能门锁"])) {
            NSString *alearStr = [NSString stringWithFormat:@"该合同未查询到%@相关信息",TitleKey];
            ALERT(alearStr);
            return;
        }
        
        if ([TitleKey isEqualToString:@"水表"] ||
            [TitleKey isEqualToString:@"电表"]){
            VC = [HYWaterElectricSurfaceDeatilViewController creatSurfaceDeatilViewController:TitleKey heTongModel:contractModel];
        }else if ([TitleKey isEqualToString:@"账单"]) {
            HYContractModel *contractModel = hetongMutableArray_2.firstObject;
            VC = [HYMineBillViewController creatBillViewController:contractModel];
        }else if ([TitleKey isEqualToString:@"智能门锁"]){
            VC = [HYChangeLockPwViewController  creatChangeLockPwViewController:nil heTongModel:contractModel];
        }else if ([TitleKey isEqualToString:@"缴费"]){
            VC = [HYPayDeatilViewController creatPayDeatilViewController:contractModel];
        }
        VC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:VC animated:YES];
        return;
    }
    
    if ([TitleKey isEqualToString:@"合同"]){
        VC = [[HYMineContractViewController alloc] init];
    }else if ([TitleKey isEqualToString:@"报修"] ||
              [TitleKey isEqualToString:@"保洁"]){
        VC = [HYBaoXiuViewController creatWeiXiuViewController:TitleKey];
    }else if ([TitleKey isEqualToString:@"我的预约"]){
        VC = [[HYMineYuYueViewController alloc] init];
    }else if ([TitleKey isEqualToString:@"我的预定"]){
        VC = [[HYMineYuDingViewController alloc] init];
    }else if ([TitleKey isEqualToString:@"我的优惠券"]){
        VC = [[HYYouHuiQuanViewController alloc] init];
    }else if ([TitleKey isEqualToString:@"我的活动"]){
        VC = [[HYMineActivityViewController alloc] init];
    }else if ([TitleKey isEqualToString:@"我的收藏"]){
        VC = [[HYMineCollectViewController alloc] init];
    }else if ([TitleKey isEqualToString:@"我的积分"]){
        VC = [[HYMineJiFenViewController alloc] init];
    }
    HYContractModel *hetong_M = heTongArr.firstObject;
    if ([TitleKey isEqualToString:@"投诉建议"]){
        VC = [HYTouSuJianYiViewController creatTouSuJianYiViewControllerWithHeTongModel:hetong_M];
    }else if ([TitleKey isEqualToString:@"服务评价"]){
        VC = [HYFuWuPingJiaViewController creatFuWuPingJiaViewControllerWithhouseItemId:hetong_M.houseItemId extend:nil];
    }
    VC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:VC animated:YES];
}

#pragma mark - Fourth.网络方法
- (void)requstRereshInfor
{
    WEAKSELF(self);
    [[HYRequstGlobalDataTool new] requestUserInforCallBackBlock:^(id sender) {
        [weakself.MainScrollView.mj_header endRefreshing];
    }fail:^(id sender) {
        [weakself.MainScrollView.mj_header endRefreshing];
    }];
    [HYUserInfor_LocalData share].isReHT_SuccessBooL = NO;
    [[HYRequstGlobalDataTool new] requestUserHeTongInfor];
}

/** 修改手机号后，重新登录 */
- (void)changePhone:(NSNotification *)noti
{
//    [self requstRereshInfor];
    LWLoginViewController *loginVC = [[LWLoginViewController alloc] init];
    loginVC.sourceTabbarIndex = 3;
    HYBaseNavigationController *navi = [[HYBaseNavigationController alloc] initWithRootViewController:loginVC];
    WEAKSELF(self);
    [self presentViewController:navi animated:YES completion:^{
        weakself.tabBarController.selectedIndex = 0;
        USERDEFAULTS_RE(USER_TOKEN_KEY);
    }];
}
#pragma mark - Fifth.视图生命周期

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[HYRequstGlobalDataTool new] requestUserHeTongInfor];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.MainScrollView.mj_header endRefreshing];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = HYCOLOR.color_c1;
    
    [self setUI];
    WEAKSELF(self);
    self.mineMainView.callBackBlock = ^(id sender) {
        [weakself pushWhereVC:sender];
    };
    //切换账号后，重写请求数据，刷新界面UI
    ADD_NOTI(requstRereshInfor, CHANGER_ACCOUNT_UPDATE_MAIN_REREQUESTDATA_TOUPDATEMAINPAGEUI_NOTI);
    /** 修改手机号成功后刷新数据 */
    ADD_NOTI(changePhone:, CHANGE_ACCOUNT_PHONE_SUCCESS_KEY);
}
#pragma mark - Sixth.界面配置
- (void)setUI{
    
    [self.MainScrollView addSubview:self.mineMainView];
    self.MainScrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - TABBAR_HIEGHT);
    [self.view addSubview:self.MainScrollView];
    [self.mineMainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.MainScrollView);
        make.width.mas_offset(SCREEN_WIDTH);
    }];
    self.MainScrollView.showsVerticalScrollIndicator = NO;
    self.MainScrollView.backgroundColor = HYCOLOR.color_c1;
    WEAKSELF(self);
    
    self.MainScrollView.mj_header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        [weakself requstRereshInfor];
    }];
}

#pragma mark - Seventh.懒加载
- (HYMineMainView*)mineMainView
{
    if (!_mineMainView) {
        _mineMainView = [[HYMineMainView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
//        _mineMainView.viewController = self;
    }
    return _mineMainView;
}

#pragma mark - Eigth.Other
-(void)dealloc
{
    REMOVIE_NOTI(APP_BECOMEACTIVE_UPDATE_ACCOUNTINFOR_NOTI);
    REMOVIE_NOTI(CHANGER_ACCOUNT_UPDATE_MAIN_REREQUESTDATA_TOUPDATEMAINPAGEUI_NOTI);
    REMOVIE_NOTI(CHANGE_ACCOUNT_PHONE_SUCCESS_KEY);
}

@end
