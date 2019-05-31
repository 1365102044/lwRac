//
//  YBIDScanResultAlearView.h
//  inborn
//
//  Created by 刘文强 on 2017/9/3.
//  Copyright © 2017年 inborn. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface YBIDScanResultAlearView : UIView

@property (nonatomic, strong) HYDefaultLabel * titlelable;

+ (instancetype)showAlearView;
- (void)dismissAlearView;

@end
