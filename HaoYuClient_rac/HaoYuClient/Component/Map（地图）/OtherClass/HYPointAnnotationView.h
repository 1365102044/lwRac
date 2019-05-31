//
//  HYPointAnnotationView.h
//  HaoYuClient
//
//  Created by 刘文强 on 2018/7/19.
//  Copyright © 2018年 LWQ. All rights reserved.
//

//#import <BaiduMapAPI_Map/BaiduMapAPI_Map.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
@protocol XJClusterAnnotationViewDelegate <NSObject>

//- (void)didAddreesWithClusterAnnotationView:(XJCluster *)cluster clusterAnnotationView:(HYPointAnnotationView *)clusterAnnotationView;

@end
@interface HYPointAnnotationView : BMKPinAnnotationView
@property (nonatomic, copy)NSString *title;
@property (nonatomic, assign) NSInteger size;
//@property (nonatomic, strong) XJCluster *cluster;

@property (nonatomic, weak)id <XJClusterAnnotationViewDelegate>delegate;
@end
