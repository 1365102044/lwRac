//
//  HYWaterSurfaceCellView.h
//  HaoYuClient
//
//  Created by 刘文强 on 2018/5/31.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYBaseView.h"

@interface HYWaterSurfaceCellView : HYBaseView

@property (strong, nonatomic)  UIView *bgView;
@property (strong, nonatomic)  UIImageView *houseImage;
@property (strong, nonatomic)  HYDefaultLabel *houseNameLable;
@property (strong, nonatomic)  HYDefaultLabel *houseWhereLable;
@property (strong, nonatomic)  HYDefaultLabel *houseLayoutLable;
@property (nonatomic, strong) HYDefaultButton * funcBtn;

@end
