//
//  HYStatusProgressView.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/13.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYStatusProgressView.h"

@interface HYStatusProgressView ()
@property (nonatomic, strong) HYBaseView * bgView;

@property (nonatomic, strong) NSMutableArray * titleLabelMutableArray;
@property (nonatomic, strong) NSMutableArray * pointViewMutableArray;
@property (nonatomic, strong) NSMutableArray * lineViewMutableArray;

@end
@implementation HYStatusProgressView

- (void)setCurrentSatusIndex:(NSInteger )currentIndex
{
    if (currentIndex > _titleLabelMutableArray.count || currentIndex == 0) {
        return;
    }
    for (int i = 0; i< _titleLabelMutableArray.count; i++) {
        UIView *pointview = _pointViewMutableArray[i];
        
        NSInteger index = 0;
        if (i > 0) {
            index = i - 1;
        }
        UIView *lineview = _lineViewMutableArray[index];
        if (i <= currentIndex) {
            lineview.backgroundColor = HYCOLOR.color_c3;
                pointview.backgroundColor = HYCOLOR.color_c3;
        }else{
                pointview.backgroundColor = HYCOLOR.color_c1;
            lineview.backgroundColor = HYCOLOR.color_c1;
        }
    }
}

- (void)setDataArr:(NSArray *)dataArr
{
    _dataArr = dataArr;
    [self setUI];
    
    [self.titleLabelMutableArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:MARGIN*5 leadSpacing:MARGIN*0 tailSpacing:MARGIN*0];
    [self.titleLabelMutableArray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_bgView.mas_top).mas_offset(MARGIN);
        make.height.mas_offset(MARGIN*1.5);
    }];
    [self.pointViewMutableArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:MARGIN leadSpacing:MARGIN*2.5 tailSpacing:MARGIN*2.5];
    HYDefaultLabel *fristLable = _titleLabelMutableArray.firstObject;
    [self.pointViewMutableArray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(fristLable.mas_bottom).mas_offset(MARGIN);
        make.height.mas_offset(MARGIN*1);
        make.bottom.mas_equalTo(_bgView.mas_bottom).mas_offset(-MARGIN);
    }];
    UIView *fristPointView = self.pointViewMutableArray.firstObject;
    for (int i = 0 ; i < self.lineViewMutableArray.count; i++) {
        UIView *line = self.lineViewMutableArray[i];
    UIView *leftPointView = self.pointViewMutableArray[i];
        UIView *rightPointView = self.pointViewMutableArray[i+1];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_offset(3);
            make.centerY.mas_equalTo(fristPointView.mas_centerY);
            make.left.mas_equalTo(leftPointView.mas_right);
            make.right.mas_equalTo(rightPointView.mas_right);
        }];
    }
}

- (void)setUI
{
    if (_dataArr.count == 0) {
        return ;
    }
    _bgView = [[HYBaseView alloc] init];
    [self addSubview:self.bgView];
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    
    for (int i = 0; i < _dataArr.count; i++) {
        HYDefaultLabel *lable = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(12)
                                                         text:[_dataArr[i] isNullToString]
                                                    textColor:HYCOLOR.color_c4];
        [self.titleLabelMutableArray addObject:lable];
        lable.textAlignment = NSTextAlignmentCenter;
        [_bgView addSubview:lable];
        UIView *pointView = [[UIView alloc] init];
        pointView.backgroundColor = HYCOLOR.color_c1;
        [_bgView addSubview:pointView];
        [self.pointViewMutableArray addObject:pointView];
        [pointView setBoundWidth:0 cornerRadius:MARGIN/2];
        
        if (i < _dataArr.count - 1) {
            UIView *line = [[UIView alloc] init];
            line.backgroundColor = HYCOLOR.color_c1;
            [_bgView addSubview:line];
            [self.lineViewMutableArray addObject:line];
        }
    }
}

- (NSMutableArray*)titleLabelMutableArray
{
    if (!_titleLabelMutableArray) {
        _titleLabelMutableArray = [[NSMutableArray alloc] init];
    }
    return _titleLabelMutableArray;
}
- (NSMutableArray*)pointViewMutableArray
{
    if (!_pointViewMutableArray) {
        _pointViewMutableArray = [[NSMutableArray alloc] init];
    }
    return _pointViewMutableArray;
}
- (NSMutableArray*)lineViewMutableArray
{
    if (!_lineViewMutableArray) {
        _lineViewMutableArray = [[NSMutableArray alloc] init];
    }
    return _lineViewMutableArray;
}
@end

