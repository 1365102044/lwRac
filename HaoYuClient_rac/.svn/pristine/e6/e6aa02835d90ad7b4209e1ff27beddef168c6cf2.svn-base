//
//  WYScanResultModel.m
//  WYIDCardOCR
//
//  Created by 汪年成 on 17/7/6.
//  Copyright © 2017年 之静之初. All rights reserved.
//

#import "WYScanResultModel.h"

@implementation WYScanResultModel

- (BOOL)isEqual:(WYScanResultModel *)idInfo
{
    if (idInfo == nil) {
        return NO;
    }
    if (_type == 1) {
        if ((_type == idInfo.type) &&
            [_code isEqualToString:idInfo.code] &&
            [_name isEqualToString:idInfo.name] &&
            [_gender isEqualToString:idInfo.gender] &&
            [_gender isEqualToString:idInfo.gender] &&
            [_address isEqualToString:idInfo.address]) {
            return YES;
        }
    } else if (_type == 2) {
        if ([_issue isEqualToString:idInfo.issue] &&
            [_valid isEqualToString:idInfo.valid]) {
            return YES;
        }
    }
    return NO;
}

- (NSString *)toString {
    return [NSString stringWithFormat:@"身份证号:%@\n姓名:%@\n性别:%@\n民族:%@\n地址:%@\n签发机关:%@\n有效期:%@",
            _code, _name, _gender, _nation, _address, _issue, _valid];
}

- (BOOL)isOK {
    if (_code !=nil && _name!=nil && _gender!=nil && _nation!=nil && _address!=nil) {
        if (_code.length>0 && _name.length >0 && _gender.length>0 && _nation.length>0 && _address.length>0) {
            return YES;
        }
    }
    else if (_issue !=nil && _valid!=nil) {
        if (_issue.length>0 && _valid.length >0) {
            return YES;
        }
    }
    return NO;
}



- (NSString *)birthday
{
    if (!_code || _code == nil || _code.length < 14) {
        return @"";
    }
    
    NSString * bristr = [_code substringWithRange:NSMakeRange(6, 8)];
    if (bristr.length == 8) {
        NSString *year = [bristr substringWithRange:NSMakeRange(0, 4)];
        NSString *moth = [bristr substringWithRange:NSMakeRange(4, 2)];
        NSString *day = [bristr substringWithRange:NSMakeRange(6, 2)];
        return [NSString stringWithFormat:@"%@年%@月%@日",year,moth,day];
    }else{
        return @"";
    }
    
    
}

/**
 省
 */
- (NSString *)addrPro
{
    if (!_address) {
        return @"";
    }
    
    
    // 保存 Device 的现语言 (英语 法语 ，，，)
    NSMutableArray *userDefaultLanguages = [[NSUserDefaults standardUserDefaults]
                                            objectForKey:@"AppleLanguages"];
    // 强制 成 简体中文
    [[NSUserDefaults standardUserDefaults] setObject:[NSArray arrayWithObjects:@"zh-hans",nil]
                                              forKey:@"AppleLanguages"];
    
    //创建编码对象
    CLGeocoder *geocoder=[[CLGeocoder alloc]init];
    
    [geocoder geocodeAddressString:_address completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (error!=nil || placemarks.count==0) {
            return ;
        }
        
        // 停止位置更新
//        [geocoder stopUpdatingLocation];
        
        //创建placemark对象
        CLPlacemark *placemark=[placemarks firstObject];
        
        _addrPro = placemark.administrativeArea;
        _addrCity = placemark.locality;
        _addrDist = placemark.subLocality;
        
        // 还原Device 的语言
        [[NSUserDefaults standardUserDefaults] setObject:userDefaultLanguages forKey:@"AppleLanguages"];
    }];
    
    return _addrPro;
}


- (NSString *)typeExpIdcard
{
    if ([_valid containsString:@"长期"]) {
        return @"1";
    }
    return @"2";
}

- (NSString *)validPeriodStart
{
    if (!_valid || _valid.length == 0) {
        return @"";
    }
    if (![_valid containsString:@"-"]) {
        return _validPeriodStart;
    }
    NSArray *temp = [_valid componentsSeparatedByString:@"-"];
    NSString *statrstr = temp.firstObject;
    @try {
        if (statrstr && statrstr.length == 8) {
            NSString *years = [statrstr substringWithRange:NSMakeRange(0, 4)];
            NSString *moth = [statrstr substringWithRange:NSMakeRange(4, 2)];
            NSString *day = [statrstr substringWithRange:NSMakeRange(6, 2)];
            return [NSString stringWithFormat:@"%@.%@.%@",years,moth,day];
        }
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    return @"";
}

- (NSString *)validPeriodEnd
{
    if (!_valid || _valid.length == 0) {
        return @"";
    }
    if (![_valid containsString:@"-"]) {
        return _validPeriodEnd;
    }
    NSArray *temp = [_valid componentsSeparatedByString:@"-"];
    NSString *endstr = temp.lastObject;
    @try {
        if ([endstr containsString:@"长期"]) {
            return @"长期";
        }else if (endstr && endstr.length == 8) {
            NSString *years = [endstr substringWithRange:NSMakeRange(0, 4)];
            NSString *moth = [endstr substringWithRange:NSMakeRange(4, 2)];
            NSString *day = [endstr substringWithRange:NSMakeRange(6, 2)];
            return [NSString stringWithFormat:@"%@.%@.%@",years,moth,day];
        }
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    return @"";
}


- (NSString *)sexStr
{
    if ([_gender isEqualToString:@"男"]) {
        return @"1";
    }else {
    return @"2";
    }
}

/**
 带空格的身份证号码
 */
- (NSString *)idcardStr
{
    if (_code.length == 0 || _code== nil ) {
        return _code;
    }
    if (_code.length > 14) {
        NSString *str1 = [_code substringToIndex:6];
        NSString *str2 = [_code substringWithRange:NSMakeRange(6, 8)];
        NSString *str3 = [_code substringFromIndex:14];
        return [NSString stringWithFormat:@"%@ %@ %@",str1,str2,str3];
    }else{
        return _code;
    }
}


@end
