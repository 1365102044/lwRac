//
//  HYHomePageModel.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/7/31.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYHomePageModel.h"
@implementation HYBaseHomeModel
- (CGFloat)cellHeight
{
    if ([self isKindOfClass:[HYHomeHuXingModel class]]) {
        return ADJUST_PERCENT_FLOAT(280);
    }else if ([self isKindOfClass:[HYHomePageModel class]]){
        return ADJUST_PERCENT_FLOAT(260);
    }
    return 0;
}
@end

@implementation HYHomeBannnerModel

@end


@implementation HYHomeHuXingModel

+(NSDictionary<NSString *,id> *)modelCustomPropertyMapper
{
    return @{@"picModel":@"roomTypePic"};
}
//+(NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
//{
//    return  @{@"picModel":HYpicObjModel.class};
//}

@end

@implementation HYHomePageModel
/** 属性 映射 */
+(NSDictionary<NSString *,id> *)modelCustomPropertyMapper
{
    return @{@"picModel":@"itemPic",
             @"customId":@"id",
             };
}

@end
