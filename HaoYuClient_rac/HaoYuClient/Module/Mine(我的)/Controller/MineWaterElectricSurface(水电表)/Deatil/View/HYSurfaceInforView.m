//
//  HYSurfaceInforView.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/10/29.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYSurfaceInforView.h"
#import "HYVerticalLable.h"
#import "HYShuiDianBiaoModel.h"
@interface HYSurfaceInforView ()
@property (nonatomic, strong) HYDefaultLabel * titleLable;
@property (nonatomic, strong) HYBaseView * bgView;
@property (nonatomic, strong) HYBaseView * bg_topView;
@property (nonatomic, strong) HYDefaultLabel * bg_titleLable;
@property (nonatomic, strong) HYDefaultLabel * shengYuShuiLiangContentLable;
@property (nonatomic, strong) HYDefaultLabel * shengYuShuiLiangLable;
@property (nonatomic, strong) HYVerticalLable * yesterdayUseWaterLable;
@property (nonatomic, strong) HYVerticalLable * accountAmountLable;
@property (nonatomic, strong) HYVerticalLable * leiJiYongShuiLiangLable;
@property (nonatomic, strong) UIImageView * centerIcon;

@property (nonatomic, strong) UIColor * bg_text_corlor;
@property (nonatomic, strong) NSDictionary * modelDict;
//表类型 1 水/ 2电
@property (nonatomic, assign) NSInteger surfaceType;
@property (nonatomic, strong) UIButton * moreBtn;
//热水冷水切换按钮时图
@property (nonatomic, strong) UIView * TagBtnView;
@end

@implementation HYSurfaceInforView
/**
 type : 1 水/ 2 电
 */
- (void)setSurfaceInforModel:(NSDictionary *)modelDict
{
    _modelDict          = modelDict;
    NSArray *temp       = modelDict.allKeys;
    [self setDataModel:_selTag];
    if (temp.count == 2) {
        self.TagBtnView.hidden = NO;
    }
}

- (void)setDataModel:(NSString *)tagstr
{
    HYShuiDianBiaoModel *model                  = _modelDict[tagstr];
    if (!model) return;
    _titleLable.text                            = model.fullAdress;
    _shengYuShuiLiangContentLable.text          = ([tagstr isEqualToString:@"40"]) ? model.dianYuLiang: model.shuiYuLiang;
    _yesterdayUseWaterLable.bottomLable.text    =([tagstr isEqualToString:@"40"]) ? model.dianLiang : model.shuiLiang;
    _accountAmountLable.bottomLable.text        = ([tagstr isEqualToString:@"40"]) ? model.dianYuE : model.shuiYuE;
    _leiJiYongShuiLiangLable.bottomLable.text   = ([tagstr isEqualToString:@"40"]) ? model.sumDian : model.sumShui;
}

- (void)clickMoreBtn:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(moreRechargeRecordListInfor)]) {
        [self.delegate moreRechargeRecordListInfor];
    }
}

- (void)clickSubmitBtn:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(submitRechargeRequest)]) {
        [self.delegate submitRechargeRequest];
    }
}

- (void)switchSurfaceType:(UIButton *)sender
{
    self.bg_titleLable.text     = [NSString stringWithFormat:@"%@表",sender.titleLabel.text];
    _selTag            = [NSString stringWithFormat:@"%ld",sender.tag];
    [self setDataModel:_selTag];
    [self surfaceType:(sender.tag == 10 ? 1 : 3)];
}

//15311305641
/**
 type : 1 水/ 2 电 / 3 热水
 */
- (void)surfaceType:(NSInteger)Type
{
    _surfaceType                                    = Type;
    NSString *iconStr                               = @"";
    if (Type == 2) {
        _bg_titleLable.text                         = @"电表";
        _shengYuShuiLiangLable.text                 = @"剩余电量(kw·h)";
        _yesterdayUseWaterLable.topLable.text       = @"昨日用电量(kw·h)";
        _accountAmountLable.topLable.text           = @"账户余额(元)";
        _leiJiYongShuiLiangLable.topLable.text      = @"累计用电量(kw·h)";
        iconStr = @"dian_center_icon";
        [self setLayerWithStartColor:@"#febc2f" endColor:@"#faab01"];
        _selTag = @"40";
    }else {
        _yesterdayUseWaterLable.topLable.text       = @"昨日用水量(m³)";
        _accountAmountLable.topLable.text           = @"账户余额(元)";
        _leiJiYongShuiLiangLable.topLable.text      = @"累计用水量(m³)";
        _shengYuShuiLiangLable.text                 = @"剩余水量(m³)";
        if (Type == 3){
            iconStr = @"hotwater_center_icon";
            [self setLayerWithStartColor:@"#df6d11" endColor:@"#b53043"];
            _selTag = @"20";
        }else if (Type == 1){
            iconStr = @"water_center_icon";
            [self setLayerWithStartColor:@"#6caadc" endColor:@"#2058bf"];
            _selTag = @"10";
        }
    }
    _centerIcon.image = IMAGENAME(iconStr);
}

/**
 添加背景渐变色
 */
- (void)setLayerWithStartColor:(NSString *)startColorStr endColor:(NSString *)endColorStr
{
    UIColor *startColor = [UIColor ex_colorWithHexString:startColorStr alpha:0.5];
    UIColor *endColor   = [UIColor ex_colorWithHexString:endColorStr alpha:0.5];
    CAGradientLayer *gradientLayer  = [CAGradientLayer layer];
    gradientLayer.colors            = @[(__bridge id)startColor.CGColor, (__bridge id)endColor.CGColor];
    gradientLayer.locations         = @[@0.0,@1.0];
    gradientLayer.startPoint        = CGPointMake(0, 1);
    gradientLayer.endPoint          = CGPointMake(1, 0);
    gradientLayer.frame             = CGRectMake(0, 0, SCREEN_WIDTH-MARGIN*2, MARGIN*36);
    CALayer * firstLayer = self.bgView.layer.sublayers.firstObject;
    if([firstLayer isKindOfClass:[CAGradientLayer class]]){
        [firstLayer removeFromSuperlayer];
    }
    [self.bgView.layer insertSublayer:gradientLayer atIndex:0];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = HYCOLOR.color_c1;
        [self setUI];
    }
    return self;
}


- (void)setUI
{
    _bg_text_corlor                         = HYCOLOR.color_c0;
    
    _titleLable                             = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(17)
                                                                       text:@""
                                                                  textColor:HYCOLOR.color_c4];
    _titleLable.numberOfLines               = 0;
    _titleLable.textAlignment               = NSTextAlignmentCenter;
    _titleLable.backgroundColor             = [UIColor clearColor];
    HYDefaultLabel *recharge_recordLable    = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(15)
                                                                       text:@"充值记录"
                                                                  textColor:HYCOLOR.color_c4];
    HYDefaultButton *moreBtn                = [HYDefaultButton buttonWithTitleStringKey:@"更多"
                                                                             titleColor:HYCOLOR.color_c4
                                                                              titleFont:SYSTEM_REGULARFONT(15)
                                                                                 target:self
                                                                               selector:@selector(clickMoreBtn:)];
    recharge_recordLable.backgroundColor    = [UIColor clearColor];
    moreBtn.backgroundColor                 = [UIColor clearColor];
    moreBtn.contentHorizontalAlignment      = UIControlContentHorizontalAlignmentRight;
    [self addSubviews:@[_titleLable,self.bgView,recharge_recordLable,moreBtn]];
    [_titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).mas_offset(MARGIN*2);
        make.left.mas_equalTo(self.mas_left).mas_offset(MARGIN*1.3);
        make.right.mas_equalTo(self.mas_right).mas_offset(-MARGIN*1.3);
    }];
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(_titleLable);
        make.top.mas_equalTo(_titleLable.mas_bottom).mas_offset(MARGIN*1.5);
    }];
    [recharge_recordLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_bgView.mas_left).mas_offset(-3);
        make.centerY.mas_equalTo(moreBtn.mas_centerY);
    }];
    [moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_bgView.mas_bottom).mas_offset(MARGIN*2);
        make.right.mas_equalTo(_bgView.mas_right).mas_offset(3);
        make.height.mas_offset(MARGIN*2.5);
        make.width.mas_offset(MARGIN*8);
        make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-MARGIN);
    }];
    
    _moreBtn = moreBtn;
    [_bgView setBoundWidth:0 cornerRadius:4];
    _yesterdayUseWaterLable.bottomLable.text    = @"0.00";
    _accountAmountLable.bottomLable.text        = @"0.00";
    _leiJiYongShuiLiangLable.bottomLable.text   = @"0.00";
    
}

- (HYBaseView*)bgView
{
    if (!_bgView) {
        _bgView                                 = [[HYBaseView alloc] init];
        _yesterdayUseWaterLable                 = [[HYVerticalLable alloc] init];
        _accountAmountLable                     = [[HYVerticalLable alloc] init];
        _leiJiYongShuiLiangLable                = [[HYVerticalLable alloc] init];
        HYBaseView *line                        = [HYBaseView new];
        HYBaseView *line1                       = [HYBaseView new];
        line.backgroundColor                    = HYCOLOR.color_c1;
        line1.backgroundColor                   = HYCOLOR.color_c1;
        HYDefaultButton *submitBtn              = [HYDefaultButton buttonWithTitleStringKey:@"充值"
                                                                                 titleColor:_bg_text_corlor
                                                                                  titleFont:SYSTEM_REGULARFONT(15)
                                                                                     target:self
                                                                                   selector:@selector(clickSubmitBtn:)];
        
        _bg_titleLable.backgroundColor          = [UIColor clearColor];
        
        [_bgView addSubviews:@[self.bg_topView,
                               _yesterdayUseWaterLable,
                               _leiJiYongShuiLiangLable,
                               _accountAmountLable,
                               line,line1,
                               submitBtn]];
        [_bg_topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_bgView.mas_top);
            make.left.right.mas_equalTo(_bgView);
        }];
        CGFloat W = (SCREEN_WIDTH - MARGIN * 1.3 * 2)/3;
        [_yesterdayUseWaterLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_bg_topView.mas_bottom);
            make.left.mas_equalTo(_bg_topView);
            make.width.mas_offset(W);
            make.height.mas_offset(MARGIN*8);
        }];
        [_accountAmountLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_yesterdayUseWaterLable.mas_right);
            make.width.mas_equalTo(_yesterdayUseWaterLable.mas_width);
            make.height.mas_equalTo(_yesterdayUseWaterLable.mas_height);
            make.centerY.mas_equalTo(_yesterdayUseWaterLable.mas_centerY);
        }];
        [_leiJiYongShuiLiangLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(_yesterdayUseWaterLable.mas_width);
            make.height.mas_equalTo(_yesterdayUseWaterLable.mas_height);
            make.centerY.mas_equalTo(_yesterdayUseWaterLable.mas_centerY);
            make.left.mas_equalTo(_accountAmountLable.mas_right);
        }];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_yesterdayUseWaterLable.mas_right);
            make.width.mas_offset(1);
            make.top.mas_equalTo(_bg_topView.mas_bottom);
            make.height.mas_equalTo(_yesterdayUseWaterLable.mas_height);
        }];
        [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_offset(1);
            make.left.mas_equalTo(_accountAmountLable.mas_right);
            make.top.mas_equalTo(_bg_topView.mas_bottom);
            make.height.mas_equalTo(_yesterdayUseWaterLable.mas_height);
        }];
        [submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(_bg_topView);
            make.height.mas_offset(MARGIN*4);
            make.top.mas_equalTo(_accountAmountLable.mas_bottom);
            make.bottom.mas_equalTo(_bgView.mas_bottom);
        }];
        
        _bg_topView.backgroundColor = [UIColor clearColor];
        submitBtn.backgroundColor   = [UIColor clearColor];
    }
    return _bgView;
}


- (HYBaseView*)bg_topView
{
    if (!_bg_topView) {
        _bg_topView                     = [[HYBaseView alloc] init];
        
        _bg_titleLable                  = [HYDefaultLabel labelWithFont:SYSTEM_MEDIUMFONT(18)
                                                                   text:@"冷水表"
                                                              textColor:_bg_text_corlor];
        _bg_titleLable.textAlignment    = NSTextAlignmentCenter;
        UIImageView *centerIcon         = [[UIImageView alloc] init];
        centerIcon.image                = IMAGENAME(@"water_center_icon");
        _shengYuShuiLiangContentLable   = [HYDefaultLabel labelWithFont:SYSTEM_MEDIUMFONT(36)
                                                                   text:@"0.00"
                                                              textColor:_bg_text_corlor];
        HYDefaultLabel *shengYuShuiLiangLable = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(15)
                                                                         text:@"剩余水量(m³)"
                                                                    textColor:_bg_text_corlor];
        _shengYuShuiLiangLable          = shengYuShuiLiangLable;
        _bg_titleLable.backgroundColor  = [UIColor clearColor];
        _shengYuShuiLiangContentLable.backgroundColor   = [UIColor clearColor];
        shengYuShuiLiangLable.backgroundColor           = [UIColor clearColor];
        _centerIcon                     = centerIcon;
        [_bg_topView addSubviews:@[centerIcon,_bg_titleLable,_shengYuShuiLiangContentLable,shengYuShuiLiangLable]];
        [_bg_titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_bg_topView.mas_top).mas_offset(MARGIN*1.5);
            make.centerX.mas_equalTo(_bg_topView.mas_centerX);
        }];
        [centerIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_offset(CGSizeMake(MARGIN*20, MARGIN*5.5));
            make.top.mas_equalTo(_bg_titleLable.mas_bottom).mas_offset(-MARGIN*1.5);
            make.centerX.mas_equalTo(_bg_topView.mas_centerX);
        }];
        [_shengYuShuiLiangContentLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_bg_titleLable.mas_bottom).mas_offset(MARGIN*4);
            make.centerX.mas_equalTo(_bg_topView.mas_centerX);
        }];
        [shengYuShuiLiangLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_shengYuShuiLiangContentLable.mas_bottom).mas_offset(MARGIN);
            make.centerX.mas_equalTo(_bg_topView.mas_centerX);
            make.bottom.mas_equalTo(_bg_topView.mas_bottom).mas_offset(-MARGIN*2);
        }];
        
        [_bg_topView addSubview:self.TagBtnView];
        [_TagBtnView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(self.bg_topView);
        }];
        self.TagBtnView.hidden = YES;
    }
    return _bg_topView;
}

- (UIView*)TagBtnView
{
    if (!_TagBtnView) {
        _TagBtnView = [[UIView alloc] init];
        _TagBtnView.backgroundColor = [UIColor clearColor];
        HYDefaultButton *coldSurfaceBtn = [HYDefaultButton buttonWithTitleStringKey:@"冷水"
                                                                         titleColor:HYCOLOR.color_c0
                                                                          titleFont:SYSTEM_REGULARFONT(14)
                                                                             target:self
                                                                           selector:@selector(switchSurfaceType:)];
        coldSurfaceBtn.tag = 10;
        HYDefaultButton *heatSurfaceBtn = [HYDefaultButton buttonWithTitleStringKey:@"热水"
                                                                         titleColor:HYCOLOR.color_c0
                                                                          titleFont:SYSTEM_REGULARFONT(14)
                                                                             target:self
                                                                           selector:@selector(switchSurfaceType:)];
        heatSurfaceBtn.tag              = 20;
        coldSurfaceBtn.backgroundColor = [UIColor ex_colorWithHexString:@"#00FFFF" alpha:0.5];
        heatSurfaceBtn.backgroundColor = [UIColor ex_colorWithHexString:@"#D81E06" alpha:0.5];
        [_TagBtnView addSubviews:@[coldSurfaceBtn,heatSurfaceBtn]];
        [coldSurfaceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_offset(CGSizeMake(MARGIN*6, MARGIN*2.5));
            make.left.mas_equalTo(_TagBtnView.mas_left);
            make.top.mas_equalTo(_TagBtnView.mas_top).mas_offset(MARGIN*2);
        }];
        [heatSurfaceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_offset(CGSizeMake(MARGIN*6, MARGIN*2.5));
            make.left.mas_equalTo(_TagBtnView.mas_left);
            make.top.mas_equalTo(coldSurfaceBtn.mas_bottom).mas_offset(MARGIN*2);
            make.right.bottom.mas_equalTo(_TagBtnView);
        }];
        coldSurfaceBtn.size = CGSizeMake(MARGIN*6, MARGIN*2.5);
        heatSurfaceBtn.size = CGSizeMake(MARGIN*6, MARGIN*2.5);
        [coldSurfaceBtn setRoundCornerWithCorner:(UIRectCornerTopRight | UIRectCornerBottomRight) cornerRadius:4];
        [heatSurfaceBtn setRoundCornerWithCorner:(UIRectCornerTopRight | UIRectCornerBottomRight) cornerRadius:4];
    }
    return _TagBtnView;
}
@end
