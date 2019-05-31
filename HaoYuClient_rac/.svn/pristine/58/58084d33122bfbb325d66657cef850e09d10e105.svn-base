
//
//  HYAddImageItemView.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/4.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYAddImageItemView.h"

@interface HYAddImageItemView()
@property (nonatomic, strong) HYDefaultButton * deleBtn;

@end

@implementation HYAddImageItemView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}

- (void)setUI
{
    _itemImageView = [[HYBaseImageView alloc] init];
    _itemImageView.backgroundColor = [UIColor redColor];
    [self addSubview:_itemImageView];
    [_itemImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(self).mas_offset(ADJUST_PERCENT_FLOAT(5));
        make.right.bottom.mas_equalTo(self).mas_offset(-ADJUST_PERCENT_FLOAT(5));
    }];
    
    self.masklayer = [HYDefaultButton buttonWithTitleStringKey:@""
                                                    titleColor:[UIColor redColor] titleFont:SYSTEM_REGULARFONT(13)
                                                        target:nil
                                                      selector:nil];
    self.masklayer.contentMode = NSTextAlignmentCenter;
    self.masklayer.alpha = 0.4;
    self.masklayer.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.masklayer];
//    self.masklayer.hidden = YES;
    
    _deleBtn = [HYDefaultButton buttonImageWithImageNamed:@"addphoto_n"
                                                     type:(HYProjectButtonSetImage)
                                                   target:self
                                                 selector:@selector(clickDele)];
    [self addSubview:_deleBtn];
    [_deleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(ADJUST_PERCENT_FLOAT(15), ADJUST_PERCENT_FLOAT(15)));
        make.right.mas_equalTo(_itemImageView.mas_right).mas_offset(ADJUST_PERCENT_FLOAT(5));
        make.top.mas_equalTo(_itemImageView.mas_top).mas_offset(-ADJUST_PERCENT_FLOAT(5));
    }];
  
    [self.masklayer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
}
- (void)setMaskerTitle:(NSString *)title
{
    [self.masklayer setTitle:title forState:UIControlStateNormal];
    [self.masklayer mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
}

- (void)uploadWithProgress:(CGFloat)progress
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.masklayer.hidden == NO) {
            [self.masklayer mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.right.bottom.mas_equalTo(self);
                make.top.mas_equalTo(self.mas_top).offset(self.height * progress);
            }];
            
            if (progress  == 1) {
                [self dismissMasklayer];
            }
        }
    });
}

- (void)dismissMasklayer
{
    self.masklayer.hidden = YES;
}

- (void)showMasklayer
{
    self.masklayer.hidden = NO;
}

- (void)clickDele
{
    POST_NOTI(@"clickDelebtn", self);
}

@end

