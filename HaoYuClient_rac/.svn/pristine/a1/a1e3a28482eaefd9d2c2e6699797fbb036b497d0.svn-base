//
//  HYQianYueSureInforView.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/20.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYQianYueSureInforView.h"
#import "HYLeftRightArrowView.h"
#import "HYTongZhuRenView.h"
@interface HYQianYueSureInforView ()
{
    CGFloat HEI;
}
@property (nonatomic, strong) HYBaseView * fangjianInforView;
@property (nonatomic, strong) HYBaseView * heTongInforView;
@property (nonatomic, strong) HYBaseView * personInforView;
@property (nonatomic, strong) HYBaseView * contactInforView;
@property (nonatomic, strong) HYTongZhuRenView * tongzhurenInforView;
@property (nonatomic, strong) HYBaseScrollView * contentScrollView;

@property (nonatomic, strong) HYLeftRightArrowView * project_L;
@property (nonatomic, strong) HYLeftRightArrowView * huxing_L;
@property (nonatomic, strong) HYLeftRightArrowView * fanghao_L;

@property (nonatomic, strong) HYLeftRightArrowView * hetongStartEnd_L;
@property (nonatomic, strong) HYLeftRightArrowView * payType_L;

@property (nonatomic, strong) HYLeftRightArrowView * name_L;
@property (nonatomic, strong) HYLeftRightArrowView * phone_L;
@property (nonatomic, strong) HYLeftRightArrowView * sfzNo_L;
@property (nonatomic, strong) HYLeftRightArrowView * sfzType_L;

@property (nonatomic, strong) HYLeftRightArrowView * contectName_L;
@property (nonatomic, strong) HYLeftRightArrowView * contectPhone_L;

@end
@implementation HYQianYueSureInforView

- (void)setDataDict:(NSMutableDictionary *)dataDict
{
    _dataDict = dataDict;
    _project_L.rightLable.text = dataDict[@"houseItemName"];
    _huxing_L.rightLable.text = dataDict[@"roomTypeName"];
    _fanghao_L.rightLable.text = dataDict[@"fangNo"];
    NSString *str =  [NSString stringWithFormat:@"%@—%@",[HYStringTool checkString:_dataDict[@"beginDate"]],[HYStringTool checkString:_dataDict[@"endDate"]]];
    _hetongStartEnd_L.rightLable.text = str;
    _payType_L.rightLable.text = dataDict[@"zhifuTypeKey"];
    
    _name_L.rightLable.text = dataDict[@"nickname"];
    _phone_L.rightLable.text = dataDict[@"phone"];
    _sfzNo_L.rightLable.text = dataDict[@"sfzNo"];
    _sfzType_L.rightLable.text = [self returnIdCardType];
    _contectName_L.rightLable.text = dataDict[@"emergencyPeo"];
    _contectPhone_L.rightLable.text = dataDict[@"emergencyPeoPhone"];
    _tongzhurenInforView.dataArr = dataDict[@"cotenantList"];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
        self.backgroundColor = HYCOLOR.color_c1;
    }
    return self;
}

- (void)setUI
{
    [self addSubview:self.contentScrollView];
    [self.contentScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self);
        make.top.mas_equalTo(self.mas_top).mas_offset(MARGIN);
    }];
}

/**
 添加视图
 */
- (void)setSubsUI{
    HEI = MARGIN*4;
//    [_contentScrollView addSubview:self.titleView];
    [_contentScrollView addSubview:self.fangjianInforView];
    [_contentScrollView addSubview:self.heTongInforView];
    [_contentScrollView addSubview:self.personInforView];
    [_contentScrollView addSubview:self.contactInforView];
    [_contentScrollView addSubview:self.tongzhurenInforView];
    
    [self.fangjianInforView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_contentScrollView.mas_top).mas_offset(0);
        make.left.mas_equalTo(_contentScrollView).mas_offset(MARGIN);
        make.right.mas_equalTo(_contentScrollView.mas_right).mas_offset(-MARGIN);
        make.width.mas_offset(SCREEN_WIDTH-MARGIN*2);
    }];
    [self.heTongInforView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_fangjianInforView.mas_bottom).mas_offset(MARGIN);
        make.left.right.mas_equalTo(_fangjianInforView);
        make.width.mas_offset(SCREEN_WIDTH-MARGIN*2);
    }];
    [self.personInforView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_heTongInforView.mas_bottom).mas_offset(MARGIN);
        make.left.right.mas_equalTo(_fangjianInforView);
        make.width.mas_offset(SCREEN_WIDTH-MARGIN*2);
    }];
    [self.contactInforView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_personInforView.mas_bottom).mas_offset(MARGIN);
        make.left.right.mas_equalTo(_fangjianInforView);
        make.width.mas_offset(SCREEN_WIDTH-MARGIN*2);
    }];
    [self.tongzhurenInforView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_contactInforView.mas_bottom).mas_offset(MARGIN);
        make.left.right.mas_equalTo(_fangjianInforView);
        make.width.mas_offset(SCREEN_WIDTH-MARGIN*2);
        make.bottom.mas_equalTo(_contentScrollView.mas_bottom).mas_offset(-MARGIN*3);
    }];
//    [_titleView setBoundWidth:0 cornerRadius:6];
    [_fangjianInforView setBoundWidth:0 cornerRadius:6];
    [_heTongInforView setBoundWidth:0 cornerRadius:6];
    [_personInforView setBoundWidth:0 cornerRadius:6];
    [_contactInforView setBoundWidth:0 cornerRadius:6];
    [_tongzhurenInforView setBoundWidth:0 cornerRadius:6];
}

/**
 添加主视图模块
 */
- (UIScrollView*)contentScrollView
{
    if (!_contentScrollView) {
        _contentScrollView = [[HYBaseScrollView alloc] init];
        _contentScrollView.backgroundColor = HYCOLOR.color_c1;
        [self setSubsUI];
    }
    return _contentScrollView;
}
/**
 房源信息
 */
- (HYBaseView*)fangjianInforView
{
    if (!_fangjianInforView) {
        _fangjianInforView = [[HYBaseView alloc] init];
        HYLeftRightArrowView *fangyuanxiangmu = [HYLeftRightArrowView creatLeftRightLableArrowViewWithLeftStr:@"房源项目"
                                                                                                     rightStr:[HYStringTool checkString:_dataDict[@"houseItemName"]]
                                                                                                showArrowIcon:NO
                                                                                                CallBackBlock:nil];
        HYLeftRightArrowView *fangxing = [HYLeftRightArrowView creatLeftRightLableArrowViewWithLeftStr:@"房型"
                                                                                              rightStr:[HYStringTool checkString:_dataDict[@"roomTypeName"]]
                                                                                         showArrowIcon:NO
                                                                                         CallBackBlock:nil];
        HYLeftRightArrowView *fanghao = [HYLeftRightArrowView creatLeftRightLableArrowViewWithLeftStr:@"房号"
                                                                                             rightStr:[HYStringTool checkString:_dataDict[@"fangNo"]]
                                                                                        showArrowIcon:NO
                                                                                        CallBackBlock:nil];
        [_fangjianInforView addSubview:fangyuanxiangmu];
        [_fangjianInforView addSubview:fangxing];
        [_fangjianInforView addSubview:fanghao];
        [fangyuanxiangmu mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_fangjianInforView.mas_left).mas_offset(MARGIN);
            make.top.mas_equalTo(_fangjianInforView.mas_top).mas_offset(MARGIN);
            make.right.mas_equalTo(_fangjianInforView.mas_right).mas_offset(-MARGIN);
            make.height.mas_offset(HEI);
        }];
        [fangxing mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(fangyuanxiangmu.mas_bottom).mas_offset(0);
            make.left.right.mas_equalTo(fangyuanxiangmu);
            make.height.mas_offset(HEI);
        }];
        [fanghao mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(fangyuanxiangmu);
            make.top.mas_equalTo(fangxing.mas_bottom).mas_offset(0);
            make.height.mas_offset(HEI);
            make.bottom.mas_equalTo(_fangjianInforView.mas_bottom).mas_offset(-MARGIN);
        }];
        _project_L = fangyuanxiangmu;
        _huxing_L = fangxing;
        _fanghao_L = fanghao;
    }
    return _fangjianInforView;
}

/**
 合同信息
 */
- (HYBaseView*)heTongInforView
{
    if (!_heTongInforView) {
        _heTongInforView = [[HYBaseView alloc] init];
        HYDefaultLabel *title = [HYDefaultLabel labelWithFont:SYSTEM_MEDIUMFONT(15)
                                                         text:@"合同期限"
                                                    textColor:HYCOLOR.color_c4];
        HYLeftRightArrowView *qizhiriqi = [HYLeftRightArrowView creatLeftRightLableArrowViewWithLeftStr:@"起止日期"
                                                                                               rightStr:[
                                          NSString stringWithFormat:@"%@—%@",[HYStringTool checkString:_dataDict[@"beginDate"]],[HYStringTool checkString:_dataDict[@"endDate"]]]
                                                                                          showArrowIcon:NO
                                                                                          CallBackBlock:nil];
        qizhiriqi.rightLable.width = MARGIN*34;
        HYLeftRightArrowView *shoufeifangshi = [HYLeftRightArrowView creatLeftRightLableArrowViewWithLeftStr:@"缴费方式"
                                                                                                    rightStr:_dataDict[@"zhifuTypeKey"]
                                                                                               showArrowIcon:NO
                                                                                               CallBackBlock:nil];
        [_heTongInforView addSubview:title];
        [_heTongInforView addSubview:qizhiriqi];
        [_heTongInforView addSubview:shoufeifangshi];
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_heTongInforView.mas_left).mas_offset(MARGIN);
            make.top.mas_equalTo(_heTongInforView.mas_top).mas_offset(MARGIN);
        }];
        [qizhiriqi mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_heTongInforView.mas_left).mas_offset(MARGIN);
            make.top.mas_equalTo(title.mas_bottom).mas_offset(MARGIN);
            make.right.mas_equalTo(_heTongInforView.mas_right).mas_offset(-MARGIN);
            make.height.mas_offset(HEI);
        }];
        [shoufeifangshi mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(qizhiriqi);
            make.top.mas_equalTo(qizhiriqi.mas_bottom).mas_offset(0);
            make.height.mas_offset(HEI);
            make.bottom.mas_equalTo(_heTongInforView.mas_bottom).mas_offset(-MARGIN);
        }];
        _hetongStartEnd_L = qizhiriqi;
        _payType_L = shoufeifangshi;
    }
    return _heTongInforView;
}

/**
 个人信息
 */
- (HYBaseView *)personInforView
{
    if (!_personInforView) {
        _personInforView = [[HYBaseView alloc] init];
        HYDefaultLabel *title = [HYDefaultLabel labelWithFont:SYSTEM_MEDIUMFONT(15)
                                                         text:@"个人信息"
                                                    textColor:HYCOLOR.color_c4];
        HYLeftRightArrowView *name = [HYLeftRightArrowView creatLeftRightLableArrowViewWithLeftStr:@"姓名"
                                                                                               rightStr:[HYStringTool checkString:_dataDict[@"nickname"]]
                                                                                          showArrowIcon:NO
                                                                                          CallBackBlock:nil];
        HYLeftRightArrowView *phone = [HYLeftRightArrowView creatLeftRightLableArrowViewWithLeftStr:@"手机号码"
                                                                                           rightStr:[HYStringTool checkString:_dataDict[@"phone"]]
                                                                                               showArrowIcon:NO
                                                                                               CallBackBlock:nil];
        HYLeftRightArrowView *zhengjianleixing = [HYLeftRightArrowView creatLeftRightLableArrowViewWithLeftStr:@"证件类型"
                                                                                           rightStr:[HYStringTool checkString:[self returnIdCardType]]
                                                                                      showArrowIcon:NO
                                                                                      CallBackBlock:nil];
        HYLeftRightArrowView *haoma = [HYLeftRightArrowView creatLeftRightLableArrowViewWithLeftStr:@"身份证号码"
                                                                                           rightStr:[HYStringTool checkString:_dataDict[@"sfzNo"]]
                                                                                      showArrowIcon:NO
                                                                                      CallBackBlock:nil];
        [_personInforView addSubview:title];
        [_personInforView addSubview:name];
        [_personInforView addSubview:phone];
        [_personInforView addSubview:zhengjianleixing];
        [_personInforView addSubview:haoma];
        
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_personInforView.mas_left).mas_offset(MARGIN);
            make.top.mas_equalTo(_personInforView.mas_top).mas_offset(MARGIN);
        }];
        [name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_personInforView.mas_left).mas_offset(MARGIN);
            make.top.mas_equalTo(title.mas_bottom).mas_offset(MARGIN);
            make.right.mas_equalTo(_personInforView.mas_right).mas_offset(-MARGIN);
            make.height.mas_offset(HEI);
        }];
        [phone mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(name);
            make.top.mas_equalTo(name.mas_bottom).mas_offset(0);
            make.height.mas_offset(HEI);
        }];
        [zhengjianleixing mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(name);
            make.top.mas_equalTo(phone.mas_bottom).mas_offset(0);
            make.height.mas_offset(HEI);
        }];
        [haoma mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(zhengjianleixing);
            make.top.mas_equalTo(zhengjianleixing.mas_bottom).mas_offset(0);
            make.height.mas_offset(HEI);
            make.bottom.mas_equalTo(_personInforView.mas_bottom).mas_offset(-MARGIN);
        }];
        _name_L = name;
        _phone_L = phone;
        _sfzNo_L = haoma;
        _sfzType_L = zhengjianleixing;
    }
    return _personInforView;
}

/**
 紧急联系人
 */
- (HYBaseView*)contactInforView
{
    if (!_contactInforView) {
        _contactInforView = [[HYBaseView alloc] init];
        HYLeftRightArrowView *name = [HYLeftRightArrowView creatLeftRightLableArrowViewWithLeftStr:@"紧急联系人"
                                                                                                      rightStr:[HYStringTool checkString:_dataDict[@"emergencyPeo"]]
                                                                                                 showArrowIcon:NO
                                                                                                 CallBackBlock:nil];
        HYLeftRightArrowView *phone = [HYLeftRightArrowView creatLeftRightLableArrowViewWithLeftStr:@"紧急联系人电话"
                                                                                           rightStr:[HYStringTool checkString:_dataDict[@"emergencyPeoPhone"]]
                                                                                      showArrowIcon:NO
                                                                                      CallBackBlock:nil];
        [_contactInforView addSubview:name];
        [_contactInforView addSubview:phone];
        [name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_contactInforView.mas_left).mas_offset(MARGIN);
            make.right.mas_equalTo(_contactInforView.mas_right).mas_offset(-MARGIN);
            make.top.mas_equalTo(_contactInforView.mas_top).mas_offset(MARGIN);
            make.height.mas_offset(HEI);
        }];
        [phone mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(name);
            make.top.mas_equalTo(name.mas_bottom);
            make.height.mas_offset(HEI);
            make.bottom.mas_equalTo(_contactInforView.mas_bottom).mas_offset(-MARGIN);
        }];
        _contectName_L = name;
        _contectPhone_L = phone;
    }
    return _contactInforView;
}

/**
 合住人
 */
- (HYTongZhuRenView*)tongzhurenInforView
{
    if (!_tongzhurenInforView) {
        _tongzhurenInforView = [[HYTongZhuRenView alloc] initWithFrame:CGRectZero sourcevc:self.viewController];
        _tongzhurenInforView.isHiddenAdd = YES;
    }
    return _tongzhurenInforView;
}

////证件类型：1.身份证，2.护照，3.港澳通行证，4.台湾同胞证
- (NSString *)returnIdCardType
{
    NSInteger index = [_dataDict[@"certificateType"] integerValue];
    switch (index) {
        case 1:
            return @"身份证";
            break;
        case 2:
            return @"护照";
            break;
        case 3:
            return @"港澳通行证";
            break;
        case 4:
            return @"台湾同胞证";
            break;
        default:
            return @"身份证";
            break;
    }
}

@end
