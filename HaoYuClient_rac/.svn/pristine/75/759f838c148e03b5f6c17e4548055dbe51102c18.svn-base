//
//  HYBannerHandlerViewController.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/10/23.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYBannerHandlerManager.h"
#import "HYBannerActivityViewController.h"
#import "HYHuXingDeatilViewController.h"
#import "HYHouseRescourceDeatilViewController.h"
@interface HYBannerHandlerManager ()

@end

@implementation HYBannerHandlerManager

/**
 bannerModel:  数据模型
 sourceVC:     来源控制器
 extend:       扩展数据
 */
+ (void)handleWithBannerModel:(HYHomeBannnerModel *)bannerModel
         sourceViewControlelr:(HYBaseViewController *)sourceVC
                       extend:(id)extend
{
    if ([bannerModel lw_isNullObjectWith:[HYHomeBannnerModel class]]) {
        return;
    }
    
    /**
     promotionType :这个值为1的时候，如果有房型ID，就跳房型详情，没有房型ID， 跳项目详情
     */
    if (bannerModel.promotionType == 0 && [bannerModel.picBindLink isNotBlank] && ![bannerModel.picBindLink isEqualToString:@"空"]) {
        HYBannerActivityViewController *activity =  [[HYBannerActivityViewController alloc] init];
        activity.web_url  = bannerModel.picBindLink;
        activity.hidesBottomBarWhenPushed = YES;
        activity.title = bannerModel.name;
        [sourceVC.navigationController pushViewController:activity animated:YES];
    }else if(bannerModel.promotionType == 1 && [bannerModel.houseItemId isNotBlank]) {
        if ([bannerModel.houseRoomTypeId isNotBlank]) {
            HYHuXingDeatilViewController *huxingDeatilVC = [[HYHuXingDeatilViewController alloc] init];
            huxingDeatilVC.HuXingId = bannerModel.houseRoomTypeId;
            huxingDeatilVC.hidesBottomBarWhenPushed = YES;
            [sourceVC.navigationController pushViewController:huxingDeatilVC animated:YES];
        }else{
            HYHouseRescourceDeatilViewController *deatilVC = [[HYHouseRescourceDeatilViewController alloc] init];
            deatilVC.hidesBottomBarWhenPushed = YES;
            deatilVC.houseItemId = bannerModel.houseItemId;
            [sourceVC.navigationController pushViewController:deatilVC animated:YES];
        }
    }
}

@end
