//
//  UINavigationController+Extension.m
//  inborn
//
//  Created by 郑键 on 2017/8/23.
//  Copyright © 2017年 inborn. All rights reserved.
//

#import "UINavigationController+Extension.h"
//#import "ZJBaseNavigationController.h"

@implementation UINavigationController (Extension)

- (void)ex_hiddenBackBarButton
{
    UIViewController *currentController                 = self.childViewControllers.lastObject;
    [currentController.navigationItem setHidesBackButton:YES];
}

- (void)ex_ShowBackBarButton
{
    UIViewController *currentController                 = self.childViewControllers.lastObject;
    [currentController.navigationItem setHidesBackButton:NO];
}

@end
