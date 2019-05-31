//
//  HYAnnotationView.h
//  HaoYuClient
//
//  Created by 刘文强 on 2018/7/16.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import <BaiduMapAPI_Map/BMKMapView.h>

@interface HYAnnotationView : BMKAnnotationView
+ (instancetype)annotationViewWithMap:(BMKMapView *)mapView withAnnotation:(id <BMKAnnotation>)annotation;
@end
