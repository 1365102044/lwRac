//
//  HYBaseTextFiled.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/8.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYBaseTextFiled.h"

@implementation HYbasetextfiled
/**
 禁止粘贴 复制
 */
-(BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    UIMenuController * menuController = [UIMenuController sharedMenuController];
    if(menuController) {
        [UIMenuController sharedMenuController].menuVisible = NO;
    }
    return NO;
}
@end


@implementation HYBaseTextFiled

- (NSString *)text
{
    return _textFiled.text;
}

- (void)setText:(NSString *)text
{
    _textFiled.text = text;
}
- (void)setMaxCount:(NSInteger)maxCount
{
    _maxCount = maxCount;
    [LWTFHandler handleTextFieldLenghtLimitWithTF:_textFiled maxCount:@(_maxCount)];
}

- (void)setUI
{
    _textFiled = [[HYbasetextfiled alloc] init];
    _maxCount = 200;
    [self addSubview:_textFiled];

    [_textFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.mas_equalTo(self);
        make.left.mas_equalTo(self.mas_left).mas_offset(3);
    }];
    [LWTFHandler handleTextFieldLenghtLimitWithTF:_textFiled maxCount:@(_maxCount)];
    WEAKSELF(self);
    self.textFiled.bk_didEndEditingBlock = ^(UITextField *tf) {
        if (weakself.DidEndEditingBlock) {
            weakself.DidEndEditingBlock(tf);
        }
    };
}


@end
