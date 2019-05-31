//
//  HYHeTongYouQiXianView.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/20.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYHeTongYouQiXianView.h"
#import "HYLeftRightArrowView.h"
#import "HYChooseListView.h"
#import "HYDatePickerManager.h"
#import "HYHouseProjectInforTool.h"
#import "NSDate+Extension.h"
@interface HYHeTongYouQiXianView ()
@property (nonatomic, strong) HYLeftRightArrowView *qizhiriqi;
@property (nonatomic, strong) HYLeftRightArrowView *qianyueshichang;
@property (nonatomic, strong) HYDefaultButton * lastSelectBtn;
@property (nonatomic, strong) HYLeftRightArrowView *fukuanfangshi;
@property (nonatomic, strong) HYLeftRightArrowView * gudingfukuanriqi;
@property (nonatomic, strong) HYBaseView * qizhiriqiView;
@property (nonatomic, strong) HYDefaultTextField * startTime_TF;
@property (nonatomic, strong) HYDefaultTextField * endTime_TF;
@property (nonatomic, strong) NSDate * endTime_Date;
@property (nonatomic, strong) NSDate * startTime_Date;
@property (nonatomic, strong) NSMutableArray * payTypes_key;
@property (nonatomic, strong) NSMutableArray * payTypes_Id;
//时常 btn
@property (nonatomic, strong) NSMutableArray * shiChangBtnArray;

@end

@implementation HYHeTongYouQiXianView

/**
 付款方式
 */
- (void)chooseFukuanfangshi
{
    if (self.payTypes_Id.count == 0 || self.payTypes_key.count == 0) {
        [self getPayTypeDatas];
        return;
    }
    //付款方式 根据 签约时长限制
    NSMutableArray *tem_key = [[NSMutableArray alloc] initWithArray:self.payTypes_key];
    NSMutableArray *tem_id = [[NSMutableArray alloc] initWithArray:self.payTypes_Id];
    if (self.lastSelectBtn.tag == 1) {
        NSInteger index_banYear =  [tem_key indexOfObject:@"半年付"];
        [tem_key removeObjectAtIndex:index_banYear];
        [tem_id removeObjectAtIndex:index_banYear];
        NSInteger index_Year =  [tem_key indexOfObject:@"全年付"];
        [tem_key removeObjectAtIndex:index_Year];
        [tem_id removeObjectAtIndex:index_Year];
        NSInteger index_jiFu =  [tem_key indexOfObject:@"季付"];
        [tem_key removeObjectAtIndex:index_jiFu];
        [tem_id removeObjectAtIndex:index_jiFu];
    }else if (self.lastSelectBtn.tag == 2) {
        NSInteger index_banYear =  [tem_key indexOfObject:@"半年付"];
        [tem_key removeObjectAtIndex:index_banYear];
        [tem_id removeObjectAtIndex:index_banYear];
        NSInteger index_Year =  [tem_key indexOfObject:@"全年付"];
        [tem_key removeObjectAtIndex:index_Year];
        [tem_id removeObjectAtIndex:index_Year];
    }else if (self.lastSelectBtn.tag == 3){
        NSInteger index_Year =  [tem_key indexOfObject:@"全年付"];
        [tem_key removeObjectAtIndex:index_Year];
        [tem_id removeObjectAtIndex:index_Year];
    }
    
    [HYChooseListView showChooseListView:tem_key callBackBlock:^(id sender) {
        NSInteger index = [sender  integerValue];
        _fukuanfangshi.rightLable.text = tem_key[index];
        self.param[@"zhifuTypeId"]  = tem_id[index];
        self.param[@"payTypeId"]    = tem_id[index];
        self.param[@"zhifuTypeKey"] = tem_key[index];
    }];
}

- (void)getPayTypeDatas
{
    [[HYHouseProjectInforTool new] requestQianYuePayTypeMarkCallBackBlock:^(id sender) {
        _payTypes_key = [[NSMutableArray alloc] init];
        _payTypes_Id = [[NSMutableArray alloc] init];
        NSArray *paydata  = [HYPublic_LocalData share].payTypeMarkArray;
        for (NSDictionary *dict in paydata) {
            [_payTypes_key addObject:dict[@"key"]];
            [_payTypes_Id addObject:dict[@"id"]];
        }
    }];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self getPayTypeDatas];
        
        HYDefaultLabel *titlelable = [HYDefaultLabel labelWithFont:SYSTEM_MEDIUMFONT(15)
                                                              text:@"合同期限"
                                                         textColor:HYCOLOR.color_c4];
        HYLeftRightArrowView *fukuanfangshi = [HYLeftRightArrowView creatLeftRightLableArrowViewWithLeftStr:@"*付款方式:"
                                                                                                   rightStr:@"选择付款方式"
                                                                                              showArrowIcon:YES
                                                                                              CallBackBlock:^(id sender) {
                                                                                                  [self chooseFukuanfangshi];
                                                                                              }];
        HYLeftRightArrowView *gudingfukuanriqi = [HYLeftRightArrowView creatLeftRightLableArrowViewWithLeftStr:@"*固定付款日期:"
                                                                                                      rightStr:@"每月1号"
                                                                                                 showArrowIcon:NO
                                                                                                 CallBackBlock:^(id sender) {
                                                                                                     
                                                                                                 }];
        _gudingfukuanriqi = gudingfukuanriqi;
        _fukuanfangshi = fukuanfangshi;
        [self addSubview:titlelable];
        [self addSubview:self.qizhiriqiView];
        [self addSubview:self.qianyueshichang];
        [self addSubview:fukuanfangshi];
        [self addSubview:gudingfukuanriqi];
        
        [titlelable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.mas_equalTo(self).mas_offset((MARGIN));
        }];
        [self.qizhiriqiView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(titlelable);
            make.right.mas_equalTo(self.mas_right).mas_offset(-MARGIN);
            make.top.mas_equalTo(titlelable.mas_bottom).mas_offset(MARGIN);
            make.height.mas_offset(MARGIN*4);
        }];
        [self.qianyueshichang mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(_qizhiriqiView);
            make.top.mas_equalTo(_qizhiriqiView.mas_bottom).mas_offset(MARGIN);
            make.height.mas_equalTo(_qizhiriqiView.mas_height);
        }];
        [fukuanfangshi mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(_qizhiriqiView);
            make.top.mas_equalTo(self.qianyueshichang.mas_bottom).mas_offset(MARGIN);
            make.height.mas_equalTo(_qizhiriqiView.mas_height);
        }];
        [gudingfukuanriqi mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(_qizhiriqiView);
            make.top.mas_equalTo(fukuanfangshi.mas_bottom).mas_offset(MARGIN);
            make.height.mas_equalTo(_qizhiriqiView.mas_height);
            make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-MARGIN);
        }];
        
        _startTime_TF.text =  [NSDate ex_stringWithDate:[NSDate date] formatterString:@"YYYY-MM-dd" timeZoneStr:@"Asia"];
        _startTime_Date = [NSDate date];
        [self clickItems:self.shiChangBtnArray[2]];
          _endTime_Date =  [[HYStringTool share] datejishuangYear:1 Month:0 Day:-1 withData:_startTime_Date];
    }
    return self;
}

/**
 选择时间
 */
- (void)chooseDateWithType:(NSInteger )type
{
    NSDate *temp_date = (type == 1) ? _startTime_Date : _endTime_Date;
    HYDatePickerManager *manger = [HYDatePickerManager showDatePick:^(id sender) {
        NSArray *firstArr = [sender componentsSeparatedByString:@" "];
        if (type == 1) {
            self.startTime_TF.textFiled.text = firstArr.firstObject;
            self.param[@"beginDate"] = self.startTime_TF.textFiled.text;
        }else if(type == 2){
            self.endTime_TF.textFiled.text = firstArr.firstObject;
            self.param[@"endDate"] = self.endTime_TF.textFiled.text;
        }
        [self checkShiChangforShiChangBtnSel:type];
    } scrollToDate:temp_date DateStyle:DateStyleShowYearMonthDay];
    manger.callBackDateBlock = ^(id sender) {
        if (type == 2) {
            _endTime_Date = (NSDate *)sender;
        }else if (type == 1){
            _startTime_Date = (NSDate *)sender;
        }
    };
}

/**
 切换签约时长
 */
- (void)clickItems:(HYDefaultButton *)sender
{
    //重新选择
    _fukuanfangshi.rightLable.text = @"选择付款方式";
    [self.param removeObjectForKey:@"zhifuTypeId"];
    [self.param removeObjectForKey:@"payTypeId"];
    [self.param removeObjectForKey:@"zhifuTypeKey"];
    
    self.lastSelectBtn.selected = NO;
    sender.selected = YES;
    self.lastSelectBtn = sender;
    NSDate *Temp_Date = _startTime_Date;
    if (!Temp_Date) {
        return;
    }
    if (sender.tag == 1) {
        NSDate *nowDate =  [[HYStringTool share] datejishuangYear:0 Month:1 Day:-1 withData:Temp_Date];
        self.endTime_TF.textFiled.text =  [nowDate stringWithFormat:@"yyyy-MM-dd"];
    }else if (sender.tag == 2){
        NSDate *nowDate =  [[HYStringTool share] datejishuangYear:0 Month:3 Day:-1 withData:Temp_Date];
        self.endTime_TF.textFiled.text =  [nowDate stringWithFormat:@"yyyy-MM-dd"];
    }else if (sender.tag == 3){
        NSDate *nowDate =  [[HYStringTool share] datejishuangYear:0 Month:6 Day:-1 withData:Temp_Date];
        self.endTime_TF.textFiled.text =  [nowDate stringWithFormat:@"yyyy-MM-dd"];
    }else if (sender.tag == 4){
        NSDate *nowDate =  [[HYStringTool share] datejishuangYear:1 Month:0 Day:-1 withData:Temp_Date];
        self.endTime_TF.textFiled.text =  [nowDate stringWithFormat:@"yyyy-MM-dd"];
    }
    self.param[@"endDate"] = self.endTime_TF.textFiled.text;
    _endTime_TF.text = self.endTime_TF.textFiled.text;
    self.param[@"beginDate"] = _startTime_TF.text;
    //获取优惠信息
    POST_NOTI(GET_DISCOUNTINFOR_BY_HETONGSTARADNENDTIEM_KEY, self.param);
}


- (HYLeftRightArrowView*)qianyueshichang
{
    if (!_qianyueshichang) {
        _qianyueshichang = [HYLeftRightArrowView creatLeftRightLableArrowViewWithLeftStr:@"*签约时长:"
                                                                                rightStr:@""
                                                                           showArrowIcon:NO
                                                                           CallBackBlock:^(id sender) {
                                                                               
                                                                           }];
        HYBaseView *chooseView = [self chooseShiChangView];
        [_qianyueshichang addSubview:chooseView];
        [chooseView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_qianyueshichang.mas_right);
            make.centerY.mas_equalTo(_qianyueshichang.mas_centerY);
        }];
        
    }
    return _qianyueshichang;
}

/**
 签约时长 试图布局
 */
- (HYBaseView *)chooseShiChangView
{
    self.shiChangBtnArray = [[NSMutableArray alloc] init];
    HYBaseView *tem = [[HYBaseView alloc] init];
    NSArray *arr = @[@"一年",@"半年",@"三个月",@"一个月"];
    for (int i = 0 ; i < arr.count; i ++) {
        HYDefaultButton *item = [HYDefaultButton buttonWithTitleStringKey:arr[i]
                                                               titleColor:HYCOLOR.color_c4
                                                                titleFont:SYSTEM_REGULARFONT(14)
                                                                   target:self
                                                                 selector:@selector(clickItems:)];
        item.tag = arr.count - i;
        [tem addSubview:item];
        CGFloat ITEM_W = MARGIN * 5;
        CGFloat ITEM_H = MARGIN * 3;
        [item mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(tem.mas_right).mas_offset(-MARGIN-(MARGIN + ITEM_W)*i);
            make.size.mas_offset(CGSizeMake(ITEM_W, ITEM_H));
            make.centerY.mas_equalTo(tem.mas_centerY);
            make.top.bottom.mas_equalTo(tem);
            if (i == arr.count - 1) {
                make.left.mas_equalTo(tem.mas_left).mas_offset(MARGIN/2);
            }
        }];
        [item setBoundWidth:1 cornerRadius:4 boardColor:HYCOLOR.color_c2];
        [item setBackgroundImage:[UIImage imageWithColor:HYCOLOR.color_c3] forState:UIControlStateSelected];
        [item setTitleColor:HYCOLOR.color_c0 forState:UIControlStateSelected];
        [self.shiChangBtnArray insertObject:item atIndex:0];
        if (i == 1) {
            [self clickItems:item];
        }
    }
    return tem;
}

- (HYBaseView*)qizhiriqiView
{
    if (!_qizhiriqiView) {
        _qizhiriqiView = [[HYBaseView alloc] init];
        HYLeftRightArrowView *qizhiriqi = [HYLeftRightArrowView creatLeftRightLableArrowViewWithLeftStr:@"*起止日期:"
                                                                                               rightStr:@""
                                                                                          showArrowIcon:NO
                                                                                          CallBackBlock:^(id sender) {
                                                                                              
                                                                                          }];
        [_qizhiriqiView addSubview:qizhiriqi];
        [qizhiriqi mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(_qizhiriqiView);
        }];
        HYDefaultTextField *lable_L = [HYDefaultTextField creatDefaultTextField:@"开始时间"
                                                                           font:SYSTEM_REGULARFONT(13)
                                                                      textColor:HYCOLOR.color_c4];
        HYDefaultLabel *lable_M = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(12)
                                                           text:@"——"
                                                      textColor:HYCOLOR.color_c4];
        HYDefaultTextField *lable_R = [HYDefaultTextField creatDefaultTextField:@"结束时间"
                                                                           font:SYSTEM_REGULARFONT(13)
                                                                      textColor:HYCOLOR.color_c4];
        lable_L.textFiled.enabled = NO;
        lable_R.textFiled.enabled = NO;
        _startTime_TF = lable_L;
        _endTime_TF = lable_R;
        [_qizhiriqiView addSubview:lable_L];
        [_qizhiriqiView addSubview:lable_M];
        [_qizhiriqiView addSubview:lable_R];
        [lable_R mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_offset(MARGIN*3.5);
            make.centerY.mas_equalTo(qizhiriqi.mas_centerY);
            make.right.mas_equalTo(_qizhiriqiView);
            make.width.mas_offset(MARGIN*8);
        }];
        [lable_M mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(lable_R.mas_height);
            make.centerY.mas_equalTo(lable_R.mas_centerY);
            make.right.mas_equalTo(lable_R.mas_left).mas_offset(-2);
            make.width.mas_offset(MARGIN*3);
        }];
        [lable_L mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(lable_R.mas_height);
            make.centerY.mas_equalTo(qizhiriqi.mas_centerY);
            make.right.mas_equalTo(lable_M.mas_left).mas_offset(-2);
            make.width.mas_offset(MARGIN*8);
        }];
        
        [lable_L bk_whenTapped:^{
            [self chooseDateWithType:1];
        }];
//        [lable_R bk_whenTapped:^{
//            [self chooseDateWithType:2];
//        }];
        
    }
    return _qizhiriqiView;
}

- (NSMutableDictionary*)param
{
    if (!_param) {
        _param = [[NSMutableDictionary alloc] init];
    }
    return _param;
}

/**
 检查时长，确定签约时长的按钮选中
 */
- (void)checkShiChangforShiChangBtnSel:(NSInteger)type
{
    NSInteger index = [self returnShiChangIndex:type];
    if (index != 0) {
        self.lastSelectBtn.selected = NO;
        HYDefaultButton *btn = self.shiChangBtnArray[index-1];
        btn.selected = YES;
        self.lastSelectBtn = btn;
    }else{
        for (HYDefaultButton *btn in self.shiChangBtnArray) {
            btn.selected = NO;
            self.lastSelectBtn = nil;
        }
    }
}

/**
 匹配 时长
 */
- (NSInteger)returnShiChangIndex:(NSInteger)type
{
    NSInteger index = 0;
    NSString *temp_TF_text = (type == 1) ? self.startTime_TF.text : self.endTime_TF.text;
    NSDate *temp_date = (type == 1) ? _endTime_Date :_startTime_Date;
    int days = (type == 1) ? 1 : -1;
    NSString *now_Time1 =  [[[HYStringTool share] datejishuangYear:0 Month:(type == 1) ? -3 : 3 Day:days withData:temp_date] stringWithFormat:@"yyyy-MM-dd"];
    NSString *now_Time2 =  [[[HYStringTool share] datejishuangYear:0 Month:(type == 1) ? -6 : 6 Day:days withData:temp_date] stringWithFormat:@"yyyy-MM-dd"];
    NSString *now_Time3 =  [[[HYStringTool share] datejishuangYear:(type == 1) ? -1 : 1 Month:0 Day:days withData:temp_date] stringWithFormat:@"yyyy-MM-dd"];
    NSString *now_Time4 =  [[[HYStringTool share] datejishuangYear:0 Month:(type == 1) ? -1 : 1 Day:days withData:temp_date] stringWithFormat:@"yyyy-MM-dd"];
    
    if ([now_Time4 isEqualToString:temp_TF_text]) {
        index = 1;
    }else if ([now_Time1 isEqualToString:temp_TF_text]){
        index = 2;
    }else if([now_Time2 isEqualToString: temp_TF_text]){
        index = 3;
    }else if([now_Time3 isEqualToString: temp_TF_text]){
        index = 4;
    }
    return index;
}

/**
 检查参数
 */
- (BOOL)checkParam
{
    //1:固定日期、2:提前天数
    self.param[@"prepaymentDaysType"] = @"1";
    //提前付款天数或固定付款日期
    self.param[@"prepaymentDays"] = @"1";
    
    if ([[HYStringTool checkString:_param[@"beginDate"]] isEqualToString:@""]) {
        ALERT(@"请选择开始时间");
        return NO;
    }
    if ([[HYStringTool checkString:_param[@"endDate"]] isEqualToString:@""]) {
        ALERT(@"请选择结束时间");
        return NO;
    }
    if ([[HYStringTool checkString:_param[@"zhifuTypeId"]] isEqualToString:@""]) {
        ALERT(@"请选择付款方式")
        return NO;
    }
    
    self.param[@"time"] = [NSDate ex_stringWithDate:[NSDate date] formatterString:@"YYYY-MM-dd" timeZoneStr:@"Asia"];
    
    return YES;
}

- (NSMutableArray*)shiChangBtnArray
{
    if (!_shiChangBtnArray) {
        _shiChangBtnArray = [[NSMutableArray alloc] init];
    }
    return _shiChangBtnArray;
}
@end
