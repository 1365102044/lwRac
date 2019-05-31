//
//  HYpicObjModel.h
//  HaoYuClient
//
//  Created by 刘文强 on 2018/7/13.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYBaseModel.h"

@interface HYpicObjModel : HYBaseModel
@property (nonatomic, copy) NSString * small;
@property (nonatomic, copy) NSString * big;
@property (nonatomic, copy) NSString * middle;
@property (nonatomic, copy) NSString * name;
@property (nonatomic, copy) NSString * fileType;

//创建人id
@property (nonatomic, copy) NSString * ctId;

//1有效；0删除
@property (nonatomic, copy) NSString * isDelete;
//图片id

@end
