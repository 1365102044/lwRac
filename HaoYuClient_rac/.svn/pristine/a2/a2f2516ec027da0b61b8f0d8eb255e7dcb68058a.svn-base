//
//  HYZhouBianView.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/11.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYZhouBianView.h"
#import "HYZhouBianItemView.h"

@interface HYZhouBianView ()
@property (nonatomic, strong) HYBaseView * bgView;

@end

@implementation HYZhouBianView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = HYCOLOR.color_c3;
        HYDefaultLabel *titleLable = [HYDefaultLabel labelWithFont:SYSTEM_MEDIUMFONT(15)
                                                              text:@"周边介绍"
                                                         textColor:HYCOLOR.color_c4];
        [self addSubview:line];
        [self addSubview:titleLable];
        _bgView = [[HYBaseView alloc] init];
        [self addSubview:_bgView];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_offset(1);
            make.left.top.mas_equalTo(self).mas_offset(MARGIN);
            make.height.mas_offset(ADJUST_PERCENT_FLOAT(25));
        }];
        [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(line.mas_right).mas_offset(MARGIN);
            make.centerY.mas_equalTo(line.mas_centerY);
        }];
        [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(titleLable.mas_bottom).mas_offset(MARGIN*2);
            make.left.mas_equalTo(self.mas_left).mas_offset(MARGIN);
            make.right.mas_equalTo(self.mas_right).mas_offset(-MARGIN);
            make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-MARGIN);
        }];
        
        _zhoubianDescLable = [HYAttributedStringLabel labelWithFont:SYSTEM_REGULARFONT(15)
                                                               text:@""
                                                          textColor:HYCOLOR.color_c4];
        _zhoubianDescLable.numberOfLines = 0;
        [self.bgView addSubview:_zhoubianDescLable];
        [_zhoubianDescLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.bgView.mas_top).mas_offset(0);
            make.left.mas_equalTo(self.mas_left).mas_offset(MARGIN);
            make.right.mas_equalTo(self.mas_right).mas_offset(-MARGIN);
            make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-MARGIN);
        }];
        
    }
    return self;
}
//- (void)setDataArray:(NSArray *)dataArray
//{
//    _dataArray = dataArray;
//    [self setUI];
//}
//- (void)setUI
//{
//    NSMutableArray *tem = [NSMutableArray array];
//    for (int i = 0; i < _dataArray.count; i++) {
//        NSDictionary *dict = self.dataArray[i];
//        HYZhouBianItemView *itemview = [[HYZhouBianItemView alloc] init];
//        itemview.titleLable.text = dict[@"title"];
//        itemview.titleImageView.image = IMAGENAME(dict[@"image"]);
//        [itemview.contentLable setAttributedStringWithContentArray:@[@{@"color" : HYCOLOR.color_c4,
//                                                                       @"content" : dict[@"content"] ? dict[@"content"] : @"",
//                                                                       @"size" : SYSTEM_REGULARFONT(13),
//                                                                       @"lineSpacing": @5},]];
//        [tem addObject:itemview];
//        [itemview setBoundWidth:1 cornerRadius:6 boardColor:HYCOLOR.color_c6];
//        [_bgView addSubview:itemview];
//        [itemview mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.right.mas_equalTo(_bgView);
//            if (i == 0) {
//                make.top.mas_equalTo(_bgView.mas_top);
//            }else{
//                HYZhouBianItemView *lastView = tem[i-1];
//                make.top.mas_equalTo(lastView.mas_bottom).mas_offset(MARGIN);
//            }
//            if(i == _dataArray.count - 1)
//                {
//                    make.bottom.mas_equalTo(_bgView.mas_bottom);
//                }
//        }];
//        
//    }
//}

@end
