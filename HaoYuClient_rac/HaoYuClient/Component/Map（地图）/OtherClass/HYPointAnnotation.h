//
//  HYPointAnnotation.h
//  HaoYuClient
//
//  Created by 刘文强 on 2018/7/16.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import <BaiduMapAPI_Map/BMKMapView.h>
#import <BaiduMapAPI_Map/BMKPointAnnotation.h>
#import "HYPointModel.h"

@interface HYPointAnnotation : BMKPointAnnotation

@property (nonatomic, strong) HYPointModel * pointModel;
///所包含annotation个数
@property (nonatomic, assign) NSInteger size;
//@property (nonatomic, strong) XJCluster *cluster;

@end

