//
//  HYHouseProjectInforTool.h
//  HaoYuClient
//
//  Created by 刘文强 on 2018/7/17.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HYCityModel.h"

@interface HYHouseProjectInforTool : NSObject
///**
// 项目数据列表
// */
//@property (nonatomic, strong) NSMutableArray * projectArrary;
///**
// 户型数据列表
// */
//@property (nonatomic, strong) NSMutableArray * huxingArrary;
/////**
// 房间号数据
// */
//@property (nonatomic, strong) NSMutableArray * fangJianHaoArrary;


/**
 获取项目列表
 */
- (void)requestProjectInfor:(NSString *)cityId callBackBlock:(HYEventCallBackBlock)callBackBlock;

/**
 获取意向户型列表信息
 houseItemId   项目id
 */
- (void)requestHuxingListInfor:(NSString *)houseItemId callBackBlock:(HYEventCallBackBlock)callBackBlock;
/**
 roomTypeId  户型id
 */
- (void)requestFangJianHaoLevelInfor:(NSString *)roomTypeId callBackBlock:(HYEventCallBackBlock)callBackBlock;
/**
 根据城市获取项目列表 (地图找房)
 */
- (void)requestProjectInforByCityForMapFindHouseCallBackBlock:(HYEventCallBackBlock)callBackBlock;
/**
 获取优惠活动信息
 */
- (void)requestDiscountInforWithhouseId:(NSString *)houseId
                              startTime:(NSString *)startTime
                                endTime:(NSString *)endTime
                          callBackBlock:(HYEventCallBackBlock)callBackBlock;
/**
 获取 签约时的付款方式
 */
- (void)requestQianYuePayTypeMarkCallBackBlock:(HYEventCallBackBlock)callBackBlock;

/**
 生成签约账单
 */
- (void)ZuKeQianYuCreateBill:(NSDictionary *)param callBackBlock:(HYEventCallBackBlock)callBackBlock;

/**
 生成签约合同
 */
- (void)QianYueCreateHeTong:(NSDictionary *)param callBackBlock:(HYEventCallBackBlock)callBackBlock;

/**
 上传图片
 images         图片数组
 fileNames      文件名字  与图片个数相同
 
 返回 :
 {"success":[{@"pic":@"url",}];@"fail":[]}
 */
- (void)uploadIdCardImages:(NSArray *)images
                 fileNames:(NSArray *)fileNames
             callBackBlock:(HYEventCallBackBlock)callBackBlock;


@end
