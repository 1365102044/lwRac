
//
//  HYHouseTopView.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/25.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYHouseTopView.h"
#import "HYRightImageButton.h"
#import "HYDefaultTextField.h"
#import "HYDatePickerManager.h"
@interface HYHouseTopView ()
@property (nonatomic, strong) HYDefaultTextField * yuJIruzhuTimeTextField;
@property (nonatomic, strong) HYRightImageButton *regionbtn;
@property (nonatomic, strong) HYRightImageButton *pricebtn;

@end
@implementation HYHouseTopView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}
- (void)setUI
{
    _regionbtn = [HYRightImageButton buttonImageAndTitleWithTitleStringKey:@"选择区域"
                                                                             titleColorNor:HYCOLOR.color_c4
                                                                             titleColorSel:HYCOLOR.color_c4
                                                                             titleColorDis:HYCOLOR.color_c4
                                                                                 titleFont:SYSTEM_REGULARFONT(15)
                                                                                imageNamed:@"shopping_point"
                                                                                    target:self
                                                                                  selector:@selector(clickBtn:)];
    
    _pricebtn = [HYRightImageButton buttonImageAndTitleWithTitleStringKey:@"价格排序"
                                                                             titleColorNor:HYCOLOR.color_c4
                                                                             titleColorSel:HYCOLOR.color_c4
                                                                             titleColorDis:HYCOLOR.color_c4
                                                                                 titleFont:SYSTEM_REGULARFONT(15)
                                                                                imageNamed:@"shopping_point"
                                                                                    target:self
                                                                                  selector:@selector(clickBtn:)];
    _yuJIruzhuTimeTextField = [HYDefaultTextField creatDefaultTextField:@"请输入入住时间"
                                                                   font:SYSTEM_REGULARFONT(15)
                                                              textColor:HYCOLOR.color_c4];
    _yuJIruzhuTimeTextField.textFiled.enabled = NO;
    _yuJIruzhuTimeTextField.textFiled.textAlignment = NSTextAlignmentCenter;
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
    [_yuJIruzhuTimeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.mas_equalTo(self);
        make.width.mas_offset(SCREEN_WIDTH * 0.4);
    }];
    
    [_yuJIruzhuTimeTextField bk_whenTapped:^{
        [self chooseDate];
    }];
}

- (void)chooseDate
{
    [self endEditing:YES];
    [HYDatePickerManager showDatePicker:^(id sender) {
        NSArray *firstArr = [sender componentsSeparatedByString:@" "];
        self.yuJIruzhuTimeTextField.textFiled.text = firstArr.firstObject;
    } DateStyle:DateStyleShowYearMonthDay];
}

- (void)clickBtn:(UIButton *)sender
{
    
}
@end
