//
//  LWHud.h
//  HaoYuClient
//
//  Created by 刘文强 on 2018/11/13.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SVProgressHUD.h>
@interface LWHud : NSObject

+ (void)show;
+ (void)showWithStatus:(nullable NSString*)status;

+ (void)dismiss;
@end
