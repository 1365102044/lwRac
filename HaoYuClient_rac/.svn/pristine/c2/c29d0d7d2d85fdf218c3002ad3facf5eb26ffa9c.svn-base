//
//  HYADLaunchImageView.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/5/23.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYADLaunchImageView.h"

@interface HYADLaunchImageView()
@property (nonatomic, weak) UIImageView *adImageView;
@end

@implementation HYADLaunchImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self addAdImageView];
        
        [self addSingleTapGesture];
    }
    return self;
}

- (instancetype)initWithImage:(UIImage *)image
{
    if (self = [super initWithImage:image]) {
        
        [self addAdImageView];
        
        [self addSingleTapGesture];
    }
    return self;
}

- (void)addAdImageView
{
    UIImageView *imageView = [[UIImageView alloc]init];
    [self addSubview:imageView];
    _adImageView = imageView;
}

- (void)addSingleTapGesture
{
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleTapGesture:)];
    [self addGestureRecognizer:singleTap];
}

#pragma maek - setter

- (void)setURLString:(NSString *)URLString
{
    _URLString = URLString;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 异步操作
        NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:URLString]];
        
        if (!data) {
            return ;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            // 主线程更新
            _adImageView.alpha = 0.0;
            _adImageView.image = [UIImage imageWithData:data];
            
            //            [UIView animateWithDuration:0.3 animations:^{
            //                _adImageView.alpha = 1.0;
            //            }];
            
            [UIView animateWithDuration:0.3 delay:0.6 options:UIViewAnimationOptionCurveEaseOut animations:^{
                _adImageView.alpha = 1.0;
            } completion:nil];
        });
    });
}

#pragma mark - action

- (void)singleTapGesture:(UITapGestureRecognizer *)recognizer
{
    if (self.clickedImageURLHandle) {
        self.clickedImageURLHandle(self.URLString);
    }
    if (self.superview) {
        [self removeFromSuperview];
    }
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    if (self.hidden == NO && _adImageView.alpha > 0 && CGRectContainsPoint(_adImageView.frame, point)) {
        return self;
    }
    return nil;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _adImageView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)*0.78);
}


@end
