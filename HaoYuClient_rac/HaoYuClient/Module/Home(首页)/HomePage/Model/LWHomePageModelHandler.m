
//
//  LWHomePageModelHandler.m
//  HaoYuClient
//
//  Created by 刘文强 on 2019/5/9.
//  Copyright © 2019年 LWQ. All rights reserved.
//

#import "LWHomePageModelHandler.h"
#import "HYHomePageModel.h"
#import "HYAlertCenterView.h"

static NSString * const APPSTORE_URL = @"itms-apps://itunes.apple.com/cn/app/id1435254460?mt=8";

@interface LWHomePageModelHandler()
@property (nonatomic, strong) NSMutableArray * dataMutableArray;
@property (nonatomic, strong) NSLock * lwlock;
@end

@implementation LWHomePageModelHandler
// 检查版本
- (void)checkVersion
{
    PARA_CREART;
    PARA_SET(@"2", @"type");
    if(APPVERSION) PARA_SET(APPVERSION, @"iosVersion");
    PARA_SET(@"0", @"platform");
    [[HYServiceManager share] postRequestWithurl:CHECK_VERSION_URL
                                       paramters:para
                                    successBlock:^(id objc, id requestInfo) {
                                        NSArray *btnArray = [[NSArray alloc] init];
                                        NSString *hint = objc[@"result"][@"hint"];
                                        BOOL isMustUpdate = NO;
                                        if ([objc[@"result"][@"replace"] isEqualToString:@"true"]) {
                                            if ([objc[@"result"][@"mustReplace"] isEqualToString:@"true"]) {
                                                btnArray = @[@"更新"];
                                                isMustUpdate = YES;
                                            }else{
                                                btnArray = @[@"取消",@"更新"];
                                            }
                                        }
                                        if (btnArray.count == 0) {
                                            return ;
                                        }
                                        
                                        HYAlertCenterView *instnce =  [HYAlertCenterView showAlerCenterViewWithTitle:@"提示"
                                                                                                             message:hint
                                                                                                          titleArray:btnArray
                                                                                                           callBlock:^(id sender) {
                                                                                                               if ([sender isEqualToString:@"更新"]) {
                                                                                                                   [[UIApplication sharedApplication] openURL:[NSURL URLWithString:APPSTORE_URL] options:@{} completionHandler:nil];
                                                                                                               }
                                                                                                           }];
                                        instnce.AutoDismiss = !isMustUpdate;
                                    } failureBlock:^(id error, id requestInfo) {
                                    }];
}
/**
 获取首页banner
 
 @param callBackBlock   成功回调
 @param failureBlock    失败回调
 */
- (void)requestHomePageBannerWithCallBackBlock:(HYEventCallBackBlock)callBackBlock
                                  failureBlock:(HYEventCallBackBlock)failureBlock{
    PARA_CREART;
    PARA_SET(@"2", @"equipment"); //设备（1.微信，2.APP）
    [[HYServiceManager share] postRequestWithurl:HOMEPAGE_TUIGUANG_BANNER_URL
                                       paramters:para
                                    successBlock:^(id objc, id requestInfo) {
                                        NSMutableArray *bannerInforModelMutableArray = [[NSMutableArray alloc] init];
                                        NSArray *bannerPicList = objc[@"result"][@"bannerPicList"];
                                        if (bannerPicList && [bannerPicList isKindOfClass:[NSArray class]]) {
                                            for (NSDictionary *bannerPicList_dic in bannerPicList) {
                                                HYHomeBannnerModel *bannerModel =  [HYHomeBannnerModel modelWithJSON:bannerPicList_dic];
                                                [bannerInforModelMutableArray addObject:bannerModel];
                                            }
                                        }
                                        callBackBlock(bannerInforModelMutableArray);
                                    } failureBlock:^(id error, id requestInfo) {
                                        if(failureBlock) failureBlock(error);
                                    }];
}

/**
 首页的  推荐-户型、项目
 */
- (void)requestHomePageInforCallBackBlock:(HYEventCallBackBlock)callBackBlock failureBlock:(HYEventCallBackBlock)failureBlock
{
    PARA_CREART;
    NSString *city_id = [HYPublic_LocalData share].last_location_City_M.cityID;
    if(city_id) para[@"cityId"] = city_id;
    [[HYServiceManager share] postRequestAnWithurl:HOMEPAGE_TUIJIAN_HX_OR_FY_URL
                                         paramters:para
                                      successBlock:^(id objc, id requestInfo) {
                                          NSArray *huxing_Array = objc[@"result"][@"roomTypeList"];
                                          NSArray *project_Array = objc[@"result"][@"itemList"];
                                          NSMutableArray *HX_Muta = [[NSMutableArray alloc]init];
                                          NSMutableArray *PJ_Muta = [[NSMutableArray alloc]init];
                                          for (NSDictionary *dic in huxing_Array) {
                                              HYHomeHuXingModel *model = [HYHomeHuXingModel modelWithJSON:dic];
                                              [HX_Muta addObject:model];
                                          }
                                          for (NSDictionary *dic in project_Array) {
                                              HYHomePageModel *model = [HYHomePageModel modelWithJSON:dic];
                                              [PJ_Muta addObject:model];
                                          }
                                          if (HX_Muta.count == 1) {
                                              HYHomeHuXingModel *hx_model = [[HYHomeHuXingModel alloc] init];
                                              hx_model.popuPic = @"home_placeHoler_poppic";
                                              hx_model.tag = 100;
                                              [HX_Muta addObject:hx_model];
                                          }
                                          if (PJ_Muta.count == 1) {
                                              HYHomePageModel *pj_model = [[HYHomePageModel alloc] init];
                                              pj_model.tag = 100;
                                              pj_model.popuPic = @"home_placeHoler_poppic";
                                              [PJ_Muta addObject:pj_model];
                                          }
                                          NSMutableArray *dataMu = [NSMutableArray array];
                                          if (PJ_Muta.count > 0) [dataMu addObject:PJ_Muta];
                                          if (HX_Muta.count > 0) [dataMu addObject:HX_Muta];
                                          [self sortData:dataMu type:1];
                                          callBackBlock(dataMu);
                                      } failureBlock:^(id error, id requestInfo) {
                                          failureBlock(error);
                                      }];
}

/**
 获取 热分享
 
 @param callBackBlock 成功
 @param failureBlock 失败
 */
- (void)requestHomePageInforForHotShareCallBackBlock:(HYEventCallBackBlock)callBackBlock failureBlock:(HYEventCallBackBlock)failureBlock
{
    PARA_CREART;
    [[HYServiceManager share] postRequestAnWithurl:HOMEPAGE_HOT_SHARE_URL
                                         paramters:para
                                      successBlock:^(id objc, id requestInfo) {
                                          NSMutableArray *res = [[NSMutableArray alloc] init];
                                          NSArray *list = objc[@"result"][@"list"];
                                          for (NSDictionary *dict in list) {
                                              HYHomePageHotModel *hotshare = [HYHomePageHotModel modelWithJSON:dict];
                                              hotshare.modelType = HomePageHotModelTypeHotShare;
                                              [res addObject:hotshare];
                                          }
                                          [self sortData:res type:0];
                                          callBackBlock(res);
                                      } failureBlock:^(id error, id requestInfo) {
                                          failureBlock(error);
                                      }];
}
/**
 获取 热事件
 
 @param callBackBlock 成功
 @param failureBlock 失败
 */
- (void)requestHomePageInforForHotEventsCallBackBlock:(HYEventCallBackBlock)callBackBlock failureBlock:(HYEventCallBackBlock)failureBlock
{
    PARA_CREART;
    para[@"type"] = @"5";
    [[HYServiceManager share] postRequestAnWithurl:HOMEPAGE_HOT_EVENTS_URL
                                         paramters:para
                                      successBlock:^(id objc, id requestInfo) {
                                          NSMutableArray *res = [[NSMutableArray alloc] init];
                                          NSArray *list = objc[@"result"][@"list"];
                                          for (NSDictionary *dict in list) {
                                              HYHomePageHotModel *hotevents = [HYHomePageHotModel modelWithJSON:dict];
                                              hotevents.modelType = HomePageHotModelTypeHotEvents;
                                              [res addObject:hotevents];
                                          }
                                          [self sortData:res type:0];
                                          callBackBlock(res);
                                      } failureBlock:^(id error, id requestInfo) {
                                          failureBlock(error);
                                      }];
}

/**
 获取首页列表的所有数据
 
 @param callBackBlock 成功回调
 @param failureBlock 失败回调
 */
- (void)requestHomePageAllListInforCallBackBlock:(HYEventCallBackBlock)callBackBlock failureBlock:(HYEventCallBackBlock)failureBlock
{   
    [self requestHomePageInforCallBackBlock:^(id sender) {
        callBackBlock(self.dataMutableArray);
    } failureBlock:^(id sender) {
        failureBlock(sender);
    }];

//    [self requestHomePageInforForHotShareCallBackBlock:^(id sender) {
//        callBackBlock(self.dataMutableArray);
//    } failureBlock:^(id sender) {
//        failureBlock(sender);
//    }];
//
//    [self requestHomePageInforForHotEventsCallBackBlock:^(id sender) {
//        callBackBlock(self.dataMutableArray);
//    } failureBlock:^(id sender) {
//        failureBlock(sender);
//    }];
    
//    dispatch_group_t group = dispatch_group_create();
//        dispatch_queue_t queue = dispatch_queue_create("home.page.list.queue", DISPATCH_QUEUE_CONCURRENT);
//        NSMutableDictionary *infor_dict = [NSMutableDictionary dictionaryWithCapacity:3];
//        dispatch_group_async(group, queue, ^{
//        });
//        dispatch_group_async(group, queue, ^{
//        });
//        dispatch_group_async(group, queue, ^{
//        });
//
//        NSMutableArray *allInforArray = [NSMutableArray arrayWithCapacity:3];
//        dispatch_group_notify(group, queue, ^{
//            for (int i = 1; i < 4; i++) {
//                NSArray *item = infor_dict[@(i)];
//                if (i == 1) {
//                    [allInforArray addObjectsFromArray:item];
//                }else {
//                 [allInforArray addObject:item];
//                }
//            }
//            dispatch_async(dispatch_get_main_queue(), ^{
//                callBackBlock(allInforArray);
//            });
//        });
}

/** 按照section 排序数据 */
- (void)sortData:(NSArray *)dataArray type:(NSInteger)type
{
    [_lwlock lock];
    if (!self.dataMutableArray) {
        self.dataMutableArray = [[NSMutableArray alloc] init];
    }
    if (self.dataMutableArray.count == 0) {
        if (type != 0) {
            [self.dataMutableArray addObjectsFromArray:dataArray];
        } else{
            [self.dataMutableArray addObject:dataArray];
        }
        [_lwlock unlock];
        return;
    }
    if (type != 0) {
        [self.dataMutableArray addObjectsFromArray:dataArray];
    } else{
        [self.dataMutableArray addObject:dataArray];
    }
    self.dataMutableArray = [[self.dataMutableArray sortedArrayUsingComparator:^NSComparisonResult(NSArray *  _Nonnull obj1, NSArray * _Nonnull obj2) {
        HYBaseHomeModel *modelItem1 = obj1.firstObject;
        HYBaseHomeModel *modelItem2 = obj2.firstObject;
        if (modelItem1.section > modelItem2.section) {
            return NSOrderedDescending;
        }else{
            return NSOrderedAscending;
        }
    }] mutableCopy] ;
    [_lwlock unlock];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.lwlock = [[NSLock alloc] init];
    }
    return self;
}
@end
