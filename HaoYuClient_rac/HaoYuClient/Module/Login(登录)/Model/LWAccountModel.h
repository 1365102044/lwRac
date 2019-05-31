//
//  LWAccountModel.h
//  HaoYuClient
//
//  Created by 刘文强 on 2019/5/31.
//  Copyright © 2019年 LWQ. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LWAccountModel : NSObject
@property (nonatomic, strong) NSString * phoneofpw;
@property (nonatomic, strong) NSString * pwofpw;

@property (nonatomic, strong) NSString * phoneofcode;
@property (nonatomic, strong) NSString * codeofcode;

@property (nonatomic, strong) NSString * pwofre;
@property (nonatomic, strong) NSString * phoneofre;
@property (nonatomic, strong) NSString * codeofre;

@end

NS_ASSUME_NONNULL_END
