//
//  HYHouseTopView.h
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/25.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYBaseView.h"
#import "HYRightImageButton.h"
#import "HYDefaultTextField.h"
@interface HYHouseTopView : HYBaseView
@property (nonatomic, strong) HYDefaultTextField * yuJIruzhuTimeTextField;
@property (nonatomic, strong) HYRightImageButton *regionbtn;
@property (nonatomic, strong) HYRightImageButton *pricebtn;
@property (nonatomic, strong) HYDefaultButton * clearBtn;
- (void)updateClearBtnContransWithisShow:(BOOL)isShow;
@end
