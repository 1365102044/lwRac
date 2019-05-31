//
//  HYAlertCenterView.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/5/24.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYAlertCenterView.h"

@interface HYAlertCenterView()
@property (nonatomic, strong) NSArray * btnArray;
@property (nonatomic, strong) NSArray * titleArray;
@property (nonatomic, copy) HYEventCallBackBlock callBlock;
@property(nonatomic,strong) UIView * centerView;
@property(nonatomic,strong) HYDefaultLabel * titleLable;
@property(nonatomic,strong) UIView * backView;
@end
@implementation HYAlertCenterView

+ (instancetype)showAlerCenterViewWithTitle:(NSString *)title
                            message:(NSString *)message
                           titleArray:(NSArray *)titleArray
                          callBlock:(HYEventCallBackBlock)callBlock
{
    HYAlertCenterView *instance = [[HYAlertCenterView alloc] init];
    instance.titleArray = titleArray;
    instance.callBlock = callBlock;
    [instance serUI];
    instance.titleLable.text = title;
    [instance.messageLable setAttributedStringWithContentArray:@[@{@"color" : HYCOLOR.color_c4,
                                                                    @"content" : message,
                                                                    @"size" : SYSTEM_REGULARFONT(12),
                                                                    @"lineSpacing": @(10)},]];
    [instance showView];
    return instance;
}

- (void)showView
{
    _AutoDismiss = YES;
    self.frame = SCREEN_RECT;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
}

- (void)dismissView
{
    [self removeAllSubviews];
    [self removeFromSuperview];
}

- (void)serUI
{
    self.backgroundColor = [UIColor clearColor];
    
    self.backView = [[UIView alloc]init];
    self.backView.backgroundColor = [UIColor blackColor];
    self.backView.alpha = 0.2;
    
    _centerView             = [[UIView alloc]init];
    _titleLable             = [HYDefaultLabel labelWithFont:SYSTEM_MEDIUMFONT(17) text:@"" textColor:HYCOLOR.color_c4];
    _messageLable           = [[HYAttributedStringLabel alloc]init];
    UIView *lineView1              = [[UIView alloc]init];
    lineView1.backgroundColor = HYCOLOR.color_c6;
    
    _centerView.backgroundColor = HYCOLOR.color_c0;
    _centerView.layer.cornerRadius = 16;
    _centerView.layer.masksToBounds = YES;
    _titleLable.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:self.backView];
    [self addSubview:self.centerView];
    [self.centerView addSubview:_titleLable];
    [self.centerView addSubview:_messageLable];
    [self.centerView addSubview:lineView1];
    self.backView.userInteractionEnabled = YES;
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    [self.centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(SCREEN_WIDTH * 0.7);
        make.centerX.mas_equalTo(self);
        make.centerY.mas_equalTo(self);
    }];
    [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.centerView.mas_top).mas_offset(ADJUST_PERCENT_FLOAT(22));
        make.left.mas_equalTo(self.centerView.mas_left).mas_offset(ADJUST_PERCENT_FLOAT(12));
        make.right.mas_equalTo(self.centerView.mas_right).mas_offset(-ADJUST_PERCENT_FLOAT(12));
        make.centerX.mas_equalTo(self.mas_centerX);
    }];
    [self.messageLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.titleLable);
        make.top.mas_equalTo(self.titleLable.mas_bottom).mas_offset(ADJUST_PERCENT_FLOAT(16));
    }];
    [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.titleLable);
        make.top.mas_equalTo(self.messageLable.mas_bottom).mas_offset(ADJUST_PERCENT_FLOAT(16));
        make.height.mas_offset(0.5);
    }];
    
    CGFloat item_W = (SCREEN_WIDTH * 0.7 - _titleArray.count - 1)/_titleArray.count;
    NSMutableArray *btnArray = [[NSMutableArray alloc] init];
    for (int i = 0 ; i < _titleArray.count; i++) {
        HYDefaultButton *btn = [HYDefaultButton buttonWithTitleStringKey:_titleArray[i] titleColor:HYCOLOR.color_c4 titleFont:SYSTEM_REGULARFONT(17) target:self selector:@selector(clickBtn:)];
        btn.tag = i;
        [self.centerView addSubview:btn];
        [btnArray addObject:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(lineView1.mas_bottom).mas_offset(ADJUST_PERCENT_FLOAT(5));
            make.bottom.mas_equalTo(self.centerView.mas_bottom).mas_offset(-ADJUST_PERCENT_FLOAT(5));
            make.height.mas_offset(MARGIN*3);
            make.width.mas_offset(ADJUST_PERCENT_FLOAT(item_W));
            make.left.mas_equalTo(self.centerView.mas_left).mas_offset(item_W * i + i);
        }];
        if (i > 0) {
            UIView *line              = [[UIView alloc]init];
            line.backgroundColor = HYCOLOR.color_c6;
            [self.centerView addSubview:line];
            [line mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(btn);
                make.height.mas_equalTo(btn.mas_height);
                make.width.mas_offset(1);
                make.centerY.mas_equalTo(btn.mas_centerY);
            }];
        }
    }
}

- (void)clickBtn:(UIButton *)sender
{
    if (self.callBlock) {
        self.callBlock(sender.titleLabel.text);
    }
    
    if (_AutoDismiss) {
        [self dismissView];
    }
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       
    }
    return self;
}

@end
