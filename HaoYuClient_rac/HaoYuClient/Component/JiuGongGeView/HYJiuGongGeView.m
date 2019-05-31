//
//  HYJiuGongGeView.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/5/24.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYJiuGongGeView.h"
#import "HYVerticalButton.h"
#import "HYTitleAndImageItemVerView.h"
@interface HYJiuGongGeView()
{
    // 图片大小
    CGFloat IMAGE_W;
    CGFloat IMAGE_H;
    
    NSInteger RowS;
    
    // 列间距
    CGFloat COLS_SPAC;
    // 行间距
    CGFloat ROWS_SPAC;
}

@property(nonatomic,strong) UIView * backView;

@end

@implementation HYJiuGongGeView

- (void)setDataArr:(NSArray *)dataArr
{
    _dataArr = dataArr;
    [self setSubView];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backView = [[HYBaseView alloc] init];
        [self addSubview:self.backView];
        [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self);
        }];
        [self setConfi];
    }
    return self;
}

- (void)setConfi
{
    // 列数
    self.ColS = 4;
    
    IMAGE_H = MARGIN * 6;
    // 列间距
    COLS_SPAC = 0;
    // 行间距
    ROWS_SPAC = ADJUST_PERCENT_FLOAT(10);
}

//设置列数
- (void)setColS:(NSInteger)ColS
{
    _ColS = ColS;
    // 图片大小 -----初始化时 如果传人宽度就是使用，不传按全屏宽度
    if (self.frame.size.width) {
        IMAGE_W = self.frame.size.width/_ColS;
    }else{
        IMAGE_W = SCREEN_WIDTH/_ColS;
    }
}

- (void)setSubView
{
    [self.backView removeAllSubviews];
    
    RowS = _dataArr.count%_ColS == 0 ? _dataArr.count/ _ColS : _dataArr.count/_ColS + 1;
    for (int i = 0; i < _dataArr.count; i ++) {
        NSDictionary *dict =  _dataArr[i];
        HYTitleAndImageItemVerView *itemView = [[HYTitleAndImageItemVerView alloc] init];
        if (self.items_image_W > 0) {
            itemView.imageW = self.items_image_W;
        }
        if(_titleTopConstrans != 0){itemView.titleTopConstrans = _titleTopConstrans;}
        
        [itemView setTitle:dict[@"title"] ImageName:dict[@"image"] callBack:^(NSString *title) {
            if (self.callBlock) {
                self.callBlock(title);
            }
        }];
        itemView.tag = i ;
        NSInteger rows                  = i/_ColS;
        NSInteger cols                  = i%_ColS;
        CGFloat IMX                     = cols*(IMAGE_W + COLS_SPAC);
        CGFloat IMY                     = rows*(IMAGE_H + ROWS_SPAC);
        [self.backView addSubview:itemView];
        [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.backView.mas_left).mas_offset(IMX);
            make.top.mas_equalTo(self.backView.mas_top).mas_offset(IMY);
            make.size.mas_offset(CGSizeMake(IMAGE_W, IMAGE_H));
            if (i == _dataArr.count - 1) {
                make.bottom.mas_equalTo(self.backView.mas_bottom).mas_offset(-MARGIN);
            }
        }];
    }
}


@end
