//
//  LWNetWorkMacro.h
//  HaoYuClient
//
//  Created by 刘文强 on 2018/5/18.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#ifndef LWNetWorkMacro_h
#define LWNetWorkMacro_h
//** =========================================================================================== */
//** =========================================基础网络请求配置===================================== */
//** =========================================================================================== */

/**
 * 网络请求基础URLString
 */
#ifdef DEBUG


//协议地址
#define BASE_XIYI_URL                          @"http:"
//阿里云地址
#define BASE_ALIYUNPIC_URL                     @"http:"

#else

////正式接口
#define BASE_URL                               @"https:"
#define BASE_XIYI_URL                          @"http:"
#define BASE_ALIYUNPIC_URL                     @"http:"

#endif



#endif /* LWNetWorkMacro_h */

