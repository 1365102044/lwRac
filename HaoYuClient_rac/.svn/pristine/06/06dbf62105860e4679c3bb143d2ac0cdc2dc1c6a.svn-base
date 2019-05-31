//
//  HYPayDeatilHeaderView.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/1.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYPayDeatilHeaderView.h"
#import "HYAttributedStringLabel.h"
#import "HYPaymentViewController.h"
@interface HYPayDeatilHeaderView()
{
    CGFloat MARGIN;
}
@property (nonatomic, strong) UIImageView * houseImageView;
@property (nonatomic, strong) HYBaseView * topView;
@property (nonatomic, strong) HYDefaultLabel * houseNameLable;
@property (nonatomic, strong) HYDefaultLabel * houseDescLable;
@property (nonatomic, strong) HYAttributedStringLabel * priceLable;
@property (nonatomic, strong) HYBaseView * bottomView;

@end

@implementation HYPayDeatilHeaderView

- (void)setContractModel:(HYContractModel *)contractModel
{
    _contractModel = contractModel;
    [self.houseImageView sd_setImageWithURL:[NSURL URLWithString:HYIMAGEURLSTRING(HYProjectImageURLStringList, contractModel.roomTypePic[@"big"])] placeholderImage:IMAGENAME(@"占位图-750_400")];
    _houseNameLable.text = contractModel.houseItemName;
    _houseDescLable.text = [NSString stringWithFormat:@"%@栋 %@室",contractModel.buildingNo,contractModel.houseNo];
    [_priceLable setAttributedStringWithContentArray:@[@{@"color" : [UIColor redColor],
                                                         @"content" : contractModel.iosDedicated ? contractModel.iosDedicated : @"",
                                                         @"size" : SYSTEM_MEDIUMFONT(22),
                                                         @"lineSpacing": @1},
                                                       @{@"color" : HYCOLOR.color_c4,
                                                         @"content" : @"元/月",
                                                         @"size" : SYSTEM_MEDIUMFONT(13),
                                                         @"lineSpacing": @1}]];
}

/**
 tag : 12 热水表；  11 水表； 10 电费
 */
- (void)clickSurfaceIconBtn:(UIButton *)sender
{
    // 分散式不能使用水电表、智能门锁 2018年12月25日09:54:54
    if ([_contractModel.isJiZhong integerValue] != 1) {
        NSString *alearStr = [NSString stringWithFormat:@"该合同未查询到%@相关信息",(sender.tag ==10) ? @"电表" : ((sender.tag == 11) ? @"水表" : @"热水表")];
        ALERT(alearStr);
        return;
    }
    if(self.clickSurfaceIconBlock){
        self.clickSurfaceIconBlock(@(sender.tag));
    }
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        MARGIN = ADJUST_PERCENT_FLOAT(10);
        [self setUI];
    }
    return self;
}

- (void)setUI
{
    self.houseImageView = [[UIImageView alloc] init];
    [self addSubview:self.houseImageView];
    [self addSubview:self.topView];
    [self addSubview:self.bottomView];
    
    [self.houseImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self);
        make.height.mas_offset(ADJUST_PERCENT_FLOAT(200));
    }];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).mas_offset(MARGIN);
        make.right.mas_equalTo(self.mas_right).mas_offset(-MARGIN);
        make.top.mas_equalTo(self.houseImageView.mas_bottom).mas_offset(MARGIN);
    }];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).mas_offset(MARGIN);
        make.right.mas_equalTo(self.mas_right).mas_offset(-MARGIN);
        make.top.mas_equalTo(self.topView.mas_bottom).mas_offset(MARGIN);
    }];
    
    HYDefaultLabel *bottom_title = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(15)
                                                            text:@"当前未缴账单："
                                                       textColor:HYCOLOR.color_c4];
    HYDefaultLabel *bottom_func = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(12)
                                                           text:@"缴费"
                                                      textColor:HYCOLOR.color_c0];
    bottom_func.backgroundColor = [UIColor redColor];
    [bottom_func setBoundWidth:0 cornerRadius:4];
    bottom_func.textAlignment = NSTextAlignmentCenter;
    bottom_title.backgroundColor = [UIColor clearColor];
    _bottom_func = bottom_func;
    
    [self addSubview:bottom_title];
    [self addSubview:bottom_func];
    
    [bottom_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_bottomView.mas_bottom).mas_offset(MARGIN*2);
        make.left.mas_equalTo(self.mas_left).mas_offset(MARGIN*2);
    }];
    [bottom_func mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).mas_offset(-MARGIN*2);
        make.centerY.mas_equalTo(bottom_title.mas_centerY);
        make.size.mas_offset(CGSizeMake(ADJUST_PERCENT_FLOAT(60), ADJUST_PERCENT_FLOAT(30)));
        make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-MARGIN*2);
    }];
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = HYCOLOR.color_c4;
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(0.5);
        make.left.right.mas_equalTo(_topView);
        make.top.mas_equalTo(bottom_func.mas_bottom).mas_offset(MARGIN);
    }];
    bottom_func.userInteractionEnabled = YES;
    
}

- (HYBaseView*)topView
{
    if (!_topView) {
        _topView = [[HYBaseView alloc] init];
        
        _houseNameLable = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(15)
                                                   text:@""
                                              textColor:HYCOLOR.color_c4];
        _houseDescLable = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(12)
                                                   text:@""
                                              textColor:HYCOLOR.color_c4];
        _priceLable = [HYAttributedStringLabel labelWithFont:SYSTEM_REGULARFONT(15)
                                                        text:@""
                                                   textColor:HYCOLOR.color_c4];
        [_topView addSubview:_houseNameLable];
        [_topView addSubview:_houseDescLable];
        [_topView addSubview:_priceLable];
        [_houseNameLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_topView.mas_top).mas_offset(MARGIN);
            make.left.mas_equalTo(_topView.mas_left).mas_offset(MARGIN);
        }];
        [_houseDescLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_houseNameLable.mas_bottom).mas_offset(MARGIN);
            make.left.mas_equalTo(_houseNameLable.mas_left);
            make.bottom.mas_equalTo(_topView.mas_bottom).mas_offset(-MARGIN);
        }];
        [_priceLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(_topView.mas_centerY);
            make.right.mas_equalTo(_topView.mas_right).mas_offset(-MARGIN);
        }];
    }
    return _topView;
}

- (HYBaseView*)bottomView
{
    if (!_bottomView) {
        _bottomView = [[HYBaseView alloc] init];
        
        HYDefaultLabel *titleLable = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(15)
                                                              text:@"充值"
                                                         textColor:HYCOLOR.color_c4];
        [_bottomView addSubview:titleLable];
        [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_bottomView.mas_top).mas_offset(MARGIN*2);
            make.bottom.mas_equalTo(_bottomView.mas_bottom).mas_offset(-MARGIN*2);
            make.left.mas_equalTo(_bottomView.mas_left).mas_offset(MARGIN);
            make.centerY.mas_equalTo(_bottomView.mas_centerY);
        }];
        
        NSArray *iconArray = @[@"jiaofei_dian_icon",@"jiaofei_shui_icon",@"jiaofeo_re_shui_icon"];

        NSMutableArray *iconBtnArray = [[NSMutableArray alloc] init];
        for (int i = 0; i < iconArray.count; i++) {
            HYDefaultButton *icon = [[HYDefaultButton alloc] init];
            [icon setBackgroundImage:IMAGENAME(iconArray[i]) forState:UIControlStateNormal];
            icon.tag = i+10;
            [icon addTarget:self action:@selector(clickSurfaceIconBtn:) forControlEvents:UIControlEventTouchUpInside];
            [iconBtnArray addObject:icon];
            [_bottomView addSubview:icon];
            [icon mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(_bottomView.mas_right).mas_offset(-(MARGIN*2 + i*MARGIN*5));
                make.size.mas_offset(CGSizeMake(MARGIN*3, MARGIN*3));
                make.centerY.mas_equalTo(titleLable.mas_centerY);
            }];
        }
    }
    return _bottomView;
}
@end
