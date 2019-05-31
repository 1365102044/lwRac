//
//  HYBaseViewController.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/5/18.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYBaseViewController.h"
#import "HYLeftRightArrowView.h"
#import "HYTopBarView.h"
#import "HYAttributedStringLabel.h"
#import "LWTFHandler.h"
//#import <FBRetainCycleDetector/FBRetainCycleDetector.h>

@interface HYBaseViewController ()

@end

@implementation HYBaseViewController


#pragma mark - First.通知

#pragma mark - Second.赋值

- (void)requestListInfor
{
    [self.dataMutableArray removeAllObjects];
}

#pragma mark - Third.点击事件
- (void)tempViewButtonClick:(UIButton *)sender
{
    
}

#pragma mark - Fourth.代理方法

#pragma mark -UIGestureRecognizerDelegate
-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return _closePopGesture ? NO : YES;
}

#pragma mark - Fifth.视图生命周期

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (_closePopGesture) {
        if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
            self.navigationController.interactivePopGestureRecognizer.delegate = self;
        }
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (_closePopGesture) {
        if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
            self.navigationController.interactivePopGestureRecognizer.delegate = self.restoreInteractivePopGestureDelegate;
        };
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = HYCOLOR.color_c0;;
    MARGIN = ADJUST_PERCENT_FLOAT(10);
    
    
//    FBRetainCycleDetector *detector = [FBRetainCycleDetector new];
//    [detector addCandidate:self];
//    NSSet *retainCycles = [detector findRetainCycles];
//    NSLog(@"%@", retainCycles);
    
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        if (@available(iOS 11.0, *)) {
            self.MainScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = false;
        }
    }
    return self;
}
#pragma mark - Sixth.界面配置

#pragma mark - Seventh.懒加载
- (HYBaseScrollView*)MainScrollView
{
    if (!_MainScrollView) {
        _MainScrollView = [[HYBaseScrollView alloc] init];
         _MainScrollView.backgroundColor = HYCOLOR.color_c1;
    }
    return _MainScrollView;
}

- (NSMutableArray*)dataMutableArray
{
    if (!_dataMutableArray) {
        _dataMutableArray = [[NSMutableArray alloc] init];
    }
    return _dataMutableArray;
}

-(void)dealloc
{
    LWLog(@"\n********dealloc:%@\n",self.className);
    [LWTFHandler removeHandlerCacheWithViewController:self];
}

@end