
//
//  HYHouseTopView.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/25.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYHouseTopView.h"
#import "HYDatePickerManager.h"
#import "HYChooseListView.h"

@interface HYHouseTopView ()
@property (nonatomic, strong) LWHouseListViewModel * houseViewModel;
@property (nonatomic, strong) HYDefaultTextField * yuJIruzhuTimeTextField;
@property (nonatomic, strong) HYRightImageButton *regionbtn;
@property (nonatomic, strong) HYRightImageButton *pricebtn;
@property (nonatomic, strong) HYDefaultButton * clearBtn;
@end
@implementation HYHouseTopView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setUI];
    }
    return self;
}

+ (instancetype)createTopViewBindViewModel:(LWHouseListViewModel *)viewModel
{
    HYHouseTopView *topView = [[HYHouseTopView alloc] init];
    topView.houseViewModel = viewModel;
    [topView confir];
    return topView;
}

- (void)confir
{
    @weakify(self);
    [RACObserve(self.houseViewModel,quyuNameDatas) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self showPopViewWithDataArray:x];
    }];
    [RACObserve(self.houseViewModel, regionTitle) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        x = x ? x : @"全部区域";
        [self.regionbtn setTitle:x forState:UIControlStateNormal];
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
        [self endEditing:YES];
        [HYDatePickerManager showDatePicker:^(id sender) {
            NSArray *firstArr = [sender componentsSeparatedByString:@" "];
            self.houseViewModel.preStayTime = self.yuJIruzhuTimeTextField.textFiled.text = firstArr.firstObject;
            [self.houseViewModel requestListInfor];
            [self updateClearBtnContransWithisShow:YES];
        } DateStyle:DateStyleShowYearMonthDay];
    }];
    [self.yuJIruzhuTimeTextField addGestureRecognizer:tap];
}

- (void)clickRegion
{
    [self.houseViewModel requestQuYuInforByCityId];
    _regionbtn.selected = YES;
}
- (void)clickSortPrice
{
    self.pricebtn.selected = !self.pricebtn.selected;
    [self.houseViewModel updateSortPrice:self.pricebtn.selected];
}
- (void)clickClearBtn
{
    [self updateClearBtnContransWithisShow:NO];
    self.yuJIruzhuTimeTextField.textFiled.text = nil;
    [self.houseViewModel requestListInfor];
}

/**
 弹框
 */
- (void)showPopViewWithDataArray:(NSArray *)DataArray
{
    if (!DataArray || ![DataArray isKindOfClass:[NSArray class]]) return;
    HYHourseChooseListView *listview = [HYHourseChooseListView showChooseListView:DataArray
                                                                    referenceView:self.regionbtn
                                                                    callBackBlock:^(id sender) {
                                                                        if([sender integerValue] == 0){
                                                                            self.houseViewModel.quyuId = @"";
                                                                            [self.regionbtn setTitle:@"全部区域" forState:UIControlStateNormal];
                                                                            self.regionbtn.selected = NO;
                                                                        }else{
                                                                            HYQuYuModel *quyumodel =         self.houseViewModel.quyuModelArray[[sender integerValue]-1];
                                                                            self.houseViewModel.quyuId = quyumodel.customId;
                                                                            [self.regionbtn setTitle:quyumodel.townName forState:UIControlStateNormal];
                                                                        }
                                                                        [self.houseViewModel requestListInfor];
                                                                        self.regionbtn.selected = NO;
                                                                    }];
    listview.clickDismissBlock = ^(id sender) {
        self.regionbtn.selected = NO;
    };
}

- (void)setUI
{
    _regionbtn = [HYRightImageButton buttonImageAndTitleWithTitleStringKey:@"选择区域"
                                                                             titleColorNor:HYCOLOR.color_c4
                                                                             titleColorSel:HYCOLOR.color_c4
                                                                             titleColorDis:HYCOLOR.color_c4
                                                                                 titleFont:SYSTEM_REGULARFONT(15)
                                                                                imageNamed:@"shopping_point_n"
                                                                                    target:self
                                                                                  selector:@selector(clickRegion)];
    [_regionbtn setImage:IMAGENAME(@"shopping_point_s") forState:UIControlStateSelected];
    _pricebtn = [HYRightImageButton buttonImageAndTitleWithTitleStringKey:@"价格排序"
                                                                             titleColorNor:HYCOLOR.color_c4
                                                                             titleColorSel:HYCOLOR.color_c4
                                                                             titleColorDis:HYCOLOR.color_c4
                                                                                 titleFont:SYSTEM_REGULARFONT(15)
                                                                                imageNamed:@"shopping_point_n"
                                                                                    target:self
                                                                                  selector:@selector(clickSortPrice)];
    [_pricebtn setImage:IMAGENAME(@"shopping_point_s") forState:UIControlStateSelected];
    _yuJIruzhuTimeTextField = [HYDefaultTextField creatDefaultTextField:@"请输入入住时间"
                                                                   font:SYSTEM_REGULARFONT(15)
                                                              textColor:HYCOLOR.color_c4];
    _yuJIruzhuTimeTextField.textFiled.enabled = NO;
    _yuJIruzhuTimeTextField.textFiled.textAlignment = NSTextAlignmentCenter;
    
    HYDefaultButton *clearBtn = [HYDefaultButton buttonWithTitleStringKey:@"清空" titleColor:HYCOLOR.color_c4 titleFont:SYSTEM_REGULARFONT(13) target:self selector:@selector(clickClearBtn)];
    _clearBtn = clearBtn;
    [clearBtn setBoundWidth:1 cornerRadius:4 boardColor:HYCOLOR.color_c2];
    [self addSubview:clearBtn];
    [self addSubview:_regionbtn];
    [self addSubview:_pricebtn];
    [self addSubview:_yuJIruzhuTimeTextField];
    
    [_regionbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_equalTo(self);
        make.width.mas_offset(SCREEN_WIDTH * 0.3);
    }];
    [_pricebtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(self);
        make.width.mas_offset(SCREEN_WIDTH * 0.3);
        make.left.mas_equalTo(_regionbtn.mas_right);
    }];
    [self updateClearBtnContransWithisShow:NO];
}
- (void)updateClearBtnContransWithisShow:(BOOL)isShow
{
    [_clearBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(isShow ? MARGIN * 4 : 0, MARGIN*2));
        make.centerY.mas_equalTo(_yuJIruzhuTimeTextField.mas_centerY);
        make.right.mas_equalTo(self.mas_right).mas_offset(-MARGIN);
    }];
    [_yuJIruzhuTimeTextField mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(self);
        make.left.mas_equalTo(_pricebtn.mas_right);
        make.right.mas_equalTo(_clearBtn.mas_left);
    }];
}
@end
