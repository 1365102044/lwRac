//
//  HYHuXingDeatilMainView.h
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/12.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYBaseView.h"
#import "HYPictureCarouselView.h"
#import "HYHuXingInforModel.h"
#import "HYHuXingTopInforView.h"
@interface HYHuXingDeatilMainView : HYBaseView
@property (nonatomic, strong) HYHuXingTopInforView * topInforView;
@property (nonatomic, strong) HYPictureCarouselView * ImageScrollView;
@property (nonatomic, strong) HYHuXingInforModel * huxingInforModel;
@property (nonatomic, copy) HYEventCallBackBlock callBackBlock;

@end
