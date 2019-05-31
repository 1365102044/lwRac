//
//  HYYuDingSureCommitInforView.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/14.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYYuDingSureCommitInforView.h"
#import "HYZuYue_InforBaseView.h"
#import "HYZuYue_FangJianInforView.h"
#import "HYZuYue_PersonInforView.h"
#import "HYZuYue_HetongFeiXiangView.h"
#import "HYZuYue_TipsView.h"
#import "HYLeftRightArrowView.h"
@interface HYYuDingSureCommitInforView ()
@property (nonatomic, strong) UIScrollView * mainScrollView;
@property (nonatomic, strong) HYZuYue_FangJianInforView * fangjianInforView;
@property (nonatomic, strong) HYZuYue_PersonInforView * personInfor;
@property (nonatomic, strong) HYZuYue_HetongFeiXiangView * hetongInforView;
@property (nonatomic, strong) HYZuYue_TipsView * tipsView;

@end
@implementation HYYuDingSureCommitInforView
- (void)setHouseInfor_M:(HYHouseRescourcesModel *)houseInfor_M
{
    _houseInfor_M = houseInfor_M;
    _fangjianInforView.menDianLable.text = houseInfor_M.houseItemName;
    _fangjianInforView.louDongHaoLable.text = [NSString stringWithFormat:@"%@栋%@号",houseInfor_M.unit,houseInfor_M.fangNo];
    NSString *nowStr = [NSDate ex_stringWithDate:[NSDate date] formatterString:@"yyyy-MM-dd" timeZoneStr:nil];
   NSDate *enddate = [[HYStringTool share] datejishuangYear:0 Month:0 Day:7 withData:[NSDate date]];
    NSString *endStr = [enddate stringWithFormat:@"yyyy-MM-dd"];
    NSString *youxiaoqistr = [NSString stringWithFormat:@"%@ —— %@",nowStr,endStr];
    _endtime = endStr;
    _fangjianInforView.baseView.dataArray = @[@{@"left":@"月租",@"right":[NSString stringWithFormat:@"%@元",houseInfor_M.iosRent]},
                                              @{@"left":@"定金",@"right":[NSString stringWithFormat:@"%@元",houseInfor_M.money]},
                                              @{@"left":@"入住日期",@"right":[HYStringTool checkString:houseInfor_M.ruzhuTime]},
                                              @{@"left":@"预订有效期",@"right":youxiaoqistr}];
    //个人信息
    _personInfor.nameView.rightTextField.textFiled.text = houseInfor_M.zukeName;
    _personInfor.phoneView.rightTextField.textFiled.text = houseInfor_M.zukePhone;
    
    //房间信息
    NSMutableArray *temp_A = [[NSMutableArray alloc] init];
    NSDictionary *infor_dic =  houseInfor_M.fee.firstObject;
    NSArray *allkey_A = infor_dic.allKeys;
    for (NSString *keys in allkey_A) {
        NSMutableDictionary *temp_dict = [[NSMutableDictionary alloc] init];
        temp_dict[@"left"] = StringWithFormat(keys);
        temp_dict[@"right"] = StringWithFormat(infor_dic[keys]);
        [temp_A addObject:temp_dict];
    }
    _hetongInforView.baseView.dataArray = temp_A;
    
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
    [self addSubview:self.mainScrollView];
    [self.mainScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    [self setTestData];
    
    _fangjianInforView.baseView.callBackBlock = ^(id sender) {
        HYLeftRightArrowView *temp = sender;
        LWLog(@"++++++%@",temp.leftLable.text);
    };
}

- (void)setTestData
{
//    _fangjianInforView.baseView.dataArray = @[@{@"left":@"月租",@"right":@"1500元"},
//                                              @{@"left":@"定金",@"right":@"700元"},
//                                              @{@"left":@"入住日期",@"right":@"2018-6-30"},
//                                              @{@"left":@"预订有效期",@"right":@"2018.6.15-2018.6.30"}];
    
}

- (UIScrollView*)mainScrollView
{
    if (!_mainScrollView) {
        _mainScrollView = [[UIScrollView alloc] init];
        
        _fangjianInforView = [[HYZuYue_FangJianInforView alloc] init];
        _personInfor = [[HYZuYue_PersonInforView alloc] init];
        _hetongInforView = [[HYZuYue_HetongFeiXiangView alloc] init];
        _tipsView = [[HYZuYue_TipsView alloc] init];
        [_mainScrollView addSubview:_tipsView];
        [_mainScrollView addSubview:_fangjianInforView];
        [_mainScrollView addSubview:_personInfor];
        [_mainScrollView addSubview:_hetongInforView];
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
//            make.bottom.mas_equalTo(_mainScrollView.mas_bottom).mas_offset(-MARGIN*5);
        }];
        [_hetongInforView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_personInfor.mas_bottom).mas_offset(MARGIN);
            make.width.mas_offset(SCREEN_WIDTH -MARGIN*2);
            make.left.mas_equalTo(_mainScrollView.mas_left).mas_offset(MARGIN);
            make.right.mas_equalTo(_mainScrollView.mas_right).mas_offset(-MARGIN);
//            make.bottom.mas_equalTo(_mainScrollView.mas_bottom).mas_offset(-MARGIN*5);
        }];
        [_tipsView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_hetongInforView.mas_bottom).mas_offset(MARGIN);
            make.width.mas_offset(SCREEN_WIDTH -MARGIN*2);
            make.left.mas_equalTo(_mainScrollView.mas_left).mas_offset(MARGIN);
            make.right.mas_equalTo(_mainScrollView.mas_right).mas_offset(-MARGIN);
            make.bottom.mas_equalTo(_mainScrollView.mas_bottom).mas_offset(-MARGIN*5);
        }];
    }
    return _mainScrollView;
}
@end

