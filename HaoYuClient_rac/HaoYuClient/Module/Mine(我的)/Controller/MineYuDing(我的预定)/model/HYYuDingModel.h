//
//  HYYuDingModel.h
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/22.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYBaseModel.h"

@interface HYYuDingModel : HYBaseModel
@property (nonatomic, copy) NSDictionary * picObj;
@property (nonatomic, strong) NSString * zukeName;
@property (nonatomic, strong) NSString * ct;
@property (nonatomic, copy) NSString * signTime;
@property (nonatomic, copy) NSString * zukePhone;
@property (nonatomic, copy) NSString * indentType;
@property (nonatomic, strong) NSDictionary * houseJson;
@property (nonatomic, strong) NSString * balanceSheetId;

@end
/**
 houseJson =     {
 itemJson =     {
 hiItemName = "好寓郑州郑汴路店",
 deptId = "1f158dadfaae448e9a4176ed87563baa",
 id = "B790CD19MB88324F2C184D53524C67D77959",
 hiDetailedAddress = "郑汴路长城康桥花园-17号楼",
 mendianPhone = "18039573530",
 lng = 113.689928,
 lat = 34.754548,
 },
 rent = 1780,
 louNo = "1",
 fangNo = "F05",
 houseId = "beb562e4dd9a4d2aab13a2fbc896688f",
 },
 */
