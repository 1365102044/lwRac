//
//  HYHuXingListTableViewCell.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/12.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYHuXingListTableViewCell.h"
#import "HYHuXingListCellView.h"
#import "HYHomePageModel.h"
@interface HYHuXingListTableViewCell ()
@property (nonatomic, strong) HYHuXingListCellView * cellView;
@end
@implementation HYHuXingListTableViewCell
- (void)setHuxingModel:(HYBaseModel *)huxingModel
{
    _huxingModel = huxingModel;
    if ([huxingModel isKindOfClass:[HYHuXingInforModel class]]) {
        HYHuXingInforModel *huxing_M = (HYHuXingInforModel *)huxingModel;
        HYpicObjModel *pic_M = huxing_M.picObjModel;
        [_cellView.houseImage sd_setImageWithURL:[NSURL URLWithString:HYIMAGEURLSTRING(HYProjectImageURLStringList, pic_M.small)] placeholderImage:IMAGENAME(@"占位图-200_200")];
        _cellView.houseNameLable.text = huxing_M.roomTypeName;
        self.cellView.houseWhereLable.text = [NSString stringWithFormat:@"%@室%@厅 %@",huxing_M.shi,huxing_M.ting,huxing_M.zhuangXiuModel.key];
        self.cellView.houseLayoutLable.text = [NSString stringWithFormat:@"面积：%@～%@㎡",huxing_M.iosMinMianji,huxing_M.iosMaxMianji];
        self.cellView.priceLable.text = [NSString stringWithFormat:@"%@元/月起",huxing_M.iosMinZujin];
        self.cellView.funcLabel.text = huxing_M.huxingModel.key;
    }else if ([huxingModel isKindOfClass:[HYHomeHuXingModel class]]){
        HYHomeHuXingModel *huxing_M = (HYHomeHuXingModel *)huxingModel;
        [_cellView.houseImage sd_setImageWithURL:[NSURL URLWithString:HYIMAGEURLSTRING(HYProjectImageURLStringList, huxing_M.picModel.small)] placeholderImage:IMAGENAME(@"占位图-200_200")];
        _cellView.houseNameLable.text = huxing_M.itemName;
        self.cellView.houseWhereLable.text = huxing_M.roomTypeName;
        self.cellView.houseLayoutLable.text = [NSString stringWithFormat:@"面积：%@㎡",huxing_M.iosRoomTypeArea];
        self.cellView.priceLable.text = [NSString stringWithFormat:@"%@元/月起",huxing_M.iosRoomTypeLowestprice ? huxing_M.iosRoomTypeLowestprice : @"?"];
        self.cellView.funcLabel.hidden = YES;
    }
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.cellView = [[HYHuXingListCellView alloc]init];
        [self.contentView addSubview:self.cellView];
        self.backgroundColor = HYCOLOR.color_c1;
        [self.cellView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(self.contentView);
            make.top.mas_equalTo(self.contentView.mas_top).mas_offset(ADJUST_PERCENT_FLOAT(10));
        }];
    }
    return self;
}

@end
