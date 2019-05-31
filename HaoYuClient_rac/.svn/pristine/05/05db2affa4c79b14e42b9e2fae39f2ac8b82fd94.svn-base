//
//  HYIdCardItemView.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/20.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYIdCardItemView.h"

@interface HYIdCardItemView ()
@property (nonatomic, strong) HYDefaultButton * maskLayer;

@end
@implementation HYIdCardItemView

- (void)showMaskLayer
{
    self.maskLayer.hidden = NO;
}

- (void)dismissMaskLayer
{
    self.maskLayer.hidden = YES;
}

- (void)setMaksLayerAlearMsg:(NSString *)msg
{
    if (msg) {
        [self.maskLayer setTitle:msg forState:UIControlStateNormal];
        _descLabel.text = @"";
    }
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.maskLayer];
        self.descLabel = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(14)
                                                  text:@""
                                             textColor:HYCOLOR.color_c2];
        [self addSubview:_descLabel];
        _descLabel.backgroundColor = [UIColor clearColor];
        
        [self.maskLayer mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self);
        }];
        [_descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        
        self.userInteractionEnabled = YES;
        [self bk_whenTapped:^{
            if (self.callBackBlock) {            
                self.callBackBlock(self);
            }
        }];
    }
    return self;
}

+ (instancetype)creatIdCardImageView:(NSString *)desc callBackBlock:(HYEventCallBackBlock)callBackBlock
{
    HYIdCardItemView *instance = [[HYIdCardItemView alloc] init];
    instance.descLabel.text = desc;
    instance.callBackBlock = callBackBlock;
    return instance;
}

- (void)setPicImage:(UIImage *)image
{
    if (image == nil) {
        return;
    }
    self.image = image;
    _descLabel.text = @"";
    [self showMaskLayer];
}

- (void)clickMaskLayer:(UIButton *)sender
{
    if ([sender.titleLabel.text isEqualToString:@"上传失败"]) {
        if (self.callBackBlock) {
            self.callBackBlock(self);
        }
    }
}

- (HYDefaultButton*)maskLayer
{
    if (!_maskLayer) {
        _maskLayer = [HYDefaultButton buttonWithTitleStringKey:@"图片上传中" titleColor:HYCOLOR.color_c0 titleFont:SYSTEM_REGULARFONT(14) target:self selector:@selector(clickMaskLayer:)];
        _maskLayer.alpha = 0.3;
        _maskLayer.backgroundColor = [UIColor blackColor];
        _maskLayer.hidden = YES;
    }
    return _maskLayer;
}

@end
