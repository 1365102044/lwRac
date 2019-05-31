//
//  HYYouHuiQuanTableViewCell.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/9.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYYouHuiQuanTableViewCell.h"
#import "HYYouHuiQuanCellView.h"
@interface HYYouHuiQuanTableViewCell()
@property (nonatomic, strong) HYYouHuiQuanCellView * cellView;
@end
@implementation HYYouHuiQuanTableViewCell
- (void)setDiscountModel:(HYDiscountModel *)discountModel
{
    _discountModel = discountModel;
    self.cellView.titleLable.text = discountModel.couponTitle;
    self.cellView.youxiaoTimeLable.text = [NSString stringWithFormat:@"%@~%@",discountModel.ov[@"begintime"],discountModel.ov[@"endtime"]];
    
    [self.cellView.priceLable setAttributedStringWithContentArray:@[@{@"color" : HYCOLOR.color_c0,
                                                                      @"content" : discountModel.iosDedicated ? discountModel.iosDedicated : @"",
                                                                      @"size" : SYSTEM_MEDIUMFONT(36),
                                                                      @"lineSpacing": @1},
                                                                    @{@"color" : HYCOLOR.color_c0,
                                                                      @"content" : @"元",
                                                                      @"size" : SYSTEM_MEDIUMFONT(16),
                                                                      @"lineSpacing": @1}]];
    
    self.cellView.priceLable.numberOfLines = 1;
    [self.cellView.descLable setAttributedStringWithContentArray:@[@{@"color" : HYCOLOR.color_c0,
                                                                     @"content" : [NSString stringWithFormat:@"可用于%@\n可用于抵扣%@\n满%@元可用",discountModel.couponItemName,discountModel.couponType,discountModel.iosDedicatedMin],
                                                                     @"size" : SYSTEM_MEDIUMFONT(12),
                                                                     @"lineSpacing": @2}]];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.cellView = [[HYYouHuiQuanCellView alloc]init];
        [self.contentView addSubview:self.cellView];
        [self.cellView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView.mas_left).mas_offset(ADJUST_PERCENT_FLOAT(10));
            make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-ADJUST_PERCENT_FLOAT(10));
            make.top.mas_equalTo(self.contentView.mas_top).mas_offset(ADJUST_PERCENT_FLOAT(10));
            make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(-ADJUST_PERCENT_FLOAT(10));
        }];
        
        [self.cellView bk_whenTapped:^{
            if (self.clickBlock) {
                self.clickBlock(self.indexPath);
            }
        }];
    }
    return self;
}
@end
