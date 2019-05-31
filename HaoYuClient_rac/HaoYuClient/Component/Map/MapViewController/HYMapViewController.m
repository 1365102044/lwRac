//
//  HYMapViewController.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/7/18.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYMapViewController.h"
#import "HYMapView.h"
#import "HYMapNavigation.h"
#import "HYBaseBarButtonItem.h"
@interface HYMapViewController ()
@property (nonatomic, strong) HYMapView * mapView;
@property (nonatomic, strong) HYMapNavigation * mapNavi;
@property (nonatomic, strong) HYLocationTool * locationTool;
@end

@implementation HYMapViewController

#pragma mark - First.通知

#pragma mark - Second.网络请求

#pragma mark - Third.点击事件

#pragma mark - Fourth.代理方法

#pragma mark - Fifth.视图生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"地图";
    
    [self setUI];
}

- (void)setUI
{
    [self.view addSubview:self.mapView];
    [self.mapView addPointViewWithlat:_locationCoordinate.latitude lng:_locationCoordinate.longitude];
    self.mapView.myMapView.zoomLevel = 16;
    
    //    HYDefaultButton *naviBtn = [HYDefaultButton buttonWithTitleStringKey:@"导航" titleColor:HYCOLOR.color_c0 titleFont:SYSTEM_REGULARFONT(15) target:self selector:@selector(startNavi)];
    //    naviBtn.backgroundColor = [UIColor darkGrayColor];
    //    naviBtn.alpha = 0.5;
    //    [self.view addSubview:naviBtn];
    //    [naviBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.size.mas_offset(CGSizeMake(MARGIN*70, MARGIN*3));
    //        make.top.mas_equalTo(self.view.mas_top).mas_offset(MARGIN*2);
    //        make.right.mas_equalTo(self.view.mas_right).mas_offset(-MARGIN*2);
    //    }];
    
    WEAKSELF(self);
    HYBaseBarButtonItem *rightiem = [HYBaseBarButtonItem barButtonItemWithTitleStringKey:@"开始导航"
                                                                                callBack:^(id sender) {
                                                                                    [weakself startNavi];
                                                                                }];
    self.navigationItem.rightBarButtonItem = rightiem;
}

- (void)startNavi
{
    if (![HYPublic_LocalData share].isSucessLoaction) {
        [HYWraingAlert showAlert:self
                           title:@"提示"
                         message:@"未获取到您的位置，请确认你是否开启了定位权限"
               cancelButtonTitle:@"知道了"
       cancelButtonCallBackBlock:^(id sender) {}];
        return;
    }
    
    [self.mapNavi startNavigationWith:_locationCoordinate currentVC:self];
}

-  (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (![HYPublic_LocalData share].isSucessLoaction) {
        /**
         开始定位
         */
        [self.locationTool initLocation];
    }
    
    [self setUI];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.mapView.myMapView viewWillDisappear];
    self.mapView.myMapView.delegate = nil;
    [self.mapView removeFromSuperview];
}

#pragma mark - Sixth.界面配置

#pragma mark - Seventh.懒加载

- (HYMapView*)mapView
{
    if (!_mapView) {
        _mapView = [[HYMapView alloc] initWithFrame:self.view.bounds];
    }
    return _mapView;
}
- (HYMapNavigation*)mapNavi
{
    if (!_mapNavi) {
        _mapNavi = [[HYMapNavigation alloc] init];
    }
    return _mapNavi;
}

/**
 定位工具类
 */
- (HYLocationTool*)locationTool
{
    if (!_locationTool) {
        _locationTool = [[HYLocationTool alloc] init];
        WEAKSELF(self);
        _locationTool.LoactionCoordinate2DBlock = ^(CLLocationCoordinate2D coor) {
            weakself.locationCoordinate = coor;
        };
    }
    return _locationTool;
}

#pragma mark - Eigth.Other

@end