//
//  HYAlertCenterView.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/5/24.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYAlertCenterView.h"

@interface HYAlertCenterView()
@property(nonatomic,strong) UIView * lineView1;
@property(nonatomic,strong) UIView * lineView2;
@end
@implementation HYAlertCenterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        self.backView = [[UIView alloc]init];
        self.backView.backgroundColor = [UIColor blackColor];
        self.backView.alpha = 0.2;
        
        _centerView             = [[UIView alloc]init];
        _titleLable             = [HYDefaultLabel labelWithFont:SYSTEM_MEDIUMFONT(17) text:@"" textColor:HYCOLOR.color_c4];
        _messageLable           = [[HYAttributedStringLabel alloc]init];
        _leftBtn_Lable          = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(17) text:@"" textColor:HYCOLOR.color_c26];
        _rightBtn_Lable         = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(17) text:@"" textColor:HYCOLOR.color_c26];
        _lineView1              = [[UIView alloc]init];
        _lineView2              = [[UIView alloc]init];
        _lineView1.backgroundColor = HYCOLOR.color_c6;
        _lineView2.backgroundColor = HYCOLOR.color_c6;
        
        _centerView.backgroundColor = HYCOLOR.color_c0;
        _centerView.layer.cornerRadius = 16;
        _centerView.layer.masksToBounds = YES;
        _titleLable.textAlignment = NSTextAlignmentCenter;
        _leftBtn_Lable.textAlignment = NSTextAlignmentCenter;
        _rightBtn_Lable.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:self.backView];
        [self addSubview:self.centerView];
        [self.centerView addSubview:_titleLable];
        [self.centerView addSubview:_messageLable];
        [self.centerView addSubview:_leftBtn_Lable];
        [self.centerView addSubview:_rightBtn_Lable];
        [self.centerView addSubview:_lineView1];
        [self.centerView addSubview:_lineView2];
        
        self.leftBtn_Lable.userInteractionEnabled = YES;
        self.rightBtn_Lable.userInteractionEnabled =  YES;
        self.backView.userInteractionEnabled = YES;
        
        [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self);
        }];
        [self.centerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_offset(SCREEN_WIDTH -ADJUST_PERCENT_FLOAT(50)*2);
            //            make.height.greaterThanOrEqualTo(@(ADJUST_PERCENT_FLOAT(200)));
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
        [self.lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self.titleLable);
            make.top.mas_equalTo(self.messageLable.mas_bottom).mas_offset(ADJUST_PERCENT_FLOAT(16));
            make.height.mas_offset(0.5);
        }];
        [self.leftBtn_Lable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.titleLable);
            make.right.mas_equalTo(self.rightBtn_Lable.mas_left).mas_offset(1);
            make.width.mas_equalTo(self.rightBtn_Lable.mas_width);
            make.top.mas_equalTo(self.lineView1.mas_bottom).mas_offset(ADJUST_PERCENT_FLOAT(14));
            make.bottom.mas_equalTo(self.centerView.mas_bottom).mas_offset(-ADJUST_PERCENT_FLOAT(14));
        }];
        [self.rightBtn_Lable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.leftBtn_Lable);
            make.width.mas_equalTo(self.leftBtn_Lable.mas_width);
            make.left.mas_equalTo(self.leftBtn_Lable.mas_right).mas_offset(1);
            make.right.mas_equalTo(_titleLable.mas_right);
        }];
        [self.lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_offset(0.5);
            make.height.mas_equalTo(self.leftBtn_Lable.mas_height);
            make.centerY.mas_equalTo(self.leftBtn_Lable);
            make.left.mas_equalTo(self.leftBtn_Lable.mas_right);
        }];
        
    }
    return self;
}

@end
