//
//  HYScoreItemView.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/5.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYScoreItemView.h"

@interface HYScoreItemView()

@property (nonatomic, strong) HYDefaultLabel * leftTitleLable;
@property (nonatomic, strong) HYDefaultLabel * scoreLable;
@property (nonatomic, strong) NSString * titleStr;
@property (nonatomic, copy) HYEventCallBackBlock changeVauleBlock;

@end

@implementation HYScoreItemView
+ (instancetype)creatScoreItemView:(NSString *)title changeValue:(HYEventCallBackBlock)changeVauleBlock
{
    HYScoreItemView *instance   = [[HYScoreItemView alloc] init];
    instance.leftTitleLable.text           = instance.titleStr  =  title;
    instance.changeVauleBlock = changeVauleBlock;
    return instance;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _leftTitleLable = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(15)
                                                   text:_titleStr ? _titleStr : @"没有标题"
                                              textColor:HYCOLOR.color_c4];

        CoustomSlider *slider = [[CoustomSlider alloc] initWithFrame:CGRectMake(80, 0, 200, 11)];
        [slider addTarget:self action:@selector(changeSlider:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:slider];
        slider.minimumValue = 0;
        slider.maximumValue = 10;
        slider.maximumTrackTintColor = HYCOLOR.color_c1;
        [slider setThumbTintColor:HYCOLOR.color_c6];
        _sliderView = slider;
         UIImage *min =  [UIImage imageWithColor:[UIColor colorWithRed:229 green:145 blue:120 alpha:1]];
        [slider setMinimumTrackImage:min forState:UIControlStateNormal];
        [self getSub:slider andLevel:1];
        
        
        _scoreLable = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(15)
                                              text:@"0分"
                                         textColor:HYCOLOR.color_c4];
        _scoreLable.textAlignment = NSTextAlignmentRight;
        [self addSubview:_leftTitleLable];
        
        [self addSubview:_scoreLable];
        [_leftTitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        [_scoreLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mas_right);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.width.mas_offset(ADJUST_PERCENT_FLOAT(35));
        }];
    }
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
            [_sliderView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(_leftTitleLable.mas_right).mas_offset(MARGIN*2);
                make.right.mas_equalTo(_scoreLable.mas_left).mas_offset(-MARGIN*2);
                make.centerY.mas_equalTo(_leftTitleLable.mas_centerY);
                make.height.mas_offset(ADJUST_PERCENT_FLOAT(11));
            }];
}

// 递归获取子视图
- (void)getSub:(UIView *)view andLevel:(int)level {
    NSArray *subviews = [view subviews];
    
    // 如果没有子视图就直接返回
    if ([subviews count] == 0) return;
    
    for (UIView *subview in subviews) {
        
        // 根据层级决定前面空格个数，来缩进显示
        NSString *blank = @"";
        for (int i = 1; i < level; i++) {
            blank = [NSString stringWithFormat:@"  %@", blank];
        }
        
        // 打印子视图类名
        NSLog(@"%@%d: %@", blank, level, subview.class);
        
        // 递归获取此视图的子视图
        [self getSub:subview andLevel:(level+1)];
        
    }
}
- (void)changeSlider:(UISlider *)slider
{
    UIColor *color = [UIColor colorWithRed:229/225 green:(145 - (10*slider.value))/225 blue:(120 - 8*slider.value)/225 alpha:1];
    [slider setMinimumTrackTintColor:color];
    _scoreLable.text = [NSString stringWithFormat:@"%.f分",slider.value];
    if(self.changeVauleBlock) {
        self.changeVauleBlock([NSString stringWithFormat:@"%.f",slider.value]);
    }
}


@end
