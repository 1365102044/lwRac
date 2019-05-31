//
//  HYBillModel.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/6.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYBillModel.h"


@implementation houseItemModel
@end
@implementation houseModel
@end
@implementation typeModel
@end

@implementation HYBillModel

+(NSDictionary<NSString *,id> *)modelCustomPropertyMapper
{
    return @{@"customId":@"id",
             @"houseModel":@"house",
             @"typeMdodel":@"type",
             @"houseItemModel":@"houseItem",
             };
}
//- (void)setHouse:(NSDictionary *)house
//{
//    if (house) {
//        _houseModel = [houseModel modelWithJSON:house];
//    }
//}
//
//- (void)setType:(NSDictionary *)type
//{
//    if (type) {
//        _typeMdodel =  [typeModel modelWithJSON:type];
//    }
//}
//
//- (void)setHouseItem:(NSDictionary *)houseItem
//{
//    if (houseItem) {
//        _houseItemModel = [houseItemModel modelWithJSON:houseItem];
//    }
//}

- (HYDiscountUseType)discUseType
{
    if ([self.typeMdodel.mark isEqualToString:@"b87b642d-625c-46af-90cc-ce0013eab814"]) {
        return DISCOUNT_FANGZU_TYPE;
    }else if ([self.typeMdodel.mark isEqualToString:@"bec9420a-8647-42c6-962b-190a7db02ca8"]){
        return DISCOUNT_FUWU_TYPE;
    }else if ([self.typeMdodel.mark isEqualToString:@"2911f319-1d77-4510-9f08-5ad4e36cadaa"] ||
              [self.typeMdodel.mark isEqualToString:@"a3485c21-44d2-4595-9eb9-2d865ab6e990"]){
        return DISCOUNT_SHUI_DIAN_TYPE;
    }else if ([self.typeMdodel.mark isEqualToString:@"8c7a5a9a-0c95-4a5f-9fbf-fb21b601d61c"]){
        return DISCOUNT_WANGFEI_TYPE;
    }else if ([self.typeMdodel.mark isEqualToString:@"80fe8dc9-c00f-4d4e-8366-b77b655acf17"]){
        return DISCOUNT_WUYE_TYPE;
    }else{
        return DISCOUNT_NOFUND_TYPE;
    }
}
@end
