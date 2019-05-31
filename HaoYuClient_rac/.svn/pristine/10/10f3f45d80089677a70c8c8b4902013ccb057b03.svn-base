//
//  HYQianYueFillInforSecondView.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/19.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYQianYueFillInforSecondView.h"
#import "HYPayItemView.h"
#import "HYLeftRightLableView.h"
#import "HYHouseProjectInforTool.h"
#import "HYDiscountInforModel.h"
@interface HYQianYueFillInforSecondView ()
@property (nonatomic, strong) HYBaseScrollView * contentScrollView;
@property (nonatomic, strong) HYBaseView * topInforView;
@property (nonatomic, strong) HYDefaultLabel * sotreLable;
@property (nonatomic, strong) HYDefaultLabel * whereLable;
@property (nonatomic, strong) HYDefaultLabel * zujinLable;

@property (nonatomic, strong) HYBaseView * youhuiView;
@property (nonatomic, strong) HYBaseView * youhuiItemsBgView;

@property (nonatomic, strong) HYBaseView * heTongFeiYongView;
@property (nonatomic, strong) HYDefaultLabel * feiyong_titlelabe;

//优惠活动items
@property (nonatomic, strong) NSMutableArray * youhuiItemsArray;

/**
 上次选择的优惠券
 */
@property (nonatomic, strong) HYPayItemView * lastSelectYouHuiItem;

@end

@implementation HYQianYueFillInforSecondView

- (void)setHouseInfor_M:(HYHouseRescourcesModel *)houseInfor_M
{
    _houseInfor_M = houseInfor_M;
    _sotreLable.text = houseInfor_M.houseItemName;
    _whereLable.text = [NSString stringWithFormat:@"%@栋%@室",houseInfor_M.louNo,houseInfor_M.fangNo];
    _zujinLable.text = [NSString stringWithFormat:@"%@元/月",houseInfor_M.iosRent];
    
    //合同费项
    NSMutableArray *temp_A = [[NSMutableArray alloc] init];
    NSDictionary *infor_dic =  houseInfor_M.fee.firstObject;
    NSArray *allkey_A = infor_dic.allKeys;
    for (NSString *keys in allkey_A) {
        NSMutableDictionary *temp_dict = [[NSMutableDictionary alloc] init];
        temp_dict[@"left"] = StringWithFormat(keys);
        temp_dict[@"right"] = StringWithFormat(infor_dic[keys]);
        [temp_A addObject:temp_dict];
    }
    [self addHeTongFreeItems:temp_A];
    self.para[@"jiage"] = houseInfor_M.iosRent;
    self.para[@"yaJin"] = houseInfor_M.iosRent;
}

/**
 添加费用项目
 */
- (void)addHeTongFreeItems:(NSArray *)feiyonyArr
{
    NSMutableArray *temp = [NSMutableArray array];
    for (int i = 0 ; i < feiyonyArr.count; i ++) {
        NSDictionary *dic = feiyonyArr[i];
        HYLeftRightLableView *feiyong = [HYLeftRightLableView creatOnlyLeftRightLableView:dic[@"left"]
                                                                                 rightStr:dic[@"right"]
                                                                            CallBackBlock:^(id sender) {
                                                                                
                                                                            }];
        [_heTongFeiYongView addSubview:feiyong];
        [feiyong mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(_heTongFeiYongView);
            make.height.mas_offset(MARGIN*4);
            if (i == 0) {
                make.top.mas_equalTo(_feiyong_titlelabe.mas_bottom).mas_offset(MARGIN);
            }else{
                HYLeftRightLableView *lastLable = temp.lastObject;
                make.top.mas_equalTo(lastLable.mas_bottom).mas_offset(MARGIN);
            }
            if(i == feiyonyArr.count - 1){
                make.bottom.mas_equalTo(_heTongFeiYongView.mas_bottom);
            }
        }];
        [temp addObject:feiyong];
    }
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.contentScrollView];
        [self.contentScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self);
        }];
        //                self.youhuiArray = @[@"端午节大放送立减100",@"新用户立减200"];
    }
    return self;
}
/**
 添加主视图模块
 */
- (UIScrollView*)contentScrollView
{
    if (!_contentScrollView) {
        _contentScrollView = [[HYBaseScrollView alloc] init];
        _contentScrollView.backgroundColor = HYCOLOR.color_c1;
        [self addSubUI];
    }
    return _contentScrollView;
}

- (void)addSubUI
{
    [_contentScrollView addSubview:self.topInforView];
    [_contentScrollView addSubview:self.heTongTimeView];
    [_contentScrollView addSubview:self.youhuiView];
    [_contentScrollView addSubview:self.heTongFeiYongView];
    [_topInforView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_contentScrollView).mas_offset(MARGIN);
        make.left.mas_equalTo(_contentScrollView).mas_offset(MARGIN);
        make.right.mas_equalTo(_contentScrollView).mas_offset(-MARGIN);
        make.width.mas_offset(SCREEN_WIDTH-MARGIN*2);
    }];
    [_heTongTimeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.topInforView.mas_bottom).mas_offset(MARGIN);
        make.left.right.mas_equalTo(_topInforView);
        make.width.mas_offset(SCREEN_WIDTH-MARGIN*2);
    }];
    [_youhuiView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_heTongTimeView.mas_bottom).mas_offset(MARGIN);
        make.left.right.mas_equalTo(_topInforView);
        make.width.mas_offset(SCREEN_WIDTH-MARGIN*2);
    }];
    [_heTongFeiYongView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_heTongTimeView.mas_bottom).mas_offset(MARGIN);
        make.left.right.mas_equalTo(_topInforView);
        make.width.mas_offset(SCREEN_WIDTH-MARGIN*2);
        make.bottom.mas_equalTo(_contentScrollView.mas_bottom).mas_offset(-MARGIN*6);
    }];
    [_topInforView setBoundWidth:0 cornerRadius:6];
    [_heTongFeiYongView setBoundWidth:0 cornerRadius:6];
    [_heTongTimeView setBoundWidth:0 cornerRadius:6];
    
    self.youhuiView.hidden = YES;
}

-(void)setYouhuiArray:(NSArray *)youhuiArray
{
    _youhuiArray = youhuiArray;
    if(!youhuiArray ||
       youhuiArray.count == 0){
        self.youhuiView.hidden = YES;
        [self.para[@"dids"] removeAllObjects];
        [self updateYouhuiItemsView];
        [_heTongFeiYongView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_heTongTimeView.mas_bottom).mas_offset(MARGIN);
            make.left.right.mas_equalTo(_topInforView);
            make.width.mas_offset(SCREEN_WIDTH-MARGIN*2);
            make.bottom.mas_equalTo(_contentScrollView.mas_bottom).mas_offset(-MARGIN*6);
        }];
        return;
    }
    [_heTongFeiYongView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_youhuiView.mas_bottom).mas_offset(MARGIN);
        make.left.right.mas_equalTo(_topInforView);
        make.width.mas_offset(SCREEN_WIDTH-MARGIN*2);
        make.bottom.mas_equalTo(_contentScrollView.mas_bottom).mas_offset(-MARGIN*6);
    }];
    self.youhuiView.hidden = NO;
    [self updateYouhuiItemsView];
}

/**
 根据数据 布局优惠券列表
 */
- (void)updateYouhuiItemsView
{
    [_youhuiItemsBgView removeAllSubviews];
    NSMutableArray *temp = [NSMutableArray array];
    for (int i = 0 ; i < _youhuiArray.count; i ++) {
        HYPayItemView *item = [[HYPayItemView alloc] init];
        HYDiscountInforModel *discounModel = _youhuiArray[i];
        item.descLable.text = discounModel.activeName;
        [_youhuiItemsBgView addSubview:item];
        item.tag = i;
        [item mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(_youhuiItemsBgView);
            make.height.mas_offset(MARGIN*6);
            if (i == 0) {
                make.top.mas_equalTo(_youhuiItemsBgView.mas_top).mas_offset(0);
            }else{
                HYBaseView *lastLable = temp.lastObject;
                make.top.mas_equalTo(lastLable.mas_bottom).mas_offset(MARGIN);
            }
            if(i == _youhuiArray.count - 1){
                make.bottom.mas_equalTo(_youhuiItemsBgView.mas_bottom);
            }
        }];
        [item isHiddenLeftIcon:YES];
        item.lineview.hidden = YES;
        [temp addObject:item];
        [self.youhuiItemsArray addObject:item];
        
        WEAKSELF(self);
        [item bk_whenTapped:^{
            [weakself clickYouHuiItems:item];
        }];
    }
}

/**
 点击优惠券item
 */
- (void)clickYouHuiItems:(HYPayItemView *)items
{
    if (self.lastSelectYouHuiItem.rightIcon.selected &&
        self.lastSelectYouHuiItem == items) {
        items.rightIcon.selected = NO;
    }else{
        self.lastSelectYouHuiItem.rightIcon.selected = NO;
        items.rightIcon.selected = !items.rightIcon.selected;
    }
    self.lastSelectYouHuiItem = items;
    HYDiscountInforModel *discounModel = _youhuiArray[items.tag];
    NSMutableArray *id_Arr = [[NSMutableArray alloc] init];
//    if (self.para[@"dids"]) {
//        [id_Arr addObjectsFromArray:self.para[@"dids"]];
//    }
    if (items.rightIcon.selected) {
        [id_Arr addObject:discounModel.customId];
    }else{
        if ([id_Arr containsObject:discounModel.customId]) {
            [id_Arr removeObject:discounModel.customId];
        }
    }
    self.para[@"dids"] = id_Arr;
}

/**
 上部视图
 */
- (HYBaseView*)topInforView
{
    if (!_topInforView) {
        _topInforView = [[HYBaseView alloc] init];
        _sotreLable = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(15)
                                               text:@""
                                          textColor:HYCOLOR.color_c4];
        _whereLable = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(15)
                                               text:@""
                                          textColor:HYCOLOR.color_c4];
        _zujinLable =  [HYDefaultLabel labelWithFont:SYSTEM_MEDIUMFONT(22)
                                                text:@""
                                           textColor:HYCOLOR.color_c3];
        _zujinLable.textAlignment = NSTextAlignmentRight;
        [_topInforView addSubview:_sotreLable];
        [_topInforView addSubview:_whereLable];
        [_topInforView addSubview:_zujinLable];
        [_sotreLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_topInforView).mas_offset(MARGIN);
            make.top.mas_equalTo(_topInforView).mas_offset(MARGIN*2);
        }];
        [_whereLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_sotreLable.mas_bottom).mas_offset(MARGIN);
            make.left.mas_equalTo(_sotreLable);
            make.bottom.mas_equalTo(_topInforView.mas_bottom).mas_equalTo(-MARGIN*2);
        }];
        [_zujinLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_topInforView.mas_right).mas_offset(-MARGIN);
            make.centerY.mas_equalTo(_topInforView.mas_centerY);
            make.left.mas_equalTo(_sotreLable.mas_right).mas_offset(MARGIN);
        }];
    }
    return _topInforView;
}

- (HYHeTongYouQiXianView*)heTongTimeView
{
    if (!_heTongTimeView) {
        _heTongTimeView = [[HYHeTongYouQiXianView alloc] init];
    }
    return _heTongTimeView;
}

/**
 优惠视图
 */
- (HYBaseView*)youhuiView
{
    if (!_youhuiView) {
        _youhuiView = [[HYBaseView alloc] init];
        HYDefaultLabel *title = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(15)
                                                         text:@"优惠活动:"
                                                    textColor:HYCOLOR.color_c4];
        _youhuiItemsBgView = [[HYBaseView alloc] init];
        _youhuiView.backgroundColor = HYCOLOR.color_c1;
        title.backgroundColor = _youhuiView.backgroundColor;
        [_youhuiView addSubview:title];
        [_youhuiView addSubview:_youhuiItemsBgView];
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_youhuiView.mas_top).mas_offset(MARGIN);
            make.left.mas_equalTo(_youhuiView.mas_left).mas_offset(MARGIN);
        }];
        [_youhuiItemsBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(title.mas_bottom).mas_offset(MARGIN);
            make.left.mas_equalTo(_youhuiView.mas_left);
            make.right.mas_equalTo(_youhuiView.mas_right);
            make.bottom.mas_equalTo(_youhuiView.mas_bottom).mas_offset(-MARGIN);
        }];
        [_youhuiItemsBgView setBoundWidth:0 cornerRadius:6];
        _youhuiItemsBgView.backgroundColor = _youhuiView.backgroundColor;
    }
    return _youhuiView;
}

/**
 合同费项
 */
- (HYBaseView*)heTongFeiYongView
{
    if (!_heTongFeiYongView) {
        _heTongFeiYongView = [[HYBaseView alloc] init];
        HYDefaultLabel *titlelabe = [HYDefaultLabel labelWithFont:SYSTEM_MEDIUMFONT(15)
                                                             text:@"合同费项"
                                                        textColor:HYCOLOR.color_c4];
        titlelabe.tag = 10;
        [_heTongFeiYongView addSubview:titlelabe];
        [titlelabe mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(_heTongFeiYongView).mas_offset(MARGIN);
        }];
        _feiyong_titlelabe = titlelabe;
    }
    return _heTongFeiYongView;
}

- (NSMutableDictionary*)para
{
    if (!_para) {
        _para = [[NSMutableDictionary alloc] init];
    }
    return _para;
}

- (NSMutableArray*)youhuiItemsArray
{
    if (!_youhuiItemsArray) {
        _youhuiItemsArray = [[NSMutableArray alloc] init];
    }
    return _youhuiItemsArray;
}
@end
