//
//  HYMapNavigation.h
//  HaoYuClient
//
//  Created by 刘文强 on 2018/7/18.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYMapNavigation : NSObject
/**
 开始导航
 */
- (void)startNavigationWith:(CLLocationCoordinate2D)coor currentVC:(UIViewController *)VC;

@end
