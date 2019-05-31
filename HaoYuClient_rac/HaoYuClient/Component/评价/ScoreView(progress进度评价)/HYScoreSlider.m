//
//  HYScoreSlider.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/5.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYScoreSlider.h"

@interface HYScoreSlider()
{
    CGFloat SliederHeight;
}
@property (nonatomic, strong) UIImageView * bgview;

@end
@implementation HYScoreSlider

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        SliederHeight = 8;
        _bgview = [[UIImageView alloc] initWithFrame:CGRectMake(0, (frame.size.height - SliederHeight)/2, frame.size.width, SliederHeight)];
        _bgview.image = IMAGENAME(@"colorTrack");
        
        [self addSubview:_bgview];
        [self sendSubviewToBack:_bgview];
        
        [self setMinimumTrackImage:[self imageFromColor:[UIColor clearColor]] forState:UIControlStateNormal];
        [self setMaximumTrackImage:[self imageFromColor:[UIColor clearColor]] forState:UIControlStateNormal];
        
        UIImage *sliderimage =  [self OriginImage:[UIImage imageWithColor:HYCOLOR.color_c0] scaleToSize:CGSizeMake(20, 20)];
        [self setThumbImage:sliderimage forState:UIControlStateNormal];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    [self.bgview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.centerY.mas_equalTo(self);
        make.height.mas_offset(SliederHeight);
    }];
}

- (UIImage *)imageFromColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
-(UIImage*) OriginImage:(UIImage*)image scaleToSize:(CGSize)size

{
    UIGraphicsBeginImageContext(size);//size为CGSize类型，即你所需要的图片尺寸
    
    
    
    CGContextRef context        = UIGraphicsGetCurrentContext();
    CGRect rect                 = CGRectMake(size.width/4, size.height/4, size.width/2, size.height/2);
    CGContextAddEllipseInRect(context, rect);
    
    CGContextClip(context);
    [image drawInRect:rect];
    
    UIImage* scaledImage =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return scaledImage;
    
}

@end
