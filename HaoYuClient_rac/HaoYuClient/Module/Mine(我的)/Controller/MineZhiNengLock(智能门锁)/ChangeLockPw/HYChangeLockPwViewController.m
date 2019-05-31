//
//  HYChangeLockPwViewController.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/8.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYChangeLockPwViewController.h"
#import "HYChangeLockPwMainView.h"
#import "HYChangePwView.h"
#import "HYLockModel.h"
#import "HYAlertCentersView.h"
#import "HYAlertCenterView.h"
@interface HYChangeLockPwViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) HYChangeLockPwMainView * mainView;
@property (nonatomic, strong) HYChangePwView * changePwView;
@property (nonatomic, strong) HYLockModel * lockMesgModel;
@property (nonatomic, assign) BOOL isRequestScuccess;
@property (nonatomic, strong) NSMutableDictionary * lockInforDict;
@property (nonatomic, strong) UIPageControl * pageControl;

@end

@implementation HYChangeLockPwViewController

#pragma mark - First.通知

#pragma mark - Second.网络请求
/**
 请求验证码
 */
- (void)rquestCode {
    PARA_CREART;
    PARA_SET([USERDEFAULTS_GET(USER_INFOR_PHONE) isNullToString], @"phone");
    PARA_SET([_heTongModel.houseId isNullToString], @"houseId");
    [[HYServiceManager share] postRequestAnWithurl:CHANGE_MYLOCKPW_SENDCODE_URL
                                         paramters:para
                                      successBlock:^(id objc, id requestInfo) {
                                          LWLog(@"\n-----------\n\nrequestcode:%@",objc);
                                          [self.changePwView startTimer];
                                      }failureBlock:^(id error, id requestInfo) {
                                          
                                      }];
}
/**
 修改密码
 */
- (void)commitInfo:(NSDictionary *)param
{
    PARA_CREART;
    PARA_SET([HYStringTool checkString:USERDEFAULTS_GET(USER_INFOR_PHONE)], @"userphone");
    PARA_SET([HYStringTool checkString:_lockMesgModel.lockid], @"lockid");
//    PARA_SET(@"11.135.83.148", @"lockid");
    PARA_SET([HYStringTool checkString:_lockMesgModel.lockType], @"lockType");
    [para addEntriesFromDictionary:param];
    LWLog(@"------%@",para);
    [[HYServiceManager share] postRequestAnWithurl:CHANGE_MYLOCKPW_URL
                                         paramters:para
                                      successBlock:^(id objc, id requestInfo) {
                                          NSString *status_code = objc[@"status"][@"code"];
                                          if ([status_code integerValue] == 200) {
                                              ALERT(@"密码修改成功！");
                                              [self.navigationController popViewControllerAnimated:YES];
                                          }
                                      } failureBlock:^(id error, id requestInfo) {
                                      
                                      }];
}

/**
 开锁界面信息
 */
- (void)requestMyLockInfor
{
    PARA_CREART;
    PARA_SET([_heTongModel.houseId isNullToString], @"houseId");
    PARA_SET([_heTongModel.chengzuId isNullToString], @"chengzuId");
    PARA_SET([_heTongModel.zukePhone isNullToString], @"userphone");
    PARA_SET([_heTongModel.parentHouseId isNullToString], @"parentId");
    [[HYServiceManager share] postRequestAnWithurl:GET_MINELOCKMESSAGE_INFOR_URL
                                         paramters:para
                                      successBlock:^(id objc, id requestInfo) {
                                          LWLog(@"-------\n\n\nmensuo_infor:%@",objc);
                                          _isRequestScuccess = YES;
                                          if ([objc[@"result"] isKindOfClass:[NSString class]]) {
                                              NSString *msg = objc[@"status"][@"msg"];
                                              if (msg) {
                                                  [HYWraingAlert showAlert:self
                                                                     title:@"提示"
                                                                   message:msg ? msg : @""
                                                         cancelButtonTitle:@"确定" cancelButtonCallBackBlock:^(id sender) {
                                                             [self.navigationController popViewControllerAnimated:YES];
                                                         }];
                                                  return ;
                                              }
                                          }
                                          NSDictionary *reslust = objc[@"result"];
                                          if ([reslust isKindOfClass:[NSDictionary class]]) {
                                              if (reslust[@"islock"] != nil &&
                                                  [reslust[@"islock"] isEqualToString:@"0"]) {
                                                  [HYWraingAlert showAlert:self
                                                                     title:@"提示"
                                                                   message:@"该合同没有查询到门锁信息"
                                                         cancelButtonTitle:@"确定" cancelButtonCallBackBlock:^(id sender) {
                                                             [self.navigationController popViewControllerAnimated:YES];
                                                         }];
                                                  return;
                                              }
                                              NSArray *list = objc[@"result"][@"list"];
                                              if ([list isKindOfClass:[NSArray class]]) {
                                                  for (int i = 0;i<list.count;i++) {
                                                      HYLockModel *model  = [HYLockModel modelWithJSON:list[i]];
                                                      if (model.parenthousrid) {
                                                          [self.lockInforDict setValue:model forKey:@(0)];
                                                          _lockMesgModel = model;
                                                      }
                                                      if (model.houseid) {
                                                          [self.lockInforDict setValue:model forKey:@(1)];
                                                      }
                                                  }
                                                  [self updateScrollViewSubviews];
                                              }
                                          }
                                          
                                      } failureBlock:^(id error, id requestInfo) {
                                        _isRequestScuccess = YES;
                                      }];
}

/**
 根据 数据 添加视图
 */
- (void)updateScrollViewSubviews
{
    for (int i = 0; i < self.lockInforDict.allKeys.count; i++) {
        HYLockModel *model = self.lockInforDict[@(i)];
        HYChangeLockPwMainView *mainview  = [[HYChangeLockPwMainView alloc] init];
        [self.MainScrollView addSubview:mainview];
        [mainview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.MainScrollView);
            make.width.mas_offset(SCREEN_WIDTH);
            make.height.equalTo(self.MainScrollView.mas_height);
            make.left.equalTo(self.MainScrollView.mas_left).offset(SCREEN_WIDTH*i);
        }];
        mainview.lockMesgModel = model;
        mainview.tag = i+10;
        mainview.alerName.hidden = (self.lockInforDict.allKeys.count <= 1);
        WEAKSELF(self);
        mainview.callBlock = ^(id sender) {
            if (!weakself.isRequestScuccess) {
                return ;
            }
            UIButton *btn = (UIButton *)sender;
            if ([btn.titleLabel.text isEqualToString:@"修改密码"]) {
                [weakself ClickChangePWBtnWithTag:btn.tag];
            }else if ([btn.titleLabel.text isEqualToString:@"远程开锁"]){
                [weakself clickRemoteOpenDoorWithTag:btn.tag];
            }
        };
    }
    /** 解决不能更新contensize的问题 */
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.MainScrollView.contentSize = CGSizeMake(SCREEN_WIDTH*self.lockInforDict.allKeys.count, 1);
        _pageControl.numberOfPages = self.lockInforDict.allKeys.count;
    });
    self.MainScrollView.pagingEnabled = YES;
    if (self.lockInforDict.allKeys.count>1) {
        _pageControl.hidden = NO;
    }
}

/** 修改密码， 根据tag 判断是哪个锁（tag-10） */
- (void)ClickChangePWBtnWithTag:(NSInteger)tag
{
    HYChangeLockPwViewController *temp = [[HYChangeLockPwViewController alloc] init];
    temp.sourceVC = self;
    temp.heTongModel = self.heTongModel;
    [self.navigationController pushViewController:temp animated:YES];
}

/** 远程开锁， 根据tag 判断是哪个锁（tag-10） */
- (void)clickRemoteOpenDoorWithTag:(NSInteger)tag
{
    [HYWraingAlert showAlert:self
                       title:@""
                     message:[NSString stringWithFormat:@"确定对“%@”进行远程开锁吗？",self.lockMesgModel.fullAdress]
          defaultButtonTitle:@"取消"
           cancelButtonTitle:@"确认"
  defaultButtonCallBackBlock:^(id sender) {
      
  }cancelButtonCallBackBlock:^(id sender) {
      NSString *houseid = _lockMesgModel.houseid;
      if (_lockMesgModel.parenthousrid) {
          houseid = _lockMesgModel.parenthousrid;
      }
      [self requestRemoterUnLock:houseid];
  }];
}

/**
 远程开锁
 */
- (void)requestRemoterUnLock:(NSString *)houseid
{
    PARA_CREART;
    PARA_SET([houseid isNullToString], @"houseId");
    PARA_SET([USERDEFAULTS_GET(USER_INFOR_PHONE) isNullToString], @"userPhone");
    PARA_SET([_lockMesgModel.lockid isNullToString], @"lockId");
    PARA_SET([_lockMesgModel.lockType isNullToString], @"lockType");
    [[HYServiceManager share] postRequestAnWithurl:GET_REMOTERUNLOCK_URL
                                         paramters:para
                                      successBlock:^(id objc, id requestInfo) {
                                          NSString *status = objc[@"status"][@"code"];
                                          if ([status isEqualToString:@"200"]) {
                                              ALERT(@"开锁成功！");
                                          }else if ([status isEqualToString:@"201"]){
                                              //欠租
                                              ALERT(@"已欠租！");
                                          }
                                      } failureBlock:^(id error, id requestInfo) {
                                          
                                      }];
}

#pragma mark - Third.点击事件

#pragma mark - Fourth.代理方法

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint point = scrollView.contentOffset;
    NSInteger index = point.x/SCREEN_WIDTH;
    _pageControl.currentPage = index;
    _lockMesgModel = _lockInforDict[@(index)];
}

#pragma mark - Fifth.视图生命周期
+ (instancetype)creatChangeLockPwViewController:(NSString *)titleStr heTongModel:(HYContractModel *)heTongModel
{
    HYChangeLockPwViewController *instance = [[HYChangeLockPwViewController alloc] init];
    instance.heTongModel = heTongModel;
    return instance;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"智能门锁";
    _isRequestScuccess = NO;
    if ([self.sourceVC isKindOfClass:[HYChangeLockPwViewController class]]) {
        self.title = @"修改密码";
        [self setChangeUI];
    }else{
        [self setMainUI];
    }
    [self requestMyLockInfor];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[HYTimerManager shareTimer] stopTimer];
}
#pragma mark - Sixth.界面配置
- (void)setChangeUI{
    [self.view addSubview:self.changePwView];
    [self.changePwView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    WEAKSELF(self);
    self.changePwView.callBlock = ^(id sender) {
        [weakself commitInfo:sender];
    };
    self.changePwView.getCodeBlock = ^{
        [weakself rquestCode];
    };
}

- (void)setMainUI
{
    [self.view addSubview:self.MainScrollView];
    self.MainScrollView.delegate = self;
    [self.MainScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    self.MainScrollView.pagingEnabled = YES;
    self.MainScrollView.showsHorizontalScrollIndicator = NO;
    self.MainScrollView.showsVerticalScrollIndicator = NO;
    _pageControl = [[UIPageControl alloc] init];
    [self.view addSubview:_pageControl];
    _pageControl.currentPage = 0;
    [_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(-15);
    }];
    _pageControl.pageIndicatorTintColor = HYCOLOR.color_c1;
    _pageControl.currentPageIndicatorTintColor = HYCOLOR.color_c3;
    _pageControl.hidden = YES;
}

#pragma mark - Seventh.懒加载

- (HYChangePwView*)changePwView
{
    if (!_changePwView) {
        _changePwView = [[HYChangePwView alloc] init];
    }
    return _changePwView;
}

- (NSMutableDictionary*)lockInforDict
{
    if (!_lockInforDict) {
        _lockInforDict = [[NSMutableDictionary alloc] init];
    }
    return _lockInforDict;
}
#pragma mark - Eigth.Other


@end
