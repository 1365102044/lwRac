//
//  HYTouSuJianYiMainView.h
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/5.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYBaseView.h"
#import "HYPlaceHolderTextView.h"
#import "HYDefaultTextField.h"
#import "HYLeftRightArrowView.h"
#import "HYAddPhotoView.h"
@interface HYTouSuJianYiMainView : HYBaseView
@property (nonatomic, copy) HYEventCallBackBlock callBackBlock;
@property (nonatomic, strong) HYDefaultTextField *titleTextFiled;
@property (nonatomic, strong) HYPlaceHolderTextView *textview;
@property (nonatomic, strong) HYLeftRightArrowView *titleView;
@property (nonatomic, strong) HYAddPhotoView * addPhotoView;
@property (nonatomic, assign) NSInteger complaintType;

@end
