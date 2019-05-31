

//
//  LWTouSuJianYiBaseListTableViewCell.m
//  HaoYuClient
//
//  Created by 刘文强 on 2019/5/13.
//  Copyright © 2019年 LWQ. All rights reserved.
//

#import "LWTouSuJianYiBaseListTableViewCell.h"

@implementation LWTouSuJianYiBaseListTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.cellView = [[HYTouSuJianYiCellView alloc]init];
        [self.contentView addSubview:self.cellView];
        self.cellView.backgroundColor = HYCOLOR.color_c1;
        [self.cellView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.bottom.mas_equalTo(self.contentView);
        }];
    }
    return self;
}

- (void)setDataModel:(HYTouSuJianYiModel *)dataModel
{
    _dataModel = dataModel;
    _cellView.titleLable.text = [dataModel.title ex_base64Decode]? [dataModel.title ex_base64Decode] : @"无标题（公众号提交）";
    _cellView.phoneLable.text = dataModel.customerCalls;
    [_cellView.descLable setAttributedStringWithContentArray:@[@{@"color" :HYCOLOR.color_c4,
                                                                 @"content" : [dataModel.repairContent ex_base64Decode] ? [dataModel.repairContent ex_base64Decode] : @"",
                                                                 @"size" : SYSTEM_REGULARFONT(13),
                                                                 @"lineSpacing": @5}]];

    NSInteger sta = [dataModel.status integerValue];
    BOOL haveReply = !([dataModel.repairDetail isNotBlank] || dataModel.picurlArray.count > 0);
    switch (sta) {
        case 1://待处理
            [_cellView hiddenBtn:NO hiddenReplyView:haveReply];
            _cellView.statusImageView.image = IMAGENAME(@"statu_no_handle_icon");
            break;
        case 2://已派单
            [_cellView hiddenBtn:NO hiddenReplyView:haveReply];
            _cellView.statusImageView.image = IMAGENAME(@"statu_alearlyPaiDan_icon");
            break;
        case 3://已完成
            [_cellView hiddenBtn:YES hiddenReplyView:haveReply];
            _cellView.statusImageView.image = IMAGENAME(@"statu_alearlySuccess_icon");
            break;
        case 4://取消
            [_cellView hiddenBtn:YES hiddenReplyView:haveReply];
            _cellView.statusImageView.image = IMAGENAME(@"statu_alearlyCancle_icon");
            break;
        case 5://已验收
            _cellView.statusImageView.image = IMAGENAME(@"statu_alearlyYanShou_icon");
            [_cellView hiddenBtn:YES hiddenReplyView:haveReply];
            break;
        default:
            break;
    }
}

@end
