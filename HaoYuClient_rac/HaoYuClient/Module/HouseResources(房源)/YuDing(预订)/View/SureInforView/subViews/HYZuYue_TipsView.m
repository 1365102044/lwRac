//
//  HYZuYue_TipsView.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/15.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYZuYue_TipsView.h"
#import "HYAttributedStringLabel.h"
#import "HYZuYue_InforBaseView.h"
@interface HYZuYue_TipsView ()
@property (nonatomic, strong) HYBaseView * addInforView;
@property (nonatomic, strong) HYAttributedStringLabel * tipsView;
@property (nonatomic, strong) HYZuYue_InforBaseView * baseView;
@end
@implementation HYZuYue_TipsView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _baseView = [[HYZuYue_InforBaseView alloc] init];
        _baseView.titleLable.text = @"温馨提示";
        [self addSubview:_baseView];
        [_baseView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self);
        }];
        [_baseView addSubview:self.addInforView];
        [_addInforView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_baseView.titleLable.mas_bottom).mas_offset(MARGIN);
            make.left.mas_equalTo(_baseView.mas_left).mas_offset(MARGIN);
            make.right.mas_equalTo(_baseView.mas_right).mas_offset(-MARGIN);
            make.bottom.mas_equalTo(_baseView.mas_bottom).mas_offset(-MARGIN);
        }];
        [_baseView setBoundWidth:1 cornerRadius:6 boardColor:HYCOLOR.color_c6];
        
        [_tipsView setAttributedStringWithContentArray:@[@{@"color" : HYCOLOR.color_c4,
                                                           @"content" : @"   1.在您阅读完毕并确认本提示后，您须按操作流程支付定金，支付成功后将为您锁定并生成房源订单。 \n  2.您须在房源订单生成后的7日内完成签约，您已支付的定金将自动抵扣您本次签约房源的应付首笔支付款项。\n  3.如您在缴纳定金后的7日内因个人原因无法完成签约，将视为您放弃本次签约，房源将自动解除锁定，您已支付的定金将不再退还；如因客观原因导致房屋无法正常签约且无法协商，好寓将取消本次预订并全额退还您已支付的定金。",
                                                           @"size" : SYSTEM_REGULARFONT(13),
                                                           @"lineSpacing": @5},]];
        
    }
    return self;
}

- (HYBaseView*)addInforView
{
    if (!_addInforView) {
        _addInforView = [[HYBaseView alloc] init];
        _tipsView = [HYAttributedStringLabel labelWithFont:SYSTEM_REGULARFONT(14)
                                                      text:@""
                                                 textColor:HYCOLOR.color_c4];
        _tipsView.numberOfLines = 0;
        [_addInforView addSubview:_tipsView];
        [_tipsView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(_addInforView);
        }];
        
    }
    return _addInforView;
}
@end
