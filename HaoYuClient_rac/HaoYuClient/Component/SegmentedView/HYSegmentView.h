//
//  HYSegmentView.h
//  HaoYuClient
//
//  Created by 刘文强 on 2018/10/10.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYBaseView.h"

@class HYSegmentView;
@protocol SegmentBtnViewDelegate <NSObject>

-(void)SegmentView:(HYSegmentView *)segmentView
         selectIndex:(NSInteger)selectIndex;

@end

typedef void(^SegmentBtnSelectIndexBlock)(NSInteger index);

@interface HYSegmentView : HYBaseView

@property (nonatomic , strong) UIFont *titleFont;

@property (nonatomic , weak) id<SegmentBtnViewDelegate> delegate;

+ (instancetype)segmentViewWithTitles:(NSArray *)titles
                  btnTitleNormalColor:(UIColor *)btnTitleNormalColor
                  btnTitleSelectColor:(UIColor *)btnTitleSelectColor
             btnBackgroundNormalColor:(UIColor *)btnBackgroundNormalColor
             btnBackgroundSelectColor:(UIColor *)btnBackgroundSelectColor
           SegmentBtnSelectIndexBlock:(SegmentBtnSelectIndexBlock)SegmentBtnSelectIndexBlock;
@end
