//
//  LWHud.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/11/13.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "LWHud.h"

@implementation LWHud

+ (void)show
{
    [SVProgressHUD show];
}
+ (void)showWithStatus:(nullable NSString*)status
{
    [SVProgressHUD showWithStatus:status];
}

+ (void)dismiss
{
    [SVProgressHUD dismiss];
}

@end
