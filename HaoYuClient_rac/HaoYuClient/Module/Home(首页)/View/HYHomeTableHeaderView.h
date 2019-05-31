//
//  HYHomeTableHeaderView.h
//  HaoYuClient
//
//  Created by 刘文强 on 2018/7/12.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYBaseView.h"
#import "HYHomePageModel.h"
#import "HYPictureCarouselView.h"
@interface HYHomeTableHeaderView : HYBaseView
@property (nonatomic, copy) HYEventCallBackBlock clickFuncBtnBlcok;
@property (nonatomic, strong) NSArray * bannderModelArray;
@property (nonatomic, strong) HYPictureCarouselView * ImageScrollView;
@end
