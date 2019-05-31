//
//  LWBasePopView.h
//  HaoYuClient
//
//  Created by 刘文强 on 2019/5/21.
//  Copyright © 2019年 LWQ. All rights reserved.
//

#import "HYBaseView.h"
#import "LWPingJiaPopView.h"
@interface LWPopViewController : UIViewController

+ (instancetype)showPopViewWithSourceVC:(UIViewController *)sourceVC popView:(LWPingJiaPopView *)popView extend:(id)extend;

- (void)dismiss;

@end

