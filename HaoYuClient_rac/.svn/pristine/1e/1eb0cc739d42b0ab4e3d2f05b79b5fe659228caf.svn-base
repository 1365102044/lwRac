//
//  LWSoundWave.m
//  LwBlock
//
//  Created by 刘文强 on 2019/3/27.
//  Copyright © 2019年 LWQ. All rights reserved.
//

#import "LWSoundWave.h"


@interface LWSoundWave()

@property (nonatomic, strong) UIView * animationView;
@property (nonatomic, strong) UIView * animationSuperView;
@property (nonatomic, strong) NSTimer * timer;

@end

@implementation LWSoundWave

+ (void)startAnimationWithanimationView:(UIView *)animationView animationSuperView:(UIView *)animationSuperView
{
    LWSoundWave *instance =  [LWSoundWave new];
    instance.animationSuperView = animationSuperView;
    instance.animationView = animationView;
    [instance addTimer];
}

- (void)addTimer
{
    [_timer invalidate];
    _timer = nil;
    
    _timer = [NSTimer timerWithTimeInterval:1.5 target:self selector:@selector(timerTarget) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    [_timer fire];
}

- (void)timerTarget
{
    [self addLayer];
}

- (void)addLayer
{
    
    CAShapeLayer *rippleLayer = [[CAShapeLayer alloc] init];
    rippleLayer.backgroundColor = [UIColor clearColor].CGColor;
    rippleLayer.position = CGPointMake(_animationView.frame.size.width/2+_animationView.frame.origin.x, _animationView.frame.size.height/2+_animationView.frame.origin.y);
    rippleLayer.bounds = CGRectMake(_animationView.frame.origin.x+1, _animationView.frame.origin.y+1, _animationView.frame.size.width-2, _animationView.frame.size.height-2);
    rippleLayer.fillColor  = [UIColor grayColor].CGColor;
    UIBezierPath *beginpath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(_animationView.frame.origin.x+1, _animationView.frame.origin.y+1, _animationView.frame.size.width-2, _animationView.frame.size.height-2)];
    rippleLayer.path = beginpath.CGPath;
//    rippleLayer.lineWidth = 0;
    UIView *supView = _animationSuperView ? _animationSuperView: _animationView.superview;;
    [supView.layer insertSublayer:rippleLayer below:_animationView.layer];
    
    CGRect endRect = [self endRect];
    UIBezierPath *endpath = [UIBezierPath bezierPathWithOvalInRect:endRect];
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    pathAnimation.fromValue = (__bridge id _Nullable)(beginpath.CGPath);
    pathAnimation.toValue = (__bridge id _Nullable)(endpath.CGPath);
    pathAnimation.duration = 2;
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue = [NSNumber numberWithFloat:0.6];
    opacityAnimation.toValue = [NSNumber numberWithFloat:0.0];
    opacityAnimation.duration = 2;
    
    [rippleLayer  addAnimation:pathAnimation forKey:@""];
    [rippleLayer  addAnimation:opacityAnimation forKey:@""];
    
    [self performSelector:@selector(removeRipleViews:) withObject:rippleLayer afterDelay:4];
}

- (void)removeRipleViews:(CAShapeLayer *)layer
{
    [layer removeFromSuperlayer];
    layer = nil;
}

- (CGRect)endRect
{
    CGRect endRect = CGRectMake(_animationView.frame.origin.x+1, _animationView.frame.origin.y+1, _animationView.frame.size.width-2, _animationView.frame.size.height-2);
    endRect = CGRectInset(endRect, -80, -80);
    return endRect;
}

- (void)dealloc
{
    [_timer invalidate];
    _timer = nil;
}

@end
