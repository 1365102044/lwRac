//
//  HYBaseCellView.h
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/1.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYBaseView.h"

@interface HYBaseCellView : HYBaseView
{
    CGFloat MAGR;
}
@property (strong, nonatomic)  UIView *bgView;
@property (strong, nonatomic)  UIImageView *houseImage;
@property (strong, nonatomic)  HYDefaultLabel *houseNameLable;
@property (strong, nonatomic)  HYDefaultLabel *houseWhereLable;
@property (strong, nonatomic)  HYDefaultLabel *houseLayoutLable;
@property (nonatomic, strong) HYDefaultLabel * hetongDescLable;
@property (nonatomic, strong) HYDefaultLabel * priceLable;

@property (nonatomic, strong) HYDefaultLabel * funcLabel;
/**
 保修列表中的状态图片
 */
@property (nonatomic, strong) UIImageView * statuImageView;

@end
