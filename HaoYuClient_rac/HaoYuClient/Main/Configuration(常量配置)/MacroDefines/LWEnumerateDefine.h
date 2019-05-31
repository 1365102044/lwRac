
//
//  LWEnumerateDefine.h
//  HaoYuClient
//
//  Created by 刘文强 on 2018/5/18.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#ifndef LWEnumerateDefine_h
#define LWEnumerateDefine_h


/**
 项目加载本地图片样式
 
 - HYProjectLoadImageDefault:                                   默认（直接加载原图）
 - HYProjectLoadImageFillet:                                    图片圆角化
 */
typedef NS_ENUM(NSUInteger, HYProjectLoadImageType) {
    HYProjectLoadImageDefault,
    HYProjectLoadImageFillet,
};

/**
 项目加载网络图片URLString
 
 - HYProjectImageURLStringDefault:                              默认（原图）
 - HYProjectImageURLStringWaterfallFlow:                        瀑布流
 - HYProjectImageURLStringList:                                 列表用小图
 - HYProjectImageURLStringListMid:                              列表用中等图
 - HYProjectImageURLStringMid:                                  详情展示中图
 - HYProjectImageURLStringLarge:                                点击大图
 - HYProjectImageUrlStringHeaderIcon:                           头像
 - HYProjectImageUrlStringBankLogo:                             银行图标
 */
typedef NS_ENUM(NSUInteger, HYProjectImageURLStringType) {
    HYProjectImageURLStringDefault,
    HYProjectImageURLStringWaterfallFlow,
    HYProjectImageURLStringList,
    HYProjectImageURLStringListMid,
    HYProjectImageURLStringMid,
    HYProjectImageURLStringLarge,
    HYProjectImageUrlStringHeaderIcon,
    HYProjectImageUrlStringBankLogo,
};

/**
 网络请求方式
 
 - HYProjectNetRequestNone:无方式（默认为POST请求）
 - HYProjectNetRequestPost:                                     POST请求
 - HYProjectNetRequestGet:                                      GET请求
 */
typedef NS_ENUM(NSUInteger, HYProjectNetRequestType) {
    HYProjectNetRequestNone,
    HYProjectNetRequestPost,
    HYProjectNetRequestGet,
};
/**
 项目初始化按钮时选择添加图片位置
 
 - HYProjectButtonSetImageDefault:                              默认（背景图片）
 - HYProjectButtonSetImage:                                     图片
 - HYProjectButtonSetBackgroundImage:                           背景图片
 */
typedef NS_ENUM(NSUInteger, HYProjectButtonSetImageType) {
    HYProjectButtonSetImageDefault,
    HYProjectButtonSetImage,
    HYProjectButtonSetBackgroundImage,
};

typedef NS_OPTIONS(NSUInteger, HYDiscountUseType) {
    DISCOUNT_NOFUND_TYPE     = 0,            //没有类型
    DISCOUNT_SHUI_DIAN_TYPE  = 1 << 0,   //水电费
    DISCOUNT_FANGZU_TYPE     = 1 << 1,      //房租
    DISCOUNT_FUWU_TYPE       = 1 << 2,         //服务费
    DISCOUNT_WANGFEI_TYPE    = 1 << 3,     //网费
    DISCOUNT_WUYE_TYPE       = 1 << 4         //物业费
};

/**
 支付类型
 PAYMENTTYPE_RECHARGE = 1                //充值类型
 PAYMENTTYPE_DEPOSIT,                    //定金类型
 PAYMENTTYPE_BILLPAY                     //账单类型 无优惠券
 PAYMENTTYPE_BILLDISCOUNTPAY             //账单类型 有优惠券
 */
typedef NS_ENUM(NSInteger, PayMentType) {
    PAYMENTTYPE_RECHARGE = 1,           //充值类型
    PAYMENTTYPE_DEPOSIT,            //定金类型
    PAYMENTTYPE_BILLPAY,            //账单类型 无优惠券
    PAYMENTTYPE_BILLDISCOUNTPAY,    //账单类型 有优惠券
};


///**
// 当前连接的服务类型
//
// - ServiceType_TEST: 测试服务器
// - ServiceType_PEIXU: 培训服务器
// - ServiceType_XUEYU: 薛云本地服务器
// - ServiceType_XINAN:   新安
// - ServiceType_ONLINE: 线上正式服务器
// 
// */
//typedef NS_ENUM(NSInteger, LWServiceType) {
//    ServiceType_TEST = 1,
//    ServiceType_PEIXU,
//    ServiceType_XUEYU,
//    ServiceType_XINAN,
//    
//    ServiceType_ONLINE,
//};


/**
 支付的付款方式
 */
typedef NS_ENUM(NSInteger, PayMentMethod) {
    WeiXinPayMethod = 1,   //微信支付
    AlipayPayMethod,     //支付宝
};

#endif /* LWEnumerateDefine_h */
