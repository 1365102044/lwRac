//
//  HYTopBarView.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/5/28.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYTopBarView.h"

@interface HYTopBarView ()
@property (nonatomic, strong) NSArray * dataArr;
@property (nonatomic, strong) UIView * lineView;
@property (nonatomic, strong) NSMutableArray * btnArr;
@property (nonatomic, strong) UIScrollView * backView;
@property (nonatomic, strong) UIColor * selectColor;
@property (nonatomic, strong) UIButton * lastSelectBtn;
@property (nonatomic, copy) callBackBlock callBackBlock;

@end

@implementation HYTopBarView

+ (instancetype)creatTopBarWithDataArr:(NSArray *)dataArr selectColor:(UIColor *)selectColor callBack:(callBackBlock)callBackBlock
{
    HYTopBarView *temp = [[HYTopBarView alloc] init];
    temp.dataArr = dataArr;
    temp.selectColor = selectColor;
    temp.callBackBlock = callBackBlock;
    [temp setUI];
    return temp;
}

- (void)setUI
{
    self.backgroundColor = HYCOLOR.color_c0;
    self.btnArr = [NSMutableArray array];
    if (self.dataArr.count == 0) {
        return;
    }
    
    [self addSubview:self.backView];
    
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(self);
        make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-ADJUST_PERCENT_FLOAT(0));
    }];
    CGFloat Items_W = (SCREEN_WIDTH - (_dataArr.count - 1) * MARGIN - MARGIN *4)/(_dataArr.count);
    
    _backView.contentSize = CGSizeMake(Items_W * _dataArr.count , 1);
    
    for (int i = 0 ; i<self.dataArr.count; i++) {
        HYDefaultButton *btn = [HYDefaultButton buttonWithTitleStringKey:self.dataArr[i]
                                                              titleColor:HYCOLOR.color_c4
                                                               titleFont:SYSTEM_REGULARFONT(14)
                                                                  target:self
                                                                selector:@selector(clickBtn:)];
        [_backView addSubview:btn];
        btn.tag = i;
        [self.btnArr addObject:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_backView.mas_left).mas_offset(Items_W * i + i * MARGIN + MARGIN*2);
            make.top.mas_equalTo(_backView.mas_top).mas_offset(ADJUST_PERCENT_FLOAT(8));
            make.width.mas_offset(Items_W);
            make.bottom.mas_equalTo(_backView.mas_bottom).mas_offset(-10);
        }];
    }
    self.lastSelectBtn = self.btnArr.firstObject;
    [self.lastSelectBtn setTitleColor:_selectColor forState:UIControlStateNormal];

//    CGFloat mar = (SCREEN_WIDTH - 100*self.dataArr.count) / (self.dataArr.count+1);
//    [self.btnArr mas_distributeViewsAlongAxis:(MASAxisTypeHorizontal) withFixedItemLength:100 leadSpacing:mar tailSpacing:mar];
//    [self.btnArr mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(_backView.mas_top).mas_offset(ADJUST_PERCENT_FLOAT(8));
//        make.bottom.mas_equalTo(_backView.mas_bottom).mas_offset(-2);
//    }];

    
    self.lineView = [[UIView alloc] init];
    self.lineView.backgroundColor = [UIColor redColor];
    [_backView addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_backView.subviews.firstObject.mas_centerX);
        make.width.mas_offset(ADJUST_PERCENT_FLOAT(60));
        make.height.mas_offset(ADJUST_PERCENT_FLOAT(2));
        make.top.mas_equalTo(_backView.subviews.firstObject.mas_bottom).mas_offset(0);
    }];
}

- (void)clickBtn:(UIButton *)sender
{
    if (!self.isNotCanClickBool) {
        [self.lastSelectBtn setTitleColor:HYCOLOR.color_c4 forState:UIControlStateNormal];
        [(UIButton *)sender setTitleColor:_selectColor forState:UIControlStateNormal];
        
        [UIView animateWithDuration:0.25 animations:^{
            self.lineView.centerX = sender.centerX;
        }];
        self.lastSelectBtn = sender;
        if (self.callBackBlock) {
            self.callBackBlock(sender.tag);
        }
    }
}

- (UIScrollView*)backView
{
    if (!_backView) {
        _backView = [[UIScrollView alloc] init];
        _backView.showsHorizontalScrollIndicator = NO;
        _backView.scrollEnabled = NO;
    }
    return _backView;
}

- (void)selectCurrentBtn:(UIButton *)sender
{
    [self.lastSelectBtn setTitleColor:HYCOLOR.color_c4 forState:UIControlStateNormal];
    if (self.isNotCanClickBool) {
    }
    [(UIButton *)sender setTitleColor:_selectColor forState:UIControlStateNormal];
    [UIView animateWithDuration:0.25 animations:^{
        self.lineView.centerX = sender.centerX;
    }];
    self.lastSelectBtn = sender;
    if (!self.isNotCanClickBool) {
        if (self.callBackBlock) {
            self.callBackBlock(sender.tag);
        }
    }
}

- (void)selectIndex:(NSInteger)index
{
    if (index >= self.btnArr.count) {
        return;
    }
    HYDefaultButton *btn =  [self.btnArr objectAtIndex:index];
    [self selectCurrentBtn:btn];
}
@end
