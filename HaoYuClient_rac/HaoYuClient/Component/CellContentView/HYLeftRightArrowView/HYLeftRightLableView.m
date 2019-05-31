//
//  HYLeftRightLableView.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/20.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYLeftRightLableView.h"

@implementation HYLeftRightLableView

+(instancetype)creatOnlyLeftRightLableView:(NSString *)leftStr
                                  rightStr:(NSString *)rightStr
                             CallBackBlock:(HYEventCallBackBlock)CallBackBlock
{
    HYLeftRightLableView * instance = [self creatLeftRightLableArrowViewWithLeftStr:leftStr
                                                                            rightStr:rightStr
                                                                       showArrowIcon:NO
                                                                       CallBackBlock:CallBackBlock];
    [instance updateConst];
    return instance;
}
- (void)updateConst
{
    [self.rightLable mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).mas_offset(-MARGIN);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
}
@end
