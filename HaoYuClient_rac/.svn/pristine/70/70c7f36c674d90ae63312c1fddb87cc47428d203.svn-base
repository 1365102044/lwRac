//
//  HYHouseRescourcesModel.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/7/13.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYHouseRescourcesModel.h"

@implementation sheshiArrModel

@end
@implementation hiCityModel

@end

@implementation HYHouseRescourcesModel

+(NSDictionary<NSString *,id> *)modelCustomPropertyMapper
{
    return @{@"picObjcModel":@"picObj",
             @"hiCityModel":@"hiCity",
             @"picArrModel":@"picArr",
             @"roomTypeArrModel":@"roomTypeArr",
             @"sheshiArrModel":@"sheshiArr",
             @"customId":@"id",
             };
}
+(NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{
    return @{@"picArrModel":HYpicObjModel.class,
             @"roomTypeArrModel":HYHuXingInforModel.class,
             @"sheshiArrModel":sheshiArrModel.class
             };
}


//集中+分散式微信：1是集中，0不是 默认：1
- (NSString *)isJizhong
{
    return @"1";
}
//定金 默认是：1000
- (NSString *)money
{
    return @"1000";
}
/**
 当可租房间数为0时，返回5
 */
- (NSInteger)itemStatus
{
    if (_kezuNum == 0) {
        return 5;
    }else{
        return _itemStatus;
    }
}

//是否提前预定： 1、是 2、否
- (NSString *)bookInAdvance
{
    if (_houseStatus == 40) {
        return @"1";
    }else{
        return @"2";
    }
}

@end
