//
//  AipOcrServiceManger.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/25.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "AipOcrServiceManger.h"
#import <AipOcrSdk/AipOcrSdk.h>
@implementation AipOcrServiceManger

+ (instancetype)share
{
    static AipOcrServiceManger *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[AipOcrServiceManger alloc] init];
        [[AipOcrService shardService] authWithAK:APP_KEY_BAIDUAI_IDCARD andSK:SECRET_KEY_BAIDUAI_IDCARD];
        instance.idCardModel = [[HYIdCardORCModel alloc] init];
    });
    return instance;
}

- (void)ORCidCard:(NSArray *)idcardImages
      ResultBlock:(HYEventCallBackBlock)ResultBlock
        failBlock:(HYEventCallBackBlock)failBlock
{
    _idCardModel = [[HYIdCardORCModel alloc] init];
    if (idcardImages == nil ||
        idcardImages.count == 0) {
        return;
    }
//    UIImage *zheng = nil;
//    UIImage *fan = nil;
//    for (NSDictionary *dict in idcardImages) {
//        if (dict[@"zheng"]) {
//            zheng = dict[@"zheng"];
//        }
//        if (dict[@"fan"]) {
//            fan = dict[@"fan"];
//        }
//    }
//    if (zheng) {
//        [self idcardOCROnlineFront:zheng
//                       ResultBlock:^(id sender) {
//                           [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//                               if (ResultBlock) {
//                                   ResultBlock(sender);
//                               }
//                           }];
//
//                       } failBlock:^(id sender) {
//                           [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//                               if (failBlock) {
//                                   failBlock(sender);
//                               }
//                           }];
//                       }];
//    }
//    if (fan) {
//        [self idcardOCROnlineBack:fan
//                      ResultBlock:^(id sender) {
//                          [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//                              if (ResultBlock) {
//                                  ResultBlock(sender);
//                              }
//                          }];
//                      } failBlock:^(id sender) {
//                          [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//                              if (failBlock) {
//                                  failBlock(sender);
//                              }
//                          }];
//                      }];
//    }
//
    NSMutableArray *imags = [[NSMutableArray  alloc] init];
    for (NSDictionary *dic in idcardImages) {
        UIImage *zheng = dic[@"zheng"];
        UIImage *fan = dic[@"fan"];
        if (zheng) {
            [imags addObject:zheng];
        }else if (fan){
            [imags addObject:fan];
        }
    }
    for (UIImage *img in imags) {
        [self generalBasicOCR:img
                  ResultBlock:^(id sender) {
                      [self handleResultOfGeneral:sender];
                      LWLog(@"=======%@",sender);
                      [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                          if (ResultBlock) {
                              ResultBlock(sender);
                          }
                      }];
                  } failBlock:^(id sender) {
                      [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                          if (failBlock) {
                              failBlock(sender);
                          }
                      }];
                  }];
    }
   
}


/**
 身份证识别 正面  500次/日
 */
- (void)idcardOCROnlineFront:(UIImage *)image
                 ResultBlock:(HYEventCallBackBlock)ResultBlock
                   failBlock:(HYEventCallBackBlock)failBlock
{
    [[AipOcrService shardService] detectIdCardFrontFromImage:image
                                                 withOptions:nil
                                              successHandler:^(id result) {
                                                  [self handleResult:result];
                                                  ResultBlock(result);
                                              } failHandler:^(NSError *err) {
                                                  LWLog(@"*****身份证正面识别error:%@",err);
                                                  [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                                      NSString *errCode = [NSString stringWithFormat:@"errCode:%ld",(long)err.code];
                                                      ALERT(errCode);
                                                  }];
                                                  failBlock(err);
                                              }];
}

/**
 身份证识别 背面  500次/日
 */
- (void)idcardOCROnlineBack:(UIImage *)image
                ResultBlock:(HYEventCallBackBlock)ResultBlock
                  failBlock:(HYEventCallBackBlock)failBlock
{
    [[AipOcrService shardService] detectIdCardBackFromImage:image
                                                withOptions:nil
                                             successHandler:^(id result) {
                                                 [self handleResult:result];
                                                 ResultBlock(result);
                                             } failHandler:^(NSError *err) {
                                                 LWLog(@"*****身份证反面识别error:%@",err);
                                                 [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                                     NSString *errCode = [NSString stringWithFormat:@"errCode:%ld",(long)err.code];
                                                     ALERT(errCode);
                                                 }];
                                                 failBlock(err);
                                             }];
}

/**
 通用文字识别  5W次/日
 */
- (void)generalBasicOCR:(UIImage *)image
            ResultBlock:(HYEventCallBackBlock)ResultBlock
              failBlock:(HYEventCallBackBlock)failBlock{
    
    NSDictionary *options = @{@"language_type": @"CHN_ENG", @"detect_direction": @"true"};
    [[AipOcrService shardService] detectTextBasicFromImage:image
                                               withOptions:options
                                            successHandler:^(id result) {
                                                [self handleResultOfGeneral:result];
                                                ResultBlock(result);
                                            } failHandler:^(NSError *err) {
                                                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                                    NSString *errCode = [NSString stringWithFormat:@"errCode:%ld",(long)err.code];
//                                                    ALERT(errCode);
                                                }];
                                                failBlock(err);
                                            }];
}

/**
 处理身份证识别结果
 */
- (void)handleResult:(id)result
{
    NSString *name = result[@"words_result"][@"姓名"][@"words"];
    NSString *birthday = result[@"words_result"][@"出生"][@"words"];
    NSString *idcardNumber = result[@"words_result"][@"公民身份号码"][@"words"];
    NSString *six = result[@"words_result"][@"性别"][@"words"];
    NSString *addr = result[@"words_result"][@"住址"][@"words"];
    NSString *nation = result[@"words_result"][@"民族"][@"words"];
    NSString *outTime = result[@"words_result"][@"失效日期"][@"words"];
    NSString *starTime = result[@"words_result"][@"签发日期"][@"words"];
    NSString *office = result[@"words_result"][@"签发机关"][@"words"];
    if(name) _idCardModel.name = name;
    if(birthday) _idCardModel.birthday = birthday;
    if(idcardNumber) _idCardModel.idcardNumber = idcardNumber;
    if(six) _idCardModel.six = six;
    if(addr) _idCardModel.addr = addr;
    if(nation) _idCardModel.nation = nation;
    if(outTime) _idCardModel.outTime = [self handleOutTime:outTime];
    if(starTime) _idCardModel.starTime = [self handleOutTime:starTime];
    if(office) _idCardModel.office = office;
}
- (NSString *)handleOutTime:(NSString *)str
{
    if ([str containsString:@"-"]) {
        return str;
    }
    NSString *temp = @"";
    int count = 0;
    for (int i = 0; i < str.length; i++) {
        count++;
        temp = [temp stringByAppendingString:[str substringWithRange:NSMakeRange(i, 1)]];
        if (count == 4) {
            temp = [NSString stringWithFormat:@"%@-", temp];
        }
        if (count == 6) {
            temp = [NSString stringWithFormat:@"%@-", temp];
        }
    }
    return temp;
}

/**
 处理通用文字识别 数据
 */
- (void)handleResultOfGeneral:(id)result
{
    NSArray *resultArr = result[@"words_result"];
    
    for (NSDictionary *dic in resultArr) {
        NSString *words  = dic[@"words"];
        if ([words hasPrefix:@"姓名"]) {
            _idCardModel.name = [words substringFromIndex:2];
        }else if ([words hasPrefix:@"性别"]){
            _idCardModel.six = [words substringWithRange:NSMakeRange(2, 1)];
        }else if ([words hasPrefix:@"公民身份号码"])
        {
            _idCardModel.idcardNumber = [words substringFromIndex:6];
        }else if ([words hasPrefix:@"有效期限性"])
        {
            NSString *temp = [words substringFromIndex:4];
            NSString *outtime = [temp componentsSeparatedByString:@"-"].lastObject;
            NSString *startime = [temp componentsSeparatedByString:@"-"].firstObject;
             _idCardModel.starTime = [startime stringByReplacingOccurrencesOfString:@"." withString:@"-"];
             _idCardModel.outTime = [outtime stringByReplacingOccurrencesOfString:@"." withString:@"-"];
        }
    }
}

@end
/**
 po sender[@"words_result"]
 <__NSArrayI 0x1c1665880>(
 {
 words = "姓名刘文强",
 },
 {
 words = "性别男。民族汉",
 },
 {
 words = "出生1988年5月6日",
 },
 {
 words = "住址河南省项城市三店乡绰刘",
 },
 {
 words = "村4号院",
 },
 {
 words = "公民身份号码41270219880506231X",
 }
 )
 
 */
