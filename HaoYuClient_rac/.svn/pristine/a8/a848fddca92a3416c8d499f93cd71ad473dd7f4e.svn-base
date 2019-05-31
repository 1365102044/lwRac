//
//  XHDatePickerView.m
//  XHDatePicker
//
//  Created by XH_J on 2016/10/25.
//  Copyright © 2016年 XHJCoder. All rights reserved.
//

#import "XHDatePickerView.h"
#import "NSDate+XHExtension.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kPickerSize self.datePicker.frame.size
#define RGBA(r, g, b, a) ([UIColor colorWithRed:(r / 255.0) green:(g / 255.0) blue:(b / 255.0) alpha:a])
#define RGB(r, g, b) RGBA(r,g,b,1)


#define MAXYEAR 2050
#define MINYEAR 1987

typedef void(^doneBlock)(NSString *,NSString *);

@interface XHDatePickerView ()<UIPickerViewDelegate,UIPickerViewDataSource,UIGestureRecognizerDelegate> {
    //日期存储数组
    NSMutableArray *_yearArray;
    NSMutableArray *_monthArray;
    NSMutableArray *_dayArray;
    NSMutableArray *_hourArray;
    NSMutableArray *_minuteArray;
    NSString *_dateFormatter;
    //记录位置
    NSInteger yearIndex;
    NSInteger monthIndex;
    NSInteger dayIndex;
    NSInteger hourIndex;
    NSInteger minuteIndex;
    
    NSInteger preRow;
    
    NSDate *_startDate;
    NSDate *_endDate;
}
@property (weak, nonatomic) IBOutlet UIView *buttomView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentView;
@property (weak, nonatomic) IBOutlet UILabel *showYearView;
@property (weak, nonatomic) IBOutlet UIButton *doneBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;

- (IBAction)doneAction:(UIButton *)btn;

@property (weak, nonatomic) IBOutlet UIView *lineView;
//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineview_x;
@property (weak, nonatomic) IBOutlet UIButton *startBtn;
@property (weak, nonatomic) IBOutlet UIButton *endBtn;

@property (nonatomic,strong)UIPickerView *datePicker;
@property (nonatomic, retain) NSDate *scrollToDate;//滚到指定日期
@property (nonatomic,strong)doneBlock doneBlock;
@property (nonatomic, retain) NSDate *currentDate; //默认显示时间

/**
 当前的年分   长期 时 使用
 */
@property(nonatomic,strong) NSString * currentDateStr;

/**
 开始 、结束的 年分 数据
 */
@property(nonatomic,strong) NSMutableArray * statrtdataArr;
@property(nonatomic,strong) NSMutableArray * enddataArr;

/**
 记录选择的时间 在切换的时候使用
 */
@property(nonatomic,strong) NSMutableArray * startIndexArr;
@property(nonatomic,strong) NSMutableArray * endindexArr;

/**
 需要返回的字符串
 */
@property(nonatomic,strong) NSString * resultSatartDateStr;
@property(nonatomic,strong) NSString * resultendDateStr;

@end

@implementation XHDatePickerView

- (void)awakeFromNib
{
    [super awakeFromNib];
    CGFloat end_x = self.startBtn.center.x;
    CGFloat end_y = self.lineView.center.y;
    self.lineView.center = CGPointMake(end_x, end_y);

    self.doneBtn.layer.cornerRadius = 2;
    self.doneBtn.layer.masksToBounds = YES;
}

-(instancetype)initWithCompleteBlock:(void(^)(NSString *,NSString *))completeBlock {
    return [self initWithCurrentDate:nil CompleteBlock:completeBlock];
}

-(instancetype)initWithCurrentDate:(NSDate *)currentDate CompleteBlock:(void (^)(NSString *, NSString *))completeBlock {
    self = [super init];
    if (self) {
        self = [[[NSBundle bundleForClass:[self class]] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] lastObject];
        
        self.currentDate = currentDate;
        
        _dateFormatter = @"yyyy-MM-dd HH:mm";
        [self setupUI];
        [self defaultConfig];
        
        if (completeBlock) {
            self.doneBlock = ^(NSString *startDate,NSString *endDate) {
                completeBlock(startDate,endDate);
            };
        }
    }
    return self;
}

-(void)setupUI {
    
    self.datePickerStyle = DateStyleShowYearMonthDay;
    
    self.startIndexArr = [[NSMutableArray alloc]initWithArray:@[@"0",@"0",@"0"]];
    self.endindexArr = [[NSMutableArray alloc]initWithArray:@[@"0",@"0",@"0"]];
    
    self.segmentView.selectedSegmentIndex = 0;
    [self.segmentView addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    
//    self.buttomView.layer.cornerRadius = 10;
//    self.buttomView.layer.masksToBounds = YES;
    self.themeColor = RGB(247, 133, 51);
    self.frame=CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    
    //点击背景是否影藏
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss)];
    tap.delegate = self;
    [self addGestureRecognizer:tap];
    
    self.bottomConstraint.constant = -self.frame.size.height;
    self.backgroundColor = RGBA(0, 0, 0, 0);
    [self layoutIfNeeded];
    
    
    [[UIApplication sharedApplication].keyWindow bringSubviewToFront:self];
    
    [self.showYearView addSubview:self.datePicker];
    
}

-(void)defaultConfig {
    
    if (!_scrollToDate) {
        _scrollToDate = self.currentDate ? self.currentDate : [NSDate date];
    }
    
    
    //循环滚动时需要用到
    preRow = (self.scrollToDate.year-MINYEAR)*12+self.scrollToDate.month-1;
    
    //设置年月日时分数据
    _yearArray = [self setArray:_yearArray];
    _monthArray = [self setArray:_monthArray];
    _dayArray = [self setArray:_dayArray];
    _hourArray = [self setArray:_hourArray];
    _minuteArray = [self setArray:_minuteArray];
    
    for (int i=0; i<60; i++) {
        NSString *num = [NSString stringWithFormat:@"%02d",i];
        if (0<i && i<=12)
            [_monthArray addObject:[NSString stringWithFormat:@"%@月",num]];
        if (i<24)
            [_hourArray addObject:[NSString stringWithFormat:@"%@日",num]];
        [_minuteArray addObject:[NSString stringWithFormat:@"%@分",num]];
    }
    
    _statrtdataArr = [NSMutableArray array];
    for (NSInteger i = MINYEAR; i<MAXYEAR; i++) {
        NSString *num = [NSString stringWithFormat:@"%ld年",(long)i];
        [_yearArray addObject:num];
    }
    _statrtdataArr = _yearArray;
    
    
    NSMutableArray *temp = [NSMutableArray array];
    for (NSInteger i = MINYEAR; i<MAXYEAR; i++) {
        NSString *num = [NSString stringWithFormat:@"%ld年",(long)i];
        if (i == MINYEAR) {
            [temp addObject:@"长期"];
        }
        [temp addObject:num];
    }
    _enddataArr = temp;
    

    //最大最小限制
    if (!self.maxLimitDate) {
        self.maxLimitDate = [NSDate date:@"2049-12-31 23:59" WithFormat:@"yyyy-MM-dd HH:mm"];
    }
    //最小限制
    if (!self.minLimitDate) {
//        self.minLimitDate = [NSDate dateWithTimeIntervalSince1970:0];
        self.minLimitDate = [NSDate date:@"2017-1-1 23:59" WithFormat:@"yyyy-MM-dd HH:mm"];
    }
}

-(void)addLabelWithName:(NSArray *)nameArr {
    for (id subView in self.showYearView.subviews) {
        if ([subView isKindOfClass:[UILabel class]]) {
            [subView removeFromSuperview];
        }
    }
    for (int i=0; i<nameArr.count; i++) {
        CGFloat labelX = kPickerSize.width/(nameArr.count*2)+18+kPickerSize.width/nameArr.count*i;
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(labelX, self.showYearView.frame.size.height/2-7, 15, 15)];
        label.text = nameArr[i];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:18];
        label.textColor = [UIColor blackColor];
        label.backgroundColor = [UIColor clearColor];
//        [self.showYearView addSubview:label];
    }
}


- (NSMutableArray *)setArray:(id)mutableArray
{
    if (mutableArray)
        [mutableArray removeAllObjects];
    else
        mutableArray = [NSMutableArray array];
    return mutableArray;
}

#pragma mark - UIPickerViewDelegate,UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    switch (self.datePickerStyle) {
        case DateStyleShowYearMonthDayHourMinute:
            [self addLabelWithName:@[@"年",@"月",@"日",@"时",@"分"]];
            return 5;
        case DateStyleShowYearMonthDay:
            [self addLabelWithName:@[@"年",@"月",@"日"]];
            return 3;
        case DateStyleShowMonthDayHourMinute:
            [self addLabelWithName:@[@"月",@"日",@"时",@"分"]];
            return 4;
        case DateStyleShowMonthDay:
            [self addLabelWithName:@[@"月",@"日"]];
            return 2;
        case DateStyleShowHourMinute:
            [self addLabelWithName:@[@"时",@"分"]];
            return 2;
        default:
            return 0;
    }
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSArray *numberArr = [self getNumberOfRowsInComponent];
    return [numberArr[component] integerValue];
}

-(NSArray *)getNumberOfRowsInComponent {
    
    NSInteger yearNum = _yearArray.count;
    NSInteger monthNum = _monthArray.count;
    NSInteger dayNum = [self DaysfromYear:[_yearArray[yearIndex] integerValue] andMonth:[_monthArray[monthIndex] integerValue]];
    NSInteger hourNum = _hourArray.count;
    NSInteger minuteNUm = _minuteArray.count;
    
    NSInteger timeInterval = MAXYEAR - MINYEAR;
    
    switch (self.datePickerStyle) {
        case DateStyleShowYearMonthDayHourMinute:
            return @[@(yearNum),@(monthNum),@(dayNum),@(hourNum),@(minuteNUm)];
            break;
        case DateStyleShowMonthDayHourMinute:
            return @[@(monthNum*timeInterval),@(dayNum),@(hourNum),@(minuteNUm)];
            break;
        case DateStyleShowYearMonthDay:
            return @[@(yearNum),@(monthNum),@(dayNum)];
            break;
        case DateStyleShowMonthDay:
            return @[@(monthNum*timeInterval),@(dayNum),@(hourNum)];
            break;
        case DateStyleShowHourMinute:
            return @[@(hourNum),@(minuteNUm)];
            break;
        default:
            return @[];
            break;
    }
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 40;
}


-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *customLabel = (UILabel *)view;
    if (!customLabel) {
        customLabel = [[UILabel alloc] init];
        customLabel.textAlignment = NSTextAlignmentCenter;
        [customLabel setFont:SYSTEM_REGULARFONT(18)];
    }
    NSString *title;
    
    switch (self.datePickerStyle) {
        case DateStyleShowYearMonthDayHourMinute:
            if (component==0) {
                title = _yearArray[row];
            }
            if (component==1) {
                title = _monthArray[row];
            }
            if (component==2) {
                title = _dayArray[row];
            }
            if (component==3) {
                title = _hourArray[row];
            }
            if (component==4) {
                title = _minuteArray[row];
            }
            break;
        case DateStyleShowYearMonthDay:
            if (component==0) {
                title = _yearArray[row];
            }
            if (component==1) {
                title = _monthArray[row];
            }
            if (component==2) {
                title = _dayArray[row];
            }
            break;
        case DateStyleShowMonthDayHourMinute:
            if (component==0) {
                title = _monthArray[row%12];
            }
            if (component==1) {
                title = _dayArray[row];
            }
            if (component==2) {
                title = _hourArray[row];
            }
            if (component==3) {
                title = _minuteArray[row];
            }
            break;
        case DateStyleShowMonthDay:
            if (component==0) {
                title = _monthArray[row%12];
            }
            if (component==1) {
                title = _dayArray[row];
            }
            break;
        case DateStyleShowHourMinute:
            if (component==0) {
                title = _hourArray[row];
            }
            if (component==1) {
                title = _minuteArray[row];
            }
            break;
        default:
            title = @"";
            break;
    }

    customLabel.text = title;
    customLabel.textColor = [UIColor blackColor];
    return customLabel;
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    switch (self.datePickerStyle) {
        case DateStyleShowYearMonthDayHourMinute:{
            
            if (component == 0) {
                yearIndex = row;
                
//                self.showYearView.text =_yearArray[yearIndex];
            }
            if (component == 1) {
                monthIndex = row;
            }
            if (component == 2) {
                dayIndex = row;
            }
            if (component == 3) {
                hourIndex = row;
            }
            if (component == 4) {
                minuteIndex = row;
            }
            if (component == 0 || component == 1){
                [self DaysfromYear:[_yearArray[yearIndex] integerValue] andMonth:[_monthArray[monthIndex] integerValue]];
                if (_dayArray.count-1<dayIndex) {
                    dayIndex = _dayArray.count-1;
                }
                
            }
        }
            break;
            
            
        case DateStyleShowYearMonthDay:{
            
            if (component == 0) {
                yearIndex = row;
//                self.showYearView.text =_yearArray[yearIndex];
                self.currentDateStr = _yearArray[yearIndex];
            }
            if (component == 1) {
                monthIndex = row;
            }
            if (component == 2) {
                dayIndex = row;
            }
            if (component == 0 || component == 1){
                [self DaysfromYear:[_yearArray[yearIndex] integerValue] andMonth:[_monthArray[monthIndex] integerValue]];
                if (_dayArray.count-1<dayIndex) {
                    dayIndex = _dayArray.count-1;
                }
            }
            
            if (self.dateType == DateTypeEndDate) {
                self.endindexArr[component] = @(row);
            }else{
                self.startIndexArr[component] = @(row);
            }
        }
            break;
        case DateStyleShowMonthDayHourMinute:{
            if (component == 1) {
                dayIndex = row;
            }
            if (component == 2) {
                hourIndex = row;
            }
            if (component == 3) {
                minuteIndex = row;
            }
            if (component == 0) {
                
                [self yearChange:row];
                
                if (_dayArray.count-1<dayIndex) {
                    dayIndex = _dayArray.count-1;
                }
            }
            [self DaysfromYear:[_yearArray[yearIndex] integerValue] andMonth:[_monthArray[monthIndex] integerValue]];
            
        }
            break;
         
        case DateStyleShowMonthDay:{
            if (component == 1) {
                dayIndex = row;
            }
            if (component == 0) {
                
                [self yearChange:row];
                
                if (_dayArray.count-1<dayIndex) {
                    dayIndex = _dayArray.count-1;
                }
            }
            [self DaysfromYear:[_yearArray[yearIndex] integerValue] andMonth:[_monthArray[monthIndex] integerValue]];
        }
            break;
            
        case DateStyleShowHourMinute:{
            if (component == 0) {
                hourIndex = row;
            }
            if (component == 1) {
                minuteIndex = row;
            }
        }
            break;
            
        default:
            break;
    }
    
    [pickerView reloadAllComponents];
    
    NSString *dateStr = [NSString stringWithFormat:@"%@-%@-%@ %@:%@",_yearArray[yearIndex],_monthArray[monthIndex],_dayArray[dayIndex],_hourArray[hourIndex],_minuteArray[minuteIndex]];
    
    self.scrollToDate = [[NSDate date:dateStr WithFormat:@"yyyy-MM-dd HH:mm"] dateWithFormatter:_dateFormatter];
    
    if ([self.scrollToDate compare:self.minLimitDate] == NSOrderedAscending) {
        self.scrollToDate = self.minLimitDate;
        [self getNowDate:self.minLimitDate animated:YES];
    }else if ([self.scrollToDate compare:self.maxLimitDate] == NSOrderedDescending){
        self.scrollToDate = self.maxLimitDate;
        [self getNowDate:self.maxLimitDate animated:YES];
    }
    
    switch (self.dateType) {
        case DateTypeStartDate:
            _startDate = self.scrollToDate;
            break;
            
        default:
            _endDate = self.scrollToDate;
            break;
    }
    
    
    NSLog(@"%@",self.scrollToDate);
}

-(void)yearChange:(NSInteger)row {
    
    monthIndex = row%12;
    
    //年份状态变化
    if (row-preRow <12 && row-preRow>0 && [_monthArray[monthIndex] integerValue] < [_monthArray[preRow%12] integerValue]) {
        yearIndex ++;
    } else if(preRow-row <12 && preRow-row > 0 && [_monthArray[monthIndex] integerValue] > [_monthArray[preRow%12] integerValue]) {
        yearIndex --;
    }else {
        NSInteger interval = (row-preRow)/12;
        yearIndex += interval;
    }
    
//    self.showYearView.text = _yearArray[yearIndex];
    
    preRow = row;
}


#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if( [touch.view isDescendantOfView:self.buttomView]) {
        return NO;
    }
    return YES;
}

#pragma mark - Action
-(void)show {
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:.3 animations:^{
        self.bottomConstraint.constant = 10;
        self.backgroundColor = RGBA(0, 0, 0, 0.4);
        [self layoutIfNeeded];
    }];
}
-(void)dismiss {
    [UIView animateWithDuration:.3 animations:^{
        self.bottomConstraint.constant = -self.frame.size.height;
        self.backgroundColor = RGBA(0, 0, 0, 0);
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self removeFromSuperview];
    }];
}


/**
 点击事件
 */
- (IBAction)clickStatAction:(id)sender {
    
    CGFloat end_x = self.startBtn.center.x;
    CGFloat end_y = self.lineView.center.y;
    self.lineView.center = CGPointMake(end_x, end_y);
    
    self.dateType = 0;
    
    _yearArray = _statrtdataArr;
    [self.datePicker reloadAllComponents];
    for (int i = 0; i<self.startIndexArr.count; i ++ ) {
        [self.datePicker selectRow:[self.startIndexArr[i] integerValue] inComponent:i animated:NO];
    }
    
    [self.endBtn setTitleColor:HYCOLOR.color_c2 forState:UIControlStateNormal];
    [self.startBtn setTitleColor:HYCOLOR.color_c4 forState:UIControlStateNormal];
    
    /**
     滚动现在的时间
     */
    _scrollToDate = self.currentDate ? self.currentDate : [NSDate date];
    [self getNowDate:_scrollToDate animated:NO];
}

- (IBAction)clickEndAction:(id)sender {
    
    CGFloat end_x = self.endBtn.center.x;
    CGFloat end_y = self.lineView.center.y;
    self.lineView.center = CGPointMake(end_x, end_y);
    
    self.dateType = 1;
    [self.datePicker reloadAllComponents];
    _yearArray = _enddataArr;
    for (int i = 0; i<self.endindexArr.count; i ++ ) {
        [self.datePicker selectRow:[self.endindexArr[i] integerValue] inComponent:i animated:NO];
    }
    
    [self.startBtn setTitleColor:HYCOLOR.color_c2 forState:UIControlStateNormal];
    [self.endBtn setTitleColor:HYCOLOR.color_c4 forState:UIControlStateNormal];
    /**
     滚动现在的时间
     */
    _scrollToDate = self.currentDate ? self.currentDate : [NSDate date];
    [self getNowDate:_scrollToDate animated:NO];
}

- (IBAction)doneAction:(UIButton *)btn {
    
    NSString *yearstr = _statrtdataArr[[_startIndexArr[0] integerValue]];
    NSString *mothstr = _monthArray[[_startIndexArr[1] integerValue]];
    NSString *daystr = _dayArray[[_startIndexArr[2] integerValue]];
    _resultSatartDateStr = [NSString stringWithFormat:@"%@%@%@",[self getYearStr:yearstr],[self getMothStr:mothstr],[self getDayStr:daystr]];
    
    
    NSString *yearstr_end = _enddataArr[[_endindexArr[0] integerValue]];
    NSString *mothstr_end = _monthArray[[_endindexArr[1] integerValue]];
    NSString *daystr_end = _dayArray[[_endindexArr[2] integerValue]];
    _resultendDateStr = [NSString stringWithFormat:@"%@%@%@",[self getYearStr:yearstr_end],[self getMothStr:mothstr_end],[self getDayStr:daystr_end]];

    if ([yearstr_end isEqualToString:@"长期"]) {
        _resultendDateStr = @"长期";
    }
    self.doneBlock(_resultSatartDateStr,_resultendDateStr);
    [self dismiss];
}


- (NSString *)getYearStr:(NSString *)year
{
    if ([year containsString:@"年"]) {
     return   [year stringByReplacingOccurrencesOfString:@"年" withString:@""];
    }else{
        return year;
    }
}

- (NSString *)getMothStr:(NSString *)moth
{
    if ([moth containsString:@"月"]) {
        return   [moth stringByReplacingOccurrencesOfString:@"月" withString:@""];
    }else{
        return moth;
    }
}

- (NSString *)getDayStr:(NSString *)day
{
    if ([day containsString:@"日"]) {
        return   [day stringByReplacingOccurrencesOfString:@"日" withString:@""];
    }else{
        return day;
    }
}
#pragma mark - tools
//通过年月求每月天数
- (NSInteger)DaysfromYear:(NSInteger)year andMonth:(NSInteger)month
{
    NSInteger num_year  = year;
    NSInteger num_month = month;
    
    BOOL isrunNian = num_year%4==0 ? (num_year%100==0? (num_year%400==0?YES:NO):YES):NO;
    switch (num_month) {
        case 1:case 3:case 5:case 7:case 8:case 10:case 12:{
            [self setdayArray:31];
            return 31;
        }
        case 4:case 6:case 9:case 11:{
            [self setdayArray:30];
            return 30;
        }
        case 2:{
            if (isrunNian) {
                [self setdayArray:29];
                return 29;
            }else{
                [self setdayArray:28];
                return 28;
            }
        }
        default:
            break;
    }
    return 0;
}

//设置每月的天数数组
- (void)setdayArray:(NSInteger)num
{
    [_dayArray removeAllObjects];
    for (int i=1; i<=num; i++) {
        [_dayArray addObject:[NSString stringWithFormat:@"%02d日",i]];
    }
}

//滚动到指定的时间位置
- (void)getNowDate:(NSDate *)date animated:(BOOL)animated
{
    if (!date) {
        date = [NSDate date];
    }
    
    [self DaysfromYear:date.year andMonth:date.month];
    
    yearIndex = date.year-MINYEAR;
    monthIndex = date.month-1;
    dayIndex = date.day-1;
    hourIndex = date.hour;
    minuteIndex = date.minute;
    
    /**
     记录刚进入的时间
     */
    if (self.dateType == DateTypeStartDate) {
        self.startIndexArr[0] = @(yearIndex);
        self.startIndexArr[1] = @(monthIndex);
        self.startIndexArr[2] = @(dayIndex);
    }else if (self.dateType == DateTypeEndDate){
        yearIndex += 1;
        self.endindexArr[0] = @(yearIndex);
        self.endindexArr[1] = @(monthIndex);
        self.endindexArr[2] = @(dayIndex);
    }
    
    
    //循环滚动时需要用到
    preRow = (self.scrollToDate.year-MINYEAR)*12+self.scrollToDate.month-1;
    
    NSArray *indexArray;
    
    if (self.datePickerStyle == DateStyleShowYearMonthDayHourMinute)
        indexArray = @[@(yearIndex),@(monthIndex),@(dayIndex),@(hourIndex),@(minuteIndex)];
    if (self.datePickerStyle == DateStyleShowYearMonthDay)
    indexArray = @[@(yearIndex),@(monthIndex),@(dayIndex)];
    if (self.datePickerStyle == DateStyleShowMonthDayHourMinute)
    indexArray = @[@(monthIndex),@(dayIndex),@(hourIndex),@(minuteIndex)];
    if (self.datePickerStyle == DateStyleShowMonthDay)
    indexArray = @[@(monthIndex),@(dayIndex)];
    if (self.datePickerStyle == DateStyleShowHourMinute)
    indexArray = @[@(hourIndex),@(minuteIndex)];
    
//    self.showYearView.text = _yearArray[yearIndex];
    
    [self.datePicker reloadAllComponents];
    
    for (int i=0; i<indexArray.count; i++) {
        if ((self.datePickerStyle == DateStyleShowMonthDayHourMinute || self.datePickerStyle == DateStyleShowMonthDay)&& i==0) {
            NSInteger mIndex = [indexArray[i] integerValue]+(12*(self.scrollToDate.year - MINYEAR));
            [self.datePicker selectRow:mIndex inComponent:i animated:animated];
        } else {
            [self.datePicker selectRow:[indexArray[i] integerValue] inComponent:i animated:animated];
        }
        
    }
}


#pragma mark - getter / setter
-(UIPickerView *)datePicker {
    if (!_datePicker) {
        [self.showYearView layoutIfNeeded];
        _datePicker = [[UIPickerView alloc] initWithFrame:self.showYearView.bounds];
        _datePicker.showsSelectionIndicator = YES;
        _datePicker.delegate = self;
        _datePicker.dataSource = self;
    }
    return _datePicker;
}

-(void)setMinLimitDate:(NSDate *)minLimitDate {
    _minLimitDate = minLimitDate;
    if ([_scrollToDate compare:self.minLimitDate] == NSOrderedAscending) {
        _scrollToDate = self.minLimitDate;
    }
    [self getNowDate:self.scrollToDate animated:NO];
}

-(void)setMaxLimitDate:(NSDate *)maxLimitDate {
    _maxLimitDate = maxLimitDate;
    if ([_scrollToDate compare:maxLimitDate] == NSOrderedDescending) {
        _scrollToDate = maxLimitDate;
    }
    [self getNowDate:self.scrollToDate animated:NO];
}

//-(void)setThemeColor:(UIColor *)themeColor {
//    _themeColor = themeColor;
//    self.segmentView.tintColor = themeColor;
//    self.doneBtn.backgroundColor = ZJCOLOR.color_c26;
//}

//-(void)setDateType:(XHDateType)dateType {
//    _dateType = dateType;
//    switch (dateType) {
//        case DateTypeStartDate:
//            self.segmentView.selectedSegmentIndex = 0;
//            break;
//            
//        default:
//            self.segmentView.selectedSegmentIndex = 1;
//            break;
//    }
//}
//
//-(void)setDatePickerStyle:(XHDateStyle)datePickerStyle {
//    _datePickerStyle = datePickerStyle;
//    switch (datePickerStyle) {
//            break;
//        case DateStyleShowYearMonthDay:
//        case DateStyleShowMonthDay:
//            _dateFormatter = @"yyyy-MM-dd";
//            break;
//            
//        default:
//            break;
//    }
//    [self.datePicker reloadAllComponents];
//}

@end
