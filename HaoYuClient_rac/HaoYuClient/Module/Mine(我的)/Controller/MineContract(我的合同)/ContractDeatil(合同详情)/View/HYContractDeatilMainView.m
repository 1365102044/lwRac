//
//  HYContractDeatilMainView.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/5/31.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYContractDeatilMainView.h"
#import "HYAttributedStringLabel.h"
#import "HYHeZuRenItemsView.h"
#import "HYStatusProgressView.h"
@interface HYContractDeatilMainView()
{
    CGFloat MAGIN_L;
}
@property (nonatomic, strong) HYBaseView * TopView;
@property (nonatomic, strong) HYBaseView * ProgressView;
@property (nonatomic, strong) HYBaseView * LivePersonInfoView;
@property (nonatomic, strong) HYBaseView * livePersonItemsView;

@property (nonatomic, strong) UIImageView * topImageView;
@property (nonatomic, strong) HYDefaultLabel * houserNameLable;
@property (nonatomic, strong) HYDefaultLabel * doorLable;
@property (nonatomic, strong) HYDefaultLabel * houserLayoutLable;
@property (nonatomic, strong) HYAttributedStringLabel * priceLable;

@property (nonatomic, strong) HYStatusProgressView * StatusProgressView;
@property (nonatomic, strong) HYDefaultLabel * livePersonTitle;
@property (nonatomic, strong) NSArray * ItemsArr;
@end

@implementation HYContractDeatilMainView

- (void)setContractModel:(HYContractModel *)contractModel
{
    _contractModel = contractModel;
    [self.topImageView sd_setImageWithURL:[NSURL URLWithString:HYIMAGEURLSTRING(HYProjectImageURLStringList, contractModel.roomTypePic[@"big"])] placeholderImage:IMAGENAME(@"占位图-750_400")];
    _houserNameLable.text = contractModel.houseItemName;
    _doorLable.text = [NSString stringWithFormat:@"%@栋 %@室",contractModel.buildingNo,contractModel.houseNo];
    _houserLayoutLable.text = [NSString stringWithFormat:@"%@室 %@厅",contractModel.shi,contractModel.ting];
    [_priceLable setAttributedStringWithContentArray:@[@{@"color" : [UIColor redColor],
                                                         @"content" : contractModel.iosDedicated ? contractModel.iosDedicated : @"",
                                                         @"size" : SYSTEM_MEDIUMFONT(22),
                                                         @"lineSpacing": @1},
                                                       @{@"color" : HYCOLOR.color_c4,
                                                         @"content" : @"元/月",
                                                         @"size" : SYSTEM_MEDIUMFONT(13),
                                                         @"lineSpacing": @1}]];
    NSMutableArray *tem = [[NSMutableArray alloc] init];
    PARA_CREART;
    PARA_SET([contractModel.zukeName isNullToString], @"title");
    PARA_SET([contractModel.zukePhone isNullToString], @"desc");
    [tem addObject:para];
    if (contractModel.chengZuZuKeList.count > 0 ) {
        for (NSDictionary *dic in contractModel.chengZuZuKeList) {
            PARA_CREART;
            PARA_SET([HYStringTool checkString:dic[@"residentName"]], @"title");
            PARA_SET([HYStringTool checkString:dic[@"redidentPhone"]], @"desc");
            [tem addObject:para];
        }
    }
    _ItemsArr = tem;
    [self updateLivePersonViewContrans];
    
    [_StatusProgressView setCurrentSatusIndex:[contractModel.status integerValue]];
}

- (void)updateLivePersonViewContrans
{
    [_livePersonItemsView removeAllSubviews];
    NSMutableArray *temp = [NSMutableArray array];
    for (int i = 0; i<_ItemsArr.count; i++) {
        NSDictionary *dic  = _ItemsArr [i];
        HYHeZuRenItemsView *item = [[HYHeZuRenItemsView alloc]init];
        item.titleLable.text = dic[@"title"];
        item.descLable.text = dic[@"desc"];
        [_livePersonItemsView addSubview:item];
        
        [item mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(_LivePersonInfoView);
            if (i == 0) {
                [item noIsFirst];
                make.top.mas_equalTo(_livePersonItemsView.mas_top);
            }else{
                HYHeZuRenItemsView *lastView = temp.lastObject;
                make.top.mas_equalTo(lastView.mas_bottom);
            }
            if (i == _ItemsArr.count - 1) {
                make.bottom.mas_equalTo(_livePersonItemsView.mas_bottom);
            }
        }];
        [temp addObject:item];
    }
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor greenColor];
        MAGIN_L = ADJUST_PERCENT_FLOAT(30);
        
        [self setUI];
        [_priceLable setAttributedStringWithContentArray:@[@{@"color" : [UIColor redColor],
                                                             @"content" : @"5000",
                                                             @"size" : SYSTEM_MEDIUMFONT(22),
                                                             @"lineSpacing": @1},
                                                           @{@"color" : HYCOLOR.color_c4,
                                                             @"content" : @"元/月",
                                                             @"size" : SYSTEM_MEDIUMFONT(13),
                                                             @"lineSpacing": @1}]];
        LWLog(@"+++++++%f",CGRectGetMaxY(_LivePersonInfoView.frame));
        
    }
    return self;
}

- (void)setUI
{
    _topImageView = [[UIImageView alloc] init];
    [self addSubview:_topImageView];
    [self addSubview:self.TopView];
    [self addSubview:self.ProgressView];
    [self addSubview:self.LivePersonInfoView];
    
    [_topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.height.mas_offset(ADJUST_PERCENT_FLOAT(200));
        make.top.mas_equalTo(self.mas_top);
    }];
    [_TopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.top.mas_equalTo(_topImageView.mas_bottom);
    }];
    [_ProgressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.top.mas_equalTo(_TopView.mas_bottom).mas_offset(ADJUST_PERCENT_FLOAT(10));
    }];
    [_LivePersonInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.top.mas_equalTo(_ProgressView.mas_bottom).mas_offset(ADJUST_PERCENT_FLOAT(10));
        make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-ADJUST_PERCENT_FLOAT(80));
    }];
}

/**
 懒加载
 */
- (HYBaseView*)TopView
{
    if (!_TopView) {
        _TopView = [[HYBaseView alloc] init];
        
        _houserNameLable = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(15) text:@"北京好寓-牡丹园店" textColor:HYCOLOR.color_c4];
        _doorLable = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(13) text:@"" textColor:HYCOLOR.color_c4];
        _houserLayoutLable = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(13) text:@"" textColor:HYCOLOR.color_c4];
        _priceLable = [HYAttributedStringLabel labelWithFont:SYSTEM_REGULARFONT(13) text:@"" textColor:HYCOLOR.color_c4];
        [_TopView addSubview:_houserNameLable];
        [_TopView addSubview:_doorLable];
        [_TopView addSubview:_houserLayoutLable];
        [_TopView addSubview:_priceLable];
        
        [_houserNameLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_TopView.mas_left).mas_offset(MAGIN_L);
            make.right.mas_equalTo(_TopView.mas_right).mas_offset(-ADJUST_PERCENT_FLOAT(100));
            make.top.mas_equalTo(_TopView.mas_top).mas_offset(ADJUST_PERCENT_FLOAT(10));
        }];
        [_doorLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_houserNameLable.mas_left);
            make.top.mas_equalTo(_houserNameLable.mas_bottom).mas_offset(ADJUST_PERCENT_FLOAT(10));
        }];
        [_houserLayoutLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_houserNameLable.mas_left);
            make.top.mas_equalTo(_doorLable.mas_bottom).mas_offset(ADJUST_PERCENT_FLOAT(10));
            make.bottom.mas_equalTo(_TopView.mas_bottom).mas_offset(-ADJUST_PERCENT_FLOAT(10));
        }];
        [_priceLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_TopView.mas_right).mas_offset(-ADJUST_PERCENT_FLOAT(10));
            make.centerY.mas_equalTo(_TopView.mas_centerY);
        }];
    }
    return _TopView;
}

- (HYBaseView*)ProgressView
{
    if (!_ProgressView) {
        _ProgressView = [[HYBaseView alloc] init];
        HYDefaultLabel * progressTitleLable = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(15) text:@"租房进度" textColor:HYCOLOR.color_c4];
        [_ProgressView addSubview:progressTitleLable];
        [progressTitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_ProgressView.mas_left).mas_offset(MAGIN_L);
            make.top.mas_equalTo(_ProgressView.mas_top).mas_offset(ADJUST_PERCENT_FLOAT(10));
        }];
        
        _StatusProgressView = [[HYStatusProgressView alloc] init];
        _StatusProgressView.backgroundColor = [UIColor blueColor];
        _StatusProgressView.dataArr = @[@"签收合同",@"待生效",@"办理入住",@"办理退房",@"退回押金"];
        [_ProgressView addSubview:_StatusProgressView];
        [_StatusProgressView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_ProgressView.mas_left).mas_offset(MARGIN*2);
            make.right.mas_equalTo(_ProgressView.mas_right).mas_offset(-MARGIN*2);
            make.top.mas_equalTo(progressTitleLable.mas_bottom).mas_offset(MARGIN);
            make.bottom.mas_equalTo(_ProgressView.mas_bottom).mas_offset(-MARGIN);
        }];
        
        UIView *icon = [self icon];
        [_ProgressView addSubview:icon];
        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_offset(CGSizeMake(ADJUST_PERCENT_FLOAT(8),ADJUST_PERCENT_FLOAT(8)));
            make.right.mas_equalTo(progressTitleLable.mas_left).mas_offset(-ADJUST_PERCENT_FLOAT(10));
            make.centerY.mas_equalTo(progressTitleLable.mas_centerY);
        }];
    }
    return _ProgressView;
}

- (HYBaseView*)LivePersonInfoView
{
    if (!_LivePersonInfoView) {
        _LivePersonInfoView = [[HYBaseView alloc] init];
        
        _livePersonTitle = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(15) text:@"租住人" textColor:HYCOLOR.color_c4];
        [_LivePersonInfoView addSubview:_livePersonTitle];
        [_livePersonTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_LivePersonInfoView.mas_left).mas_offset(MAGIN_L);
            make.top.mas_equalTo(_LivePersonInfoView.mas_top).mas_offset(ADJUST_PERCENT_FLOAT(10));
        }];
        
        _livePersonItemsView = [[HYBaseView alloc] init];
        [_LivePersonInfoView addSubview:_livePersonItemsView];
        [_livePersonItemsView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(_LivePersonInfoView);
            make.top.mas_equalTo(_livePersonTitle.mas_bottom).mas_offset(ADJUST_PERCENT_FLOAT(10));
            make.bottom.mas_equalTo(_LivePersonInfoView.mas_bottom).mas_offset(-ADJUST_PERCENT_FLOAT(10));
        }];
        
        NSMutableArray *temp = [NSMutableArray array];
        for (int i = 0; i<_ItemsArr.count; i++) {
            NSDictionary *dic  = _ItemsArr [i];
            HYHeZuRenItemsView *item = [[HYHeZuRenItemsView alloc]init];
            item.titleLable.text = dic[@"title"];
            item.descLable.text = dic[@"desc"];
            [_livePersonItemsView addSubview:item];
            
            [item mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.mas_equalTo(_LivePersonInfoView);
                if (i == 0) {
                    [item noIsFirst];
                    make.top.mas_equalTo(_livePersonItemsView.mas_top).mas_offset(ADJUST_PERCENT_FLOAT(10));
                }else{
                    HYHeZuRenItemsView *lastView = temp.lastObject;
                    make.top.mas_equalTo(lastView.mas_bottom);
                }
                if (i == _ItemsArr.count - 1) {
                    make.bottom.mas_equalTo(_livePersonItemsView.mas_bottom).mas_offset(-ADJUST_PERCENT_FLOAT(0));
                }
            }];
            [temp addObject:item];
        }
        UIView *icon = [self icon];
        [_LivePersonInfoView addSubview:icon];
        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_offset(CGSizeMake(ADJUST_PERCENT_FLOAT(8),ADJUST_PERCENT_FLOAT(8)));
            make.right.mas_equalTo(_livePersonTitle.mas_left).mas_offset(-ADJUST_PERCENT_FLOAT(10));
            make.centerY.mas_equalTo(_livePersonTitle.mas_centerY);
        }];
    }
    return _LivePersonInfoView;
}

- (UIView *)icon
{
    UIView *iconview = [[UIView alloc]init];
    iconview.backgroundColor = [UIColor redColor];
    iconview.layer.masksToBounds = YES;
    iconview.layer.cornerRadius = ADJUST_PERCENT_FLOAT(4);
    return iconview;
}


@end
