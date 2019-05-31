//
//  HYHuXingDeatilMainView.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/12.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYHuXingDeatilMainView.h"
#import "HYHuXingFangJianInforView.h"
#import "HYHuXingPicView.h"
#import "HYHuXingJianJieView.h"
#import "HYHuXingBaoZhangView.h"
#import "HYJiChuSheShiView.h"

@interface  HYHuXingDeatilMainView ()
@property (nonatomic, strong) HYBaseView * imageBgView;
@property (nonatomic, strong) HYHuXingFangJianInforView * FangJianInforView;
//@property (nonatomic, strong) HYHuXingPicView * HuXingPicView;
@property (nonatomic, strong) HYJiChuSheShiView * jichusheshiView;
@property (nonatomic, strong) HYHuXingJianJieView * HuXingJianJieView;
@property (nonatomic, strong) HYHuXingBaoZhangView * BaoZhangView;
@end

@implementation HYHuXingDeatilMainView

- (void)setHuxingInforModel:(HYHuXingInforModel *)huxingInforModel
{
    _huxingInforModel = huxingInforModel;
    _topInforView.titileLable.text = huxingInforModel.roomTypeName;
    _topInforView.baozhangLable.text = [NSString stringWithFormat:@"%@室%@厅",huxingInforModel.shi,huxingInforModel.ting];
    _topInforView.yongjinLable.text = @" 户型灵活，卧室宽敞";
    
    _topInforView.priceLable.text = [self getPriceStr:huxingInforModel.iosMinZujin max:huxingInforModel.iosMaxZujin];
    
    //房间信息
    NSString *mianji = [NSString stringWithFormat:@"%@㎡",huxingInforModel.iosRoomTypeArea];
    NSArray * dataArr = @[@{@"title":[HYStringTool checkString:huxingInforModel.huxingModel.key],
                            @"image":@"hezuicon"},
                          @{@"title":[HYStringTool checkString:huxingInforModel.zhuangXiuModel.key],
                            @"image":@"zhuangxiuicon"},
                          @{@"title":mianji ? mianji : @"",
                            @"image":@"mianjiicon"}];
    _FangJianInforView.jiugonggeView.dataArr = dataArr;
    
    
    //房间配置
    NSArray *roomTypePeizhi_arr = huxingInforModel.roomTypePeizhi;
    NSMutableArray *tem_arr = [NSMutableArray array];
    for (NSDictionary *dict in roomTypePeizhi_arr) {
        NSMutableDictionary *tem_dict = [[NSMutableDictionary alloc] init];
        tem_dict[@"title"] = dict[@"peizhi"];
        tem_dict[@"image"] = [self getIconNameWithPeiZhi:dict[@"peizhi"]];
        [tem_arr addObject:tem_dict];
    }
    _jichusheshiView.jiugonggeView.dataArr = tem_arr;
    
    //房型简介
    [_HuXingJianJieView.contentLable setAttributedStringWithContentArray:@[@{@"color" : HYCOLOR.color_c4,
                                                                             @"content" : huxingInforModel.roomTypeIntro ? huxingInforModel.roomTypeIntro : @"",
                                                                             @"size" : SYSTEM_REGULARFONT(13),
                                                                             @"lineSpacing": @5},]];
    
    //保障
    _BaoZhangView.baozhangLable.text = @"100%真实房源";
    _BaoZhangView.yongjinLable.text = @"100%免佣金";
    
    if ([huxingInforModel.collectionStatus isEqualToString:@"1"]) {
        self.topInforView.collectBtn.selected = YES;
    }else{
        self.topInforView.collectBtn.selected = NO;
    }
}


- (void)clickCollectBtn:(UIButton *)sender
{
    if(self.callBackBlock){
        self.callBackBlock(sender.selected ? @"1" : @"0");
    }
}

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
    _topInforView = [[HYHuXingTopInforView alloc] init];
    _FangJianInforView = [[HYHuXingFangJianInforView alloc] init];
    //    _HuXingPicView = [[HYHuXingPicView alloc] init];
    _jichusheshiView = [[HYJiChuSheShiView alloc] init];
    _HuXingJianJieView = [[HYHuXingJianJieView alloc] init];
    _BaoZhangView = [[HYHuXingBaoZhangView alloc] init];
    
    [self addSubview:self.imageBgView];
    [self addSubview:_topInforView];
    [self addSubview:_FangJianInforView];
    //    [self addSubview:_HuXingPicView];
    [self addSubview:_jichusheshiView];
    [self addSubview:_HuXingJianJieView];
    [self addSubview:_BaoZhangView];
    [_imageBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.top.mas_equalTo(self.mas_top);
        make.height.mas_offset(MARGIN*20);
    }];
    [_topInforView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_imageBgView.mas_bottom).mas_offset(MARGIN);
        make.left.mas_equalTo(self.mas_left).mas_offset(MARGIN);
        make.right.mas_equalTo(self.mas_right).mas_offset(-MARGIN);
    }];
    [_FangJianInforView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_topInforView.mas_bottom).mas_offset(MARGIN);
        make.left.mas_equalTo(self.mas_left).mas_offset(MARGIN);
        make.right.mas_equalTo(self.mas_right).mas_offset(-MARGIN);
    }];
    //    [_HuXingPicView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.top.mas_equalTo(_FangJianInforView.mas_bottom).mas_offset(MARGIN);
    //        make.left.mas_equalTo(self.mas_left).mas_offset(MARGIN);
    //        make.right.mas_equalTo(self.mas_right).mas_offset(-MARGIN);
    //    }];
    [_jichusheshiView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_FangJianInforView.mas_bottom).mas_offset(MARGIN);
        make.left.mas_equalTo(self.mas_left).mas_offset(MARGIN);
        make.right.mas_equalTo(self.mas_right).mas_offset(-MARGIN);
    }];
    [_HuXingJianJieView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_jichusheshiView.mas_bottom).mas_offset(MARGIN);
        make.left.mas_equalTo(self.mas_left).mas_offset(MARGIN);
        make.right.mas_equalTo(self.mas_right).mas_offset(-MARGIN);
    }];
    [_BaoZhangView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_HuXingJianJieView.mas_bottom).mas_offset(MARGIN);
        make.left.mas_equalTo(self.mas_left).mas_offset(MARGIN);
        make.right.mas_equalTo(self.mas_right).mas_offset(-MARGIN);
        make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-MARGIN);
    }];
    [_topInforView setBoundWidth:0.5 cornerRadius:6 boardColor:HYCOLOR.color_c6];
    [_FangJianInforView setBoundWidth:0.5 cornerRadius:6 boardColor:HYCOLOR.color_c6];
    [_jichusheshiView setBoundWidth:0.5 cornerRadius:6 boardColor:HYCOLOR.color_c6];
    //    [_HuXingPicView setBoundWidth:0.5 cornerRadius:6 boardColor:HYCOLOR.color_c6];
    [_BaoZhangView setBoundWidth:0.5 cornerRadius:6 boardColor:HYCOLOR.color_c6];
    [_HuXingJianJieView setBoundWidth:0.5 cornerRadius:6 boardColor:HYCOLOR.color_c6];
    
    _jichusheshiView.titleLable.text = @"房间配套";
    [_topInforView.collectBtn addTarget:self action:@selector(clickCollectBtn:) forControlEvents:UIControlEventTouchUpInside];
}

- (HYBaseView*)imageBgView
{
    if (!_imageBgView) {
        _imageBgView = [[HYBaseView   alloc] init];
        _ImageScrollView = [HYPictureCarouselView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, ADJUST_PERCENT_FLOAT(200)) shouldInfiniteLoop:YES imageNamesGroup:nil];
        _ImageScrollView.placeholderImage = IMAGENAME(@"占位图-750_400");
        [_imageBgView addSubview:_ImageScrollView];
        _ImageScrollView.showPageControl = NO;
        [_ImageScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(_imageBgView);
        }];
    }
    return _imageBgView;
}


@end
