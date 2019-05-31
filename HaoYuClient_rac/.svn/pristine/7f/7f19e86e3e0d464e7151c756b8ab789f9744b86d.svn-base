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

- (void)setHuXing:(NSDictionary *)huXing
{
    _huxingModel = [huXingModel modelWithJSON:huXing];
}
- (void)setZhuangXiu:(NSDictionary *)zhuangXiu
{
    _zhuangXiuModel = [zhuangXiuModel modelWithJSON:zhuangXiu];
}
- (void)setPicObj:(NSDictionary *)picObj
{
    _picObjModel = [HYpicObjModel modelWithJSON:picObj];
}
- (void)setItemJson:(NSDictionary *)itemJson
{
    _itemModel = [itemJsonModel modelWithJSON:itemJson];
}
- (void)setPic:(NSArray *)pic
{
    if (pic == nil || pic.count == 0) {
        return;
    }
    NSMutableArray *tem_arr = [[NSMutableArray alloc] init];
    for (NSDictionary *dict in pic) {
        HYpicObjModel *pic_M = [HYpicObjModel modelWithJSON:dict];
        [tem_arr addObject:pic_M];
    }
    _picsModel = tem_arr;
}
@end
