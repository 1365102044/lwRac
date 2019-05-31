//
//  HYScoreItemView.h
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/5.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYBaseView.h"
#import "CoustomSlider.h"
@interface HYScoreItemView : HYBaseView
+ (instancetype)creatScoreItemView:(NSString *)title changeValue:(HYEventCallBackBlock)changeVauleBlock;
@property (nonatomic, strong) CoustomSlider * sliderView;
@end
