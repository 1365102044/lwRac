//
//  HYHouseRescourceDeatiMainView.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/11.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYHouseRescourceDeatiMainView.h"
#import "HYTopInforView.h"
#import "HYContactUsView.h"
#import "HYJiChuSheShiView.h"
#import "HYHuXingView.h"
#import "HYZhouBianView.h"

@interface HYHouseRescourceDeatiMainView ()
@property (nonatomic, strong) UIImageView * houseImageView;
@property (nonatomic, strong) HYTopInforView * topInforView;
@property (nonatomic, strong) HYContactUsView * contactUsView;
@property (nonatomic, strong) HYJiChuSheShiView * jichusheshiView;
@property (nonatomic, strong) HYHuXingView * huxingView;
@property (nonatomic, strong) HYZhouBianView * zhoubianView;

@end
@implementation HYHouseRescourceDeatiMainView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = HYCOLOR.color_c1;
        [self setSubUI];
    }
    return self;
}

- (void)setSubUI
{
    
    _houseImageView = [[UIImageView alloc] init];
    _topInforView = [[HYTopInforView alloc] init];
    _contactUsView = [[HYContactUsView alloc] init];
    _jichusheshiView = [[HYJiChuSheShiView alloc] init];
    _huxingView = [[HYHuXingView alloc] init];
    _zhoubianView = [[HYZhouBianView alloc] init];
    [self addSubview:_topInforView];
    [self addSubview:_contactUsView];
    [self addSubview:_houseImageView];
    [self addSubview:_jichusheshiView];
    [self addSubview:_huxingView];
    [self addSubview:_zhoubianView];
    [_houseImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.top.mas_equalTo(self.mas_top).mas_offset(NAVIGATOR_HEIGHT);
        make.height.mas_offset(MARGIN*20);
    }];
    [_topInforView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_houseImageView.mas_bottom).mas_offset(MARGIN);
        make.left.mas_equalTo(self.mas_left).mas_offset(MARGIN);
        make.right.mas_equalTo(self.mas_right).mas_offset(-MARGIN);
    }];
    [_contactUsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_topInforView.mas_bottom).mas_offset(MARGIN);
        make.left.mas_equalTo(self.mas_left).mas_offset(MARGIN);
        make.right.mas_equalTo(self.mas_right).mas_offset(-MARGIN);
    }];
    [_jichusheshiView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_contactUsView.mas_bottom).mas_offset(MARGIN);
        make.left.mas_equalTo(self.mas_left).mas_offset(MARGIN);
        make.right.mas_equalTo(self.mas_right).mas_offset(-MARGIN);
//        make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-MARGIN);
    }];
    [_huxingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_jichusheshiView.mas_bottom).mas_offset(MARGIN);
        make.left.mas_equalTo(self.mas_left).mas_offset(MARGIN);
        make.right.mas_equalTo(self.mas_right).mas_offset(-MARGIN);
        make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-MARGIN);
    }];
    _houseImageView.image = IMAGENAME(@"11");
    [_topInforView setBoundWidth:0.5 cornerRadius:6 boardColor:HYCOLOR.color_c4];
    [_contactUsView setBoundWidth:0.5 cornerRadius:6 boardColor:HYCOLOR.color_c4];
    [_jichusheshiView setBoundWidth:0.5 cornerRadius:6 boardColor:HYCOLOR.color_c4];
    [_huxingView setBoundWidth:0.5 cornerRadius:6 boardColor:HYCOLOR.color_c4];
    
    [_huxingView.moreLable bk_whenTapped:^{
        ALERT_MSG(@"更多开发中...");
    }];
    [self setTestData];
}


- (void)setTestData
{
    _topInforView.titileLable.text = @"北京牡丹园店";
    _topInforView.baozhangLable.text = @"保障“100%真实房源";
    _topInforView.yongjinLable.text = @"佣金：100%免佣金";
    
    _contactUsView.kefuPhoneLable.text = @"客服电话：18801040890";
    _contactUsView.addressLable.text  = @"北京市海淀区牡丹园";
    NSArray * dataArr = @[@{@"title":@"账单",@"image":@"mine_bill_n"},
                          @{@"title":@"合同",@"image":@"mine_hetong_n"},
                          @{@"title":@"保修",@"image":@"mine_baoxiu_n"},
                          @{@"title":@"保洁",@"image":@"mine_baojie_n"},
                          @{@"title":@"水表",@"image":@"mine_shuibiao_n"},
                          @{@"title":@"电表",@"image":@"mine_dianbiao_n"},
                          @{@"title":@"智能门锁",@"image":@"mine_mensuo_n"},
                          @{@"title":@"缴费",@"image":@"mine_pay_n"},
                          @{@"title":@"我的预约",@"image":@"mine_yuyue_n"},
                          @{@"title":@"我的预定",@"image":@"mine_yuding_n"},
                          @{@"title":@"我的优惠券",@"image":@"mine_youhuiquan_n"},
                          @{@"title":@"我的活动",@"image":@"mine_huodong_n"},
                          @{@"title":@"我的收藏",@"image":@"mine_collection_n"},
                          @{@"title":@"我的积分",@"image":@"mine_jifen_n"},];
    _jichusheshiView.jiugonggeView.dataArr = dataArr;
    
}
@end
