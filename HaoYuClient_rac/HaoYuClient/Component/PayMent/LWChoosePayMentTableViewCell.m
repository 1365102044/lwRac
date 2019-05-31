//
//  LWChoosePayMentTableViewCell.m
//  HaoYuClient
//
//  Created by 刘文强 on 2019/1/25.
//  Copyright © 2019年 LWQ. All rights reserved.
//

#import "LWChoosePayMentTableViewCell.h"
@interface LWChoosePayMentTableViewCell ()

@property (nonatomic, strong) UIImageView * left_icon;

@property (nonatomic, strong) HYDefaultButton * right_btn;

@property (nonatomic, strong) HYDefaultLabel * descLable;

@end

@implementation LWChoosePayMentTableViewCell

- (void)setTitle:(NSString *)title imageName:(NSString *)imageName
{
    _left_icon.image = IMAGENAME(imageName);
    _descLable.text = title;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.bottomSpacingLineView.hidden = YES;
        
        _left_icon = [[UIImageView alloc] init];
        _right_btn = [HYDefaultButton buttonImageWithImageNamed:@"mine_bill_select_n" type:HYProjectButtonSetImageDefault target:self selector:nil];
        _descLable = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(15)
                                              text:@""
                                         textColor:HYCOLOR.color_c4];
        _right_btn.userInteractionEnabled = NO;
        [self.contentView addSubviews:@[_left_icon,_right_btn,_descLable]];
        
        [_left_icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_offset(CGSizeMake(ADJUST_PERCENT_FLOAT(40), ADJUST_PERCENT_FLOAT(40)));
            make.left.equalTo(self.contentView.mas_left).offset(ADJUST_PERCENT_FLOAT(20));
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
        }];
        [_descLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_left_icon.mas_right).offset(ADJUST_PERCENT_FLOAT(10));
            make.centerY.mas_equalTo(_left_icon);
        }];
        [_right_btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_offset(CGSizeMake(ADJUST_PERCENT_FLOAT(20), ADJUST_PERCENT_FLOAT(20)));
            make.right.equalTo(self.contentView.mas_right).offset(-ADJUST_PERCENT_FLOAT(20));
            make.centerY.mas_equalTo(_left_icon);
        }];
        [self.contentView addSubview:self.bottomSpacingLineView];
        [self.bottomSpacingLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(ADJUST_PERCENT_FLOAT(20));
            make.right.equalTo(self.contentView.mas_right).offset(-ADJUST_PERCENT_FLOAT(20));
            make.top.mas_equalTo(self.contentView);
            make.height.mas_offset(0.5);
        }];
    }
    return self;
}

- (void)isSelectCell:(BOOL)isSelect
{
    NSString *name = isSelect ? @"mine_bill_select_s" : @"mine_bill_select_n";
    [_right_btn setBackgroundImage:IMAGENAME(name) forState:UIControlStateSelected];
    _right_btn.selected = isSelect;
}

@end
