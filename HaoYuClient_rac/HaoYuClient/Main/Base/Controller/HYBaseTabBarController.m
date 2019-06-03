//
//  HYBaseTabBarController.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/5/18.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYBaseTabBarController.h"
#import "HYBaseNavigationController.h"
#import "HYHomeViewController.h"
#import "HYHouseRescourcesViewController.h"
#import "HYMineViewController.h"
#import "HYDiscoverViewController.h"
#import "HYUserInfor_LocalData.h"
#import "ViewController.h"
#import "LWLoginViewController.h"

@interface HYBaseTabBarController ()<UITabBarControllerDelegate>
@property(readonly,nonatomic) NSUInteger currentSelectIndex;
@property(readonly, nonatomic) NSUInteger lastSelectedIndex;

@property (nonatomic, strong) NSMutableArray * tabbarItemButtonMutableArray;

@end

@implementation HYBaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
    [UITabBar appearance].translucent = NO;
    self.tabBar.backgroundColor = [UIColor whiteColor];
    
    [self addSubControllerWithTitleKey:@"首页" imageNamed:@"home_home" viewController:[[HYHomeViewController alloc] init]];
    [self addSubControllerWithTitleKey:@"房源" imageNamed:@"home_idle" viewController:[HYHouseRescourcesViewController houseRescourcesViewControllerWithDataModel:nil extend:nil]];
    [self addSubControllerWithTitleKey:@"发现" imageNamed:@"home_finder" viewController:[[HYDiscoverViewController alloc] init]];
    [self addSubControllerWithTitleKey:@"我的" imageNamed:@"home_mine" viewController:[[HYMineViewController alloc] init]];
    
    /**
     监听到登录成功 切换tabbarindex
     */
    ADD_NOTI(pushToTabbarIndex:, CHANGETABBAR_INDEX_KEY);
    
    
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    for (UIView *viewitem in self.tabBar.subviews) {
        if ([viewitem isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            if (![self.tabbarItemButtonMutableArray containsObject:viewitem]) {
              [self.tabbarItemButtonMutableArray addObject:viewitem];
            }
        }
    }
}

- (void)pushToTabbarIndex:(NSNotification *)noti
{
    if ([noti.object isKindOfClass:[NSDictionary class]]) {
        NSDictionary *info = noti.object;
        NSInteger index = [info[@"lastIndex"] integerValue];
        if (index == 100) {
            self.selectedIndex = index;
        }
    }else{
        NSInteger index = [noti.object integerValue];
        if(index == 3){
            HYBaseNavigationController *baseNavi = self.childViewControllers[index];
            HYBaseViewController *baseVC = baseNavi.childViewControllers.firstObject;
            [baseVC.navigationController setNavigationBarHidden:YES animated:YES];
        }
        self.selectedIndex = index;
    }
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    //获得选中的item
    NSUInteger tabIndex = [tabBar.items indexOfObject:item];
    _currentSelectIndex = tabIndex;
    if (tabIndex != self.selectedIndex) {
        //设置最近一次变更
        _lastSelectedIndex = self.selectedIndex;
    
        [self animationForTabbarItemWithindex:_currentSelectIndex];
    }
    
}


/**
 点击动画

 @param index 当前选中的index
 */
- (void)animationForTabbarItemWithindex:(NSInteger)index
{
    //放大效果，并回到原位
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    //速度控制函数，控制动画运行的节奏
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.duration = 0.2;       //执行时间
    animation.repeatCount = 1;      //执行次数
    animation.autoreverses = YES;    //完成动画后会回到执行动画之前的状态
    animation.fromValue = [NSNumber numberWithFloat:0.7];   //初始伸缩倍数
    animation.toValue = [NSNumber numberWithFloat:1.3];     //结束伸缩倍数
    [[_tabbarItemButtonMutableArray[index] layer] addAnimation:animation forKey:nil];
}

/**
 添加子控制器c
 @param titleKey                titleStringKey
 @param imageNamed              图片名称
 @param viewController          子控制器
 */
- (void)addSubControllerWithTitleKey:(NSString *)titleKey
                          imageNamed:(NSString *)imageNamed
                      viewController:(HYBaseViewController *)viewController
{
    HYBaseNavigationController *navigationController            = [[HYBaseNavigationController alloc]initWithRootViewController:viewController];
    navigationController.tabBarItem.title                       = titleKey;
    UIImage *imageNor                                           = [UIImage imageNamed:[NSString stringWithFormat:@"%@_n",imageNamed]];
    UIImage *imageHig                                           = [UIImage imageNamed:[NSString stringWithFormat:@"%@_h",imageNamed]];
    imageNor                                                    = [imageNor imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    imageHig                                                    = [imageHig imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    navigationController.tabBarItem.image                       = imageNor;
    navigationController.tabBarItem.selectedImage               = imageHig;
    [navigationController.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -2)];
    navigationController.tabBarItem.imageInsets = UIEdgeInsetsMake(1, 0, -1, 0);
    [self addChildViewController:navigationController];
}

/*
 @brief 进入个人中心的时候 登录的判断
 */
-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    if (_currentSelectIndex == 3) {
        if(![[HYUserInfor_LocalData share] isLogin]){
            LWLoginViewController *loginVC = [[LWLoginViewController alloc] init];
            loginVC.sourceTabbarIndex = 3;
            HYBaseNavigationController *navi = [[HYBaseNavigationController alloc] initWithRootViewController:loginVC];
            [self presentViewController:navi animated:YES completion:nil];
            return NO;
        }
    }
    return YES;
}
/**
 初始化TabBar控制器
 
 @return TabBar控制器
 */
- (instancetype)init
{
    if (self = [super init]) {
        
        /**
         *  配置样式
         */
        [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:HYCOLOR.color_c4,
                                                            NSFontAttributeName:SYSTEM_REGULARFONT(10.f)}
                                                 forState:UIControlStateNormal];
        [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:HYCOLOR.color_c3,
                                                            NSFontAttributeName:SYSTEM_REGULARFONT(10.f)}
                                                 forState:UIControlStateSelected];
        
    }
    return self;
}


- (NSMutableArray*)tabbarItemButtonMutableArray
{
    if (!_tabbarItemButtonMutableArray) {
        _tabbarItemButtonMutableArray = [[NSMutableArray alloc] init];
    }
    return _tabbarItemButtonMutableArray;
}
@end
