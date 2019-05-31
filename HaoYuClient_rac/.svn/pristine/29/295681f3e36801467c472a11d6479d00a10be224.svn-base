//
//  LWPayInforTableViewCell.m
//  HaoYuClient
//
//  Created by 刘文强 on 2019/2/18.
//  Copyright © 2019年 LWQ. All rights reserved.
//

#import "LWPayInforTableViewCell.h"

@implementation LWPayInforTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        _left_L = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(15) text:@"" textColor:HYCOLOR.color_c4];
        _right_L = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(15) text:@"" textColor:HYCOLOR.color_c4];
        
        [self.contentView addSubviews:@[_left_L,_right_L]];
        
        if ([reuseIdentifier isEqualToString:@"cell_payinfor"]) {
            [_left_L mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.left.equalTo(self.contentView.mas_left);
                make.width.offset(ADJUST_PERCENT_FLOAT(78));
                make.top.equalTo(self.contentView.mas_top).offset(3);
            }];
        
            [_right_L mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.left_L.mas_right).offset(5);
                make.right.equalTo(self.mas_right).offset(-5);
                make.top.equalTo(self.contentView.mas_top).offset(3); make.bottom.equalTo(self.contentView.mas_bottom).offset(-3);
            }];
            [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self);
            }];
            _left_L.textAlignment = NSTextAlignmentRight;
            _right_L.numberOfLines = 2;
        }else if ([reuseIdentifier isEqualToString:@"cell_discount"]){
            [_left_L mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.contentView.mas_centerY);
                make.left.equalTo(self.contentView.mas_left);
                make.top.bottom.equalTo(self.contentView);
                make.right.equalTo(_right_L.mas_left).offset(-10);
            }];
            [_right_L mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.contentView.mas_centerY);
                make.right.equalTo(self.contentView.mas_right);
                make.left.equalTo(_left_L.mas_right).offset(10);
            }];
            _right_L.textAlignment = NSTextAlignmentRight;
//            [_right_L setContentHuggingPriority:(UILayoutPriorityDefaultLow) forAxis:(UILayoutConstraintAxisHorizontal)];
//            [_left_L setContentHuggingPriority:(UILayoutPriorityDefaultHigh) forAxis:(UILayoutConstraintAxisHorizontal)];
            
            //压缩阻力，即抗压缩。值越大，越不容易被压缩。
            [_left_L setContentCompressionResistancePriority:(UILayoutPriorityDefaultLow) forAxis:(UILayoutConstraintAxisHorizontal)];
            [_right_L setContentCompressionResistancePriority:(UILayoutPriorityDefaultHigh) forAxis:(UILayoutConstraintAxisHorizontal)];
        }
        
        self.backgroundColor = self.contentView.backgroundColor = _left_L.backgroundColor = _right_L.backgroundColor = [UIColor clearColor];
    }
    return self;
}

@end
