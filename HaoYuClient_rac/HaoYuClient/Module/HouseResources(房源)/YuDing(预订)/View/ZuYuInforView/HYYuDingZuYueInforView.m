//
//  HYYuDingZuYueInforView.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/14.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYYuDingZuYueInforView.h"
#import "HYZuYue_FangJianInforView.h"
#import "HYZuYue_PersonInforView.h"
#import "HYZuYue_HetongFeiXiangView.h"
#import "HYSureBtnView.h"
#import "HYLeftRightArrowView.h"
#import "HYDatePickerManager.h"
#import "HYBaseWebViewController.h"
@interface HYYuDingZuYueInforView ()
@property (nonatomic, strong) UIScrollView * mainScrollView;
@property (nonatomic, strong) HYZuYue_FangJianInforView * fangjianInforView;
@property (nonatomic, strong) HYZuYue_PersonInforView * personInfor;
@property (nonatomic, strong) HYZuYue_HetongFeiXiangView * hetongInforView;
@property (nonatomic, strong) HYSureBtnView * sureBtnView;
@property (nonatomic, assign) BOOL isTongYiBooL;

@end
@implementation HYYuDingZuYueInforView

/**
 检查参数是否合法
 */
- (BOOL)checkPara
{
    if (!self.para[@"endtime"] || self.para[@"endtime"] == nil) {
        ALERT(@"请选择入住时间");
        return NO;
    }
    if (!self.para[@"signTime"] || self.para[@"signTime"] == nil) {
        ALERT(@"请选择预计签约时间");
        return NO;
    }
    if ([[HYStringTool checkString:_personInfor.nameView.rightTextField.textFiled.text] isEqualToString:@""]) {
        ALERT(@"请输入姓名");
        return NO;
    }
    if ([[HYStringTool checkString:_personInfor.phoneView.rightTextField.textFiled.text] isEqualToString:@""]) {
        ALERT(@"请输入手机号");
        return NO;
    }
    if (!_isTongYiBooL) {
        ALERT(@"请同意预定协议");
        return NO;
    }
    self.para[@"zukePhone"] = _personInfor.phoneView.rightTextField.textFiled.text;
    self.para[@"zukeName"] = _personInfor.nameView.rightTextField.textFiled.text;
    self.para[@"money"] = @"1000";
    return YES;
}

- (void)setHouseInfor_M:(HYHouseRescourcesModel *)houseInfor_M
{
    _houseInfor_M = houseInfor_M;
    _fangjianInforView.menDianLable.text = houseInfor_M.houseItemName;
    _fangjianInforView.louDongHaoLable.text = [NSString stringWithFormat:@"%@栋%@号",houseInfor_M.unit,houseInfor_M.fangNo];
    
    _fangjianInforView.baseView.dataArray = @[@{@"left":@"月租",@"right":[NSString stringWithFormat:@"%@元",houseInfor_M.iosRent]},
                                              @{@"left":@"定金",@"right":@"1000元"},
                                              @{@"left":@"*入住日期",@"right":@"请选择入住时间",@"type":@"TF"},
                                              @{@"left":@"*预计签约时间",@"right":@"请选择预计签约时间",@"type":@"TF"},];
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = HYCOLOR.color_c1;
        self.para = [[NSMutableDictionary alloc] init];
        [self setUI];
        _isTongYiBooL = NO;
        [_sureBtnView.coverL bk_whenTapped:^{
            _sureBtnView.icon.selected = !_isTongYiBooL;
            _isTongYiBooL = _sureBtnView.icon.selected;
        }];
        [_sureBtnView bk_whenTapped:^{
            HYBaseWebViewController *xieyi = [[HYBaseWebViewController alloc] init];
            [xieyi setWebUrlWithType:2];
            [self.viewController.navigationController pushViewController:xieyi animated:YES];
        }];
    }
    return self;
}

- (void)setUI
{
    [self addSubview:self.mainScrollView];
    [self.mainScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    WEAKSELF(self);
    _fangjianInforView.baseView.callBackBlock = ^(id sender) {
        HYLeftRightArrowView *temp = sender;
        [weakself endEditing:YES];
        HYDatePickerManager *manager = [HYDatePickerManager showDatePicker:^(id sender) {
            NSArray *firstArr = [sender componentsSeparatedByString:@" "];
            temp.rightTextField.textFiled.text = firstArr.firstObject;
            if ([temp.leftLable.text isEqualToString:@"*入住日期"]) {
                weakself.para[@"endtime"] = temp.rightTextField.textFiled.text;
            }else if ([temp.leftLable.text isEqualToString:@"*预计签约时间"]) {
                weakself.para[@"signTime"] = temp.rightTextField.textFiled.text;
            }
        } DateStyle:DateStyleShowYearMonthDay];
        
        // 根据房间的可租时间 控制入住/签约时间
        NSDateFormatter *farmatter = [[NSDateFormatter alloc] init];
        farmatter.dateFormat = @"yyyy-MM-dd";
        NSDate *nowdate = [NSDate date];
        NSString *nowdateStr = [nowdate stringWithFormat:@"yyyy-MM-dd"];
        NSString *kezuTime = weakself.houseInfor_M.kezuTime;
        
        if (kezuTime && [kezuTime compare:nowdateStr] == NSOrderedDescending) {
            NSDate *mindate = [farmatter dateFromString:weakself.houseInfor_M.kezuTime];
            manager.dateView.minLimitDate = mindate;
        }
        
    };
}

- (UIScrollView*)mainScrollView
{
    if (!_mainScrollView) {
        _mainScrollView = [[UIScrollView alloc] init];

        _fangjianInforView = [[HYZuYue_FangJianInforView alloc] init];
        _personInfor = [[HYZuYue_PersonInforView alloc] init];
        _sureBtnView = [[HYSureBtnView alloc] init];
        [_mainScrollView addSubview:_fangjianInforView];
        [_mainScrollView addSubview:_personInfor];
        [_mainScrollView addSubview:_sureBtnView];
        [_fangjianInforView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_mainScrollView.mas_top).mas_offset(MARGIN);
            make.width.mas_offset(SCREEN_WIDTH -MARGIN*2);
            make.left.mas_equalTo(_mainScrollView.mas_left).mas_offset(MARGIN);
            make.right.mas_equalTo(_mainScrollView.mas_right).mas_offset(-MARGIN);
        }];
        [_personInfor mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_fangjianInforView.mas_bottom).mas_offset(MARGIN);
            make.width.mas_offset(SCREEN_WIDTH -MARGIN*2);
            make.left.mas_equalTo(_mainScrollView.mas_left).mas_offset(MARGIN);
            make.right.mas_equalTo(_mainScrollView.mas_right).mas_offset(-MARGIN);
        }];
        [_sureBtnView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_personInfor.mas_bottom).mas_offset(MARGIN);
            make.width.mas_offset(SCREEN_WIDTH -MARGIN*2);
            make.height.mas_offset(MARGIN*6);
            make.left.mas_equalTo(_mainScrollView.mas_left).mas_offset(MARGIN);
            make.right.mas_equalTo(_mainScrollView.mas_right).mas_offset(-MARGIN);
            make.bottom.mas_equalTo(_mainScrollView.mas_bottom).mas_offset(-MARGIN*5);
        }];
        _sureBtnView.userInteractionEnabled = YES;
        [_sureBtnView setBoundWidth:1 cornerRadius:6 boardColor:HYCOLOR.color_c6];
    }
    return _mainScrollView;
}
@end
