//
//  HYLocationTool.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/7/15.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYLocationTool.h"

@interface HYLocationTool ()<BMKLocationServiceDelegate>
{
    CLLocationDegrees locaLatitude;
    CLLocationDegrees locaLongitude;
}
@end

@implementation HYLocationTool

- (void)initLocation
{
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    _locService.desiredAccuracy =  kCLLocationAccuracyBest;
    _locService.distanceFilter = 10;//大于100米
    [_locService startUserLocationService];
}

- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation {
    
    //设置地图中心为用户经纬度
    if (_myMapView) {
        [_myMapView updateLocationData:userLocation];
    }
    NSLog(@"*********\nuserLocation:%@",userLocation);
    //定位当前城市
    BMKCoordinateRegion region;
    region.center.latitude  = userLocation.location.coordinate.latitude;
    region.center.longitude = userLocation.location.coordinate.longitude;
    region.span.latitudeDelta = 0;
    region.span.longitudeDelta = 0;
    NSLog(@"当前的坐标是:%f,%f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    
    [HYPublic_LocalData share].isSucessLoaction = YES;
    CLLocationCoordinate2D coor;
    coor.latitude = userLocation.location.coordinate.latitude;
    coor.longitude = userLocation.location.coordinate.longitude;
    if (self.LoactionCoordinate2DBlock) {
        self.LoactionCoordinate2DBlock(coor);
    }
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    WEAKSELF(self);
    [geocoder reverseGeocodeLocation: userLocation.location completionHandler:^(NSArray *array, NSError *error) {
        
        if (array.count > 0) {
            
            CLPlacemark *placemark = [array objectAtIndex:0];
            
            if (placemark != nil) {
                
                NSString *city = placemark.locality;
                
                NSLog(@"当前城市名称------%@",city);
                
                [HYPublic_LocalData share].location_City = city;
                
                if (weakself.callBackLocationBlock) {
                    weakself.callBackLocationBlock(city);
                }
//                BMKOfflineMap * _offlineMap = [[BMKOfflineMap alloc] init];
                // _offlineMap.delegate = self;//可以不要
                
//                NSArray* records = [_offlineMap searchCity:city];
//
//                BMKOLSearchRecord* oneRecord = [records objectAtIndex:0];
//
//                //城市编码如:北京为131
//
//                NSInteger cityId = oneRecord.cityID;
//                NSLog(@"当前城市编号-------->%zd",cityId);
                
                NSLog(@"当前城市的 哪个区------%@ ",placemark.subLocality);
                //找到了当前位置城市后就关闭服务
//                 [_locService stopUserLocationService];
                _locService.delegate = nil;
            }
        }
    }];
}

- (void)didFailToLocateUserWithError:(NSError *)error {
//    ALERT(@"定位失败");
    [HYPublic_LocalData share].isSucessLoaction = NO;
    if (self.callBackLocationBlock) {
        self.callBackLocationBlock(@"定位失败");
    }
    NSLog(@"error %@",error);
}
@end
