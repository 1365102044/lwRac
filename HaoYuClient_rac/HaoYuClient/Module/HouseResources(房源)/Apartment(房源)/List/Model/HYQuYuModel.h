//
//  HYQuYuModel.h
//  HaoYuClient
//
//  Created by 刘文强 on 2018/7/19.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYBaseModel.h"

@interface HYQuYuModel : HYBaseModel
//区域名称
@property (nonatomic, copy) NSString * townName;
@property (nonatomic, copy) NSString * cityName;
@property (nonatomic, copy) NSString * lng;
@property (nonatomic, copy) NSString * lat;
//城市编号
@property (nonatomic, copy) NSString * cityCode;

//id  区域id

@property (nonatomic, copy) NSString * cityId;

@end
