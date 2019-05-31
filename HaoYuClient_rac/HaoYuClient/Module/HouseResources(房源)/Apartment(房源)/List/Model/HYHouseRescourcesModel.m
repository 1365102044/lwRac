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

- (void)setPicObj:(NSDictionary *)picObj
{
    _picObjcModel = [HYpicObjModel modelWithJSON:picObj];
}


- (void)setPicArr:(NSArray *)picArr
{
    if (!picArr) {
        return;
    }
    NSMutableArray *temp = [[NSMutableArray alloc] init];
    for (NSDictionary * dict in picArr) {
        HYpicObjModel *model = [HYpicObjModel modelWithJSON:dict];
        [temp addObject:model];
    }
    _picArrModel = temp;
}

- (void)setHiCity:(NSDictionary *)hiCity
{
    _hiCityModel = [hiCityModel modelWithJSON:hiCity];
}

- (void)setRoomTypeArr:(NSArray *)roomTypeArr
{
    if (!roomTypeArr || roomTypeArr.count == 0) {
        return;
    }
    NSMutableArray *temp_arr = [[NSMutableArray alloc] init];
    for (NSDictionary *dict in roomTypeArr) {
        HYHuXingInforModel *model = [HYHuXingInforModel modelWithJSON:dict];
        [temp_arr addObject:model];
    }
    _roomTypeArrModel = temp_arr;
}

- (void)setSheshiArr:(NSArray *)sheshiArr
{
    if (!sheshiArr || sheshiArr.count == 0) {
        return;
    }
    NSMutableArray *temp_arr = [[NSMutableArray alloc] init];
    for (NSDictionary *dict in sheshiArr) {
        sheshiArrModel *model = [sheshiArrModel modelWithJSON:dict];
        [temp_arr addObject:model];
    }
    _sheshiArrModel = temp_arr;
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
@end
