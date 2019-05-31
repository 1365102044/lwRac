//
//  YBNewVersionFeaturesViewController.m
//  inborn
//
//  Created by 刘文强 on 2017/12/7.
//  Copyright © 2017年 inborn. All rights reserved.
//

#import "YBNewVersionFeaturesViewController.h"
#import "HYBaseTabBarController.h"

@interface YBNewVersionFeaturesViewController ()<UIScrollViewDelegate>
/**
 内容容器
 */
@property(nonatomic,strong) UIScrollView * contenScrollView;
@property(nonatomic,strong) NSArray * imagesArr;
@property(nonatomic,strong) UIPageControl *pageControl;
@property (nonatomic, strong) UIImageView * laseImageView;
@property (nonatomic, strong) HYBorderLongButton * gotoBtn;

@end

@implementation YBNewVersionFeaturesViewController

#pragma mark - First.通知

#pragma mark - Second.赋值

#pragma mark - Third.点击事件

#pragma mark - Fourth.代理方法

#pragma mark - Fifth.控制器生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (iPhoneX) {
        self.imagesArr = @[@"versionx_1",
                           @"versionx_2",
                           @"versionx_3",
                           @"versionx_4"];
    }else{
        self.imagesArr = @[@"version_1",
                           @"version_2",
                           @"version_3",
                           @"version_4"];
    }
    [self setScrollView];
//    [self setupPageControl];
    [self setBottomBtn];
    [[HYPublic_LocalData share] saveCurrentVersionNumber];
    
}

- (void)setBottomBtn
{
    HYBorderLongButton *btn = [HYBorderLongButton buttonWithTitleStringKey:@"立即体验" titleColor:UIColor.blackColor borderColor:UIColor.redColor backColor:UIColor.clearColor target:self selector:@selector(gotoMain)];
    [self.view addSubview:btn];
    [self.view bringSubviewToFront:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH*0.6, MARGIN*4));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.bottom.mas_equalTo(self.view.mas_bottom).mas_offset(-((iPhoneX)? MARGIN* 12.5 : MARGIN*8.5));
    }];
    _gotoBtn  = btn;
    self.gotoBtn.hidden = YES;
    [btn setBoundWidth:1 cornerRadius:ADJUST_PERCENT_FLOAT(40)/2 boardColor:[UIColor redColor]];
}

- (void)setScrollView
{
    [self.view addSubview:self.contenScrollView];
    self.contenScrollView.contentSize  = CGSizeMake(SCREEN_WIDTH * _imagesArr.count, SCREEN_HEIGHT);
    if (_imagesArr.count > 0){
        for (int i=0; i < _imagesArr.count; i++) {
            UIImageView *imageview = [[UIImageView alloc]init];
            imageview.image = [UIImage imageNamed:_imagesArr[i]];
            [self.contenScrollView addSubview:imageview];
            [imageview mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_offset(CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT));
                make.left.mas_equalTo(self.contenScrollView.mas_left).mas_offset(SCREEN_WIDTH *i);
                make.top.mas_equalTo(self.contenScrollView);
            }];
            if (i == _imagesArr.count-1) {
                self.laseImageView = imageview;
                imageview.userInteractionEnabled = YES;
                WEAKSELF(self);
                UITapGestureRecognizer *Tap = [[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
                    [weakself gotoMain];
                }];
                [imageview addGestureRecognizer:Tap];
            }
        }
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger index =  scrollView.contentOffset.x / SCREEN_WIDTH + 0.5;
//    self.pageControl.currentPage = index;
    
//    CGFloat offsetX = scrollView.contentOffset.x;
//    if (offsetX >= (_imagesArr.count - 1) * SCREEN_WIDTH + 80) {
//        [self gotoMain];
//    }
    if (index == self.imagesArr.count -1) {
        self.gotoBtn.hidden = NO;
    }else{
        self.gotoBtn.hidden = YES;
    }
}

-(void)setupPageControl
{
    UIPageControl *pageControl = [[UIPageControl alloc]init];
    pageControl.centerX = self.view.width * 0.5;
    pageControl.ex_y = SCREEN_HEIGHT - ADJUST_PERCENT_FLOAT(30);
    pageControl.numberOfPages = _imagesArr.count;
    pageControl.currentPageIndicatorTintColor = HYCOLOR.color_c2;
    pageControl.pageIndicatorTintColor = HYCOLOR.color_c3;
    [self.view addSubview:pageControl];
    self.pageControl = pageControl;
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)gotoMain
{
//    [UIView animateWithDuration:.25 animations:^{
//        self.laseImageView.transform = CGAffineTransformMakeScale(3, 3);
//        LWLog(@"\n1+++++++++++++%@+++++%@",[NSDate date],[NSThread currentThread]);
//    } completion:^(BOOL finished) {
//        LWLog(@"\n2+++++++++++++%@+++++%@",[NSDate date],[NSThread currentThread]);
//    }];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    HYBaseTabBarController *tabBarController    = [[HYBaseTabBarController alloc] init];
    [window setRootViewController:tabBarController];
    [window makeKeyAndVisible];
    [self.laseImageView removeFromSuperview];
}

#pragma mark - Sixth.界面配置

#pragma mark - Seventh.懒加载

- (UIScrollView *)contenScrollView {
    if (!_contenScrollView) {
        _contenScrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
        _contenScrollView.delegate = self;
        _contenScrollView.showsHorizontalScrollIndicator = NO;
        _contenScrollView.showsVerticalScrollIndicator = NO;
        _contenScrollView.pagingEnabled = YES;
    }
    return _contenScrollView;
}
@end
