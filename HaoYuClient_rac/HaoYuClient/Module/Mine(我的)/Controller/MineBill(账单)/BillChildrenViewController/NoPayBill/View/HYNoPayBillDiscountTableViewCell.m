//
//  HYNoPayBillDiscountTableViewCell.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/9/19.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYNoPayBillDiscountTableViewCell.h"
#import "HYNoPayBillListCellView.h"
@interface HYNoPayBillDiscountTableViewCell ()

@end
@implementation HYNoPayBillDiscountTableViewCell

- (void)setDataArr:(NSArray *)dataArr
{
    HYBillModel *billModel = dataArr.firstObject;
    self.billView.timeLable.text = billModel.beginTime;
    self.billView.storeLable.text = [NSString stringWithFormat:@"%@ %@栋%@号",billModel.houseItemModel.hiItemName,billModel.houseModel.louNo,billModel.houseModel.fangNo];
    self.billView.itemsDataArr = dataArr;
    self.billView.leftSelectBtn.selected = billModel.cellIsSelect;
    if (billModel.cellIsSelect) {
        [self.billView updateConsWithisShow:YES];
        [self.billView setDiscountDatas:billModel.selectDiscModels];
    }else{
        [self.billView updateConsWithisShow:NO];
        [self.billView setDiscountDatas:nil];
    }
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = HYCOLOR.color_c1;
        [self.contentView addSubview:self.billView];
        [self.billView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView.mas_left).mas_offset(ADJUST_PERCENT_FLOAT(10));
            make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-ADJUST_PERCENT_FLOAT(10));
            make.top.mas_equalTo(self.contentView.mas_top).mas_offset(ADJUST_PERCENT_FLOAT(5));
            make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(-ADJUST_PERCENT_FLOAT(5));
        }];
        [self.billView.selectBtn addTarget:self action:@selector(clickChooseDisc:) forControlEvents:UIControlEventTouchUpInside];
        [self.billView bk_whenTapped:^{
            BOOL temp_bool = self.billView.leftSelectBtn.selected;
            if ([self.delegate respondsToSelector:@selector(selectCellWithBool:indexPath:)]) {
                [self.delegate selectCellWithBool:!temp_bool indexPath:self.indexPath];
            }
        }];
        [_billView updateConsWithisShow:NO];
    }
    return self;
}

- (void)clickChooseDisc:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(refreshTableForDiscWithIndexpath:)]) {
        [self.delegate refreshTableForDiscWithIndexpath:self.indexPath];
    }
}

- (void)setindexpath:(NSIndexPath *)indexpath
{
    self.indexPath = indexpath;
    self.billView.indexpath = indexpath;
}

- (HYNoPayBillListCellView *)billView
{
    if (!_billView) {
        _billView = [HYNoPayBillListCellView creatNoPayBillListCellView];
        [_billView setBoundWidth:0 cornerRadius:6];
    }
    return _billView;
}

- (NSMutableArray*)discDatas
{
    if (!_discDatas) {
        _discDatas = [[NSMutableArray alloc] init];
    }
    return _discDatas;
}
@end
