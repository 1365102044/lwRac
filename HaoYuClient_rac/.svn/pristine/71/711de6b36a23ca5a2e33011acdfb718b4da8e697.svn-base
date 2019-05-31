//
//  HYHuXingInforModel.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/7/13.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYHuXingInforModel.h"
@implementation itemJsonModel

@end

@implementation zhuangXiuModel

@end
@implementation huXingModel

@end

@implementation HYHuXingInforModel
+(NSDictionary<NSString *,id> *)modelCustomPropertyMapper
{
    return @{@"huxingModel":@"huXing",
             @"zhuangXiuModel":@"zhuangXiu",
             @"picObjModel":@"picObj",
             @"itemModel":@"itemJson",
             @"picsModel":@"pic",
             @"customId":@"id",
             };
}
+(NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{
    return @{@"picsModel":HYpicObjModel.class};
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
@end
