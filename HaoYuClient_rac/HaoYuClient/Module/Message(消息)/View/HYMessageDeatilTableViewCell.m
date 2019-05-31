//
//  HYMessageDeatilTableViewCell.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/5/28.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYMessageDeatilTableViewCell.h"
#import "HYMessageDeatilCellView.h"

@interface HYMessageDeatilTableViewCell()
{
    BOOL isSelect;
}
@property (nonatomic, strong) HYMessageDeatilCellView * cellView;

@end

@implementation HYMessageDeatilTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.bottomSpacingLineView.hidden = YES;
        self.contentView.backgroundColor = HYCOLOR.color_c1;
        
        HYMessageDeatilCellView *cellview  = [[HYMessageDeatilCellView alloc] init];
        [self.contentView addSubview:cellview];
        _cellView = cellview;
        [cellview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView.mas_left).mas_offset(ADJUST_PERCENT_FLOAT(10));
            make.top.mas_equalTo(self.contentView.mas_top).mas_offset(ADJUST_PERCENT_FLOAT(1));
            make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-ADJUST_PERCENT_FLOAT(10));
            make.bottom.mas_equalTo(self.contentView.mas_bottom);
        }];
//        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.edges.mas_equalTo(self);
//        }];
        cellview.layer.cornerRadius = 4;
        cellview.layer.masksToBounds = YES;
        
        isSelect = NO;
        cellview.arrowIcon.userInteractionEnabled = YES;
        [cellview.arrowIcon bk_whenTapped:^{
            isSelect = !isSelect;
            if (isSelect) {
                [UIView animateWithDuration:0.25 animations:^{
                    cellview.arrowIcon.transform = CGAffineTransformMakeRotation(M_PI);
                }];
                cellview.descLable.numberOfLines = 0;
            }else{
                [UIView animateWithDuration:0.25 animations:^{
                    cellview.arrowIcon.transform = CGAffineTransformIdentity;
                }];
                cellview.descLable.numberOfLines = 1;
            }
            if (self.clickBlock) {
                self.clickBlock(self.indexPath);
            }
        }];
    }
    return self;
}

- (void)setMsgModel:(HYMessageModel *)msgModel
{
    _msgModel = msgModel;
    _cellView.topLable.text = msgModel.title;
    NSString *des = msgModel.content;
    des = des ? des : @"没有描述";
     _cellView.descLable.numberOfLines = 1;
    NSMutableParagraphStyle *parstyle = [[NSMutableParagraphStyle alloc] init];
    [parstyle setLineSpacing:5];
    [parstyle setLineBreakMode:NSLineBreakByWordWrapping];
    NSMutableAttributedString *atter = [[NSMutableAttributedString alloc] initWithString:des];
    [atter addAttribute:NSParagraphStyleAttributeName value:parstyle range:NSMakeRange(0, [des length])];
    _cellView.descLable.attributedText = atter;
    //显示省略号
    _cellView.descLable.lineBreakMode = NSLineBreakByTruncatingTail;
}

@end
