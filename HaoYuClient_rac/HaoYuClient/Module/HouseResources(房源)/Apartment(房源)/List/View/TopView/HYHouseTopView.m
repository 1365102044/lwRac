
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
                                                                                imageNamed:@"shopping_point_n"
                                                                                    target:self
                                                                                  selector:@selector(clickBtn:)];
    [_regionbtn setImage:IMAGENAME(@"shopping_point_s") forState:UIControlStateSelected];
    _regionbtn.tag = 10;
    _pricebtn = [HYRightImageButton buttonImageAndTitleWithTitleStringKey:@"价格排序"
                                                                             titleColorNor:HYCOLOR.color_c4
                                                                             titleColorSel:HYCOLOR.color_c4
                                                                             titleColorDis:HYCOLOR.color_c4
                                                                                 titleFont:SYSTEM_REGULARFONT(15)
                                                                                imageNamed:@"shopping_point_n"
                                                                                    target:self
                                                                                  selector:@selector(clickBtn:)];
    [_pricebtn setImage:IMAGENAME(@"shopping_point_s") forState:UIControlStateSelected];
    _pricebtn.tag = 11;
    _yuJIruzhuTimeTextField = [HYDefaultTextField creatDefaultTextField:@"请输入入住时间"
                                                                   font:SYSTEM_REGULARFONT(15)
                                                              textColor:HYCOLOR.color_c4];
    _yuJIruzhuTimeTextField.textFiled.enabled = NO;
    _yuJIruzhuTimeTextField.textFiled.textAlignment = NSTextAlignmentCenter;
    
    HYDefaultButton *clearBtn = [HYDefaultButton buttonWithTitleStringKey:@"清空" titleColor:HYCOLOR.color_c4 titleFont:SYSTEM_REGULARFONT(13) target:self selector:@selector(clickClearBtn:)];
    _clearBtn = clearBtn;
    clearBtn.tag = 15;
    [_clearBtn setBoundWidth:1 cornerRadius:4 boardColor:HYCOLOR.color_c2];
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
    [_yuJIruzhuTimeTextField bk_whenTapped:^{
        [self chooseDate];
    }];
}


- (void)clickClearBtn:(UIButton *)sender
{
    [self updateClearBtnContransWithisShow:NO];
    _yuJIruzhuTimeTextField.textFiled.text = nil;
    [self clickBtn:sender];
}

- (void)chooseDate
{
    [self endEditing:YES];
    [HYDatePickerManager showDatePicker:^(id sender) {
        NSArray *firstArr = [sender componentsSeparatedByString:@" "];
        self.yuJIruzhuTimeTextField.textFiled.text = firstArr.firstObject;
        if (self.clickBtnBlock) {
            self.clickBtnBlock(nil);
        }
        [self updateClearBtnContransWithisShow:YES];
    } DateStyle:DateStyleShowYearMonthDay];
}

- (void)clickBtn:(UIButton *)sender
{
    if (self.clickBtnBlock) {
        self.clickBtnBlock(sender);
    }
    if (sender.tag == 11) {
        sender.selected = !sender.selected;
    }
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
