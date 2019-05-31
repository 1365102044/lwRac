//
//  HYCircleView.m
//  HaoYuClient
//
//  Created by 刘文强 on 2019/1/24.
//  Copyright © 2019年 LWQ. All rights reserved.
//

#import "HYCircleView.h"
#import "HYTimerManager.h"

@interface HYCircleView ()

@property (nonatomic , strong)UILabel *progressLabel;//*中间label*/

@property (nonatomic , assign)CGFloat progress;//*progress*/

@property (nonatomic, strong) CAShapeLayer * progressLayer;

@property (nonatomic, strong) HYTimerManager * Timer;

@property (nonatomic, assign) CGFloat CutDownCount;

@property (nonatomic, strong) NSString * last_text;

@end

@implementation HYCircleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        self.CutDownCount = 100;
        CGFloat progress = 1 - _CutDownCount/100;
        [self setProgress:progress];
        self.last_text = self.progressLabel.text = [NSString stringWithFormat:@"%.0f",self.CutDownCount/10 ];
        
        [self addTimer];
    }
    return self;
}

- (void)addTimer
{
    _Timer = [HYTimerManager shareTimer];
    [_Timer startTimerWithTimeInterVal:0.1 target:self selector:@selector(timerTarget)];
}

- (void)timerTarget
{
    _CutDownCount--;
    CGFloat progress = 1 - _CutDownCount/100;
    [self setProgress:progress];
    self.progressLabel.text = [NSString stringWithFormat:@"%.0f",_CutDownCount/10 ];
    
    if (_CutDownCount <= 0){
        [_Timer stopTimer];
        if(self.timerStopCallBlock) {_timerStopCallBlock(nil);}
    }
    // 每秒返回一次
    if (![self.last_text isEqualToString:self.progressLabel.text]){
        if(self.timerCallBlock) {_timerCallBlock(nil);}
    }
    self.last_text  = self.progressLabel.text;
}

/**
 手动关闭定时器
 */
- (void)stopTimer
{
    [self.Timer stopTimer];
}
-(void)setProgress:(CGFloat)progress
{
    _progress = progress;
    self.progressLayer.opacity = 0;
    [self setNeedsDisplay];
}

-(void)drawRect:(CGRect)rect
{
    CGPoint center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    CGFloat radius = 70;
    CGFloat start = -M_PI_2;//起点
    CGFloat end = -M_PI_2 + M_PI * 2 *self.progress; //终点
    
    //画一个圆，填充色透明，设置边框带颜色，就是一个圆环
    self.progressLayer = [[CAShapeLayer alloc] init];
    self.progressLayer.frame  = self.bounds;
    self.progressLayer.fillColor = UIColor.clearColor.CGColor;
    self.progressLayer.strokeColor = HYCOLOR.color_c3.CGColor;
    self.progressLayer.lineWidth = 10;
    self.progressLayer.lineCap = kCALineCapRound;
    
    //用贝塞尔曲线画圆
    UIBezierPath *berzier = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:start endAngle:end clockwise:YES];
    self.progressLayer.path = [berzier CGPath];
    [self.layer addSublayer:self.progressLayer];
    
}

#pragma mark ----------- 懒加载 -----------

- (UILabel *)progressLabel {
    if (_progressLabel == nil) {
        _progressLabel = [[UILabel alloc]init];
        _progressLabel.font = SYSTEM_BOLDFONT(20);
        _progressLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_progressLabel];
        [_progressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.centerX.equalTo(self);
            make.size.mas_offset(CGSizeMake(50, 50));
        }];
    }
    return _progressLabel;
}

@end
