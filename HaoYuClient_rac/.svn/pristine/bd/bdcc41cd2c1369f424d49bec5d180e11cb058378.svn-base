//
//  HYLocationTool.h
//  HaoYuClient
//
//  Created by 刘文强 on 2018/7/15.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件
#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件
#import <BaiduMapAPI_Location/BMKLocationComponent.h>

//获取定位的经纬度
typedef void(^getLoactionCoordinate2DBlock) (CLLocationCoordinate2D coor);

@interface HYLocationTool : NSObject
@property (nonatomic, strong)BMKLocationService *locService;
@property (nonatomic, strong) BMKMapManager * mapManager;
@property (nonatomic, strong) BMKMapView * myMapView;

/**
 百度地图-初始化定位
 */
- (void)initLocation;

/**
 获取定位到的经纬度
 */
@property (nonatomic, copy) getLoactionCoordinate2DBlock LoactionCoordinate2DBlock;

/**
 返回的城市
 */
@property (nonatomic, copy) HYEventCallBackBlock  callBackLocationBlock;

@end
