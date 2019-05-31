//
//  YBIDScanResultAlearView.m
//  inborn
//
//  Created by 刘文强 on 2017/9/3.
//  Copyright © 2017年 inborn. All rights reserved.
//

#import "YBIDScanResultAlearView.h"

@interface YBIDScanResultAlearView ()
@property (nonatomic, strong) UIView * backview;
@property (nonatomic, strong) UIImageView * logoimage;


@end

@implementation YBIDScanResultAlearView


+ (instancetype)showAlearView
{
    YBIDScanResultAlearView *temp = [[YBIDScanResultAlearView alloc]init];
    return temp;
}

- (void)dismissAlearView
{
    [self removeFromSuperview];
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backview = [[UIView alloc]init];
        [self addSubview:self.backview];
        self.backview.backgroundColor = HYCOLOR.color_c4;
        self.backview.alpha = 0.6;
        
        self.layer.cornerRadius = 10;
        self.layer.masksToBounds = YES;
        self.backgroundColor = [UIColor clearColor];
        
        self.logoimage = [[UIImageView alloc]init];
        [self addSubview:self.logoimage];
        self.logoimage.image = [UIImage imageNamed:@"mine_success_icon"];
        [self addSubview:self.titlelable];
        self.titlelable.text = @"拍摄成功";
        
        [self.backview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self);
        }];
        
        [self.logoimage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_offset(CGSizeMake(ADJUST_PERCENT_FLOAT(40), ADJUST_PERCENT_FLOAT(40)));
            make.centerX.mas_equalTo(self.mas_centerX);
            make.top.mas_equalTo(self.mas_top).mas_offset(ADJUST_PERCENT_FLOAT(32));
        }];
        [self.titlelable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.logoimage.mas_bottom).mas_offset(ADJUST_PERCENT_FLOAT(22));
            make.left.right.mas_equalTo(self);
        }];
        
    }
    return self;
}
- (HYDefaultLabel *)titlelable
{
    if (!_titlelable) {
        _titlelable = [[HYDefaultLabel alloc]init];
        _titlelable.font = SYSTEM_MEDIUMFONT(16);
        _titlelable.textColor = HYCOLOR.color_c0;
        _titlelable.backgroundColor = [UIColor clearColor];
        _titlelable.textAlignment = NSTextAlignmentCenter;
    }
    return _titlelable;
}

@end
