//
//  AipOcrServiceManger.h
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/25.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HYIdCardORCModel.h"
@interface AipOcrServiceManger : NSObject
@property (nonatomic, strong) HYIdCardORCModel * idCardModel;

+ (instancetype)share;
/**
 身份证识别  500次/日
 */
- (void)idcardOCROnlineFront:(UIImage *)image
                 ResultBlock:(HYEventCallBackBlock)ResultBlock
                   failBlock:(HYEventCallBackBlock)failBlock;
/**
 身份证识别 背面  500次/日
 */
- (void)idcardOCROnlineBack:(UIImage *)image
                ResultBlock:(HYEventCallBackBlock)ResultBlock
                  failBlock:(HYEventCallBackBlock)failBlock;

/**
 通用文字识别  5W次/日
 */
- (void)generalBasicOCR:(UIImage *)image
            ResultBlock:(HYEventCallBackBlock)ResultBlock
              failBlock:(HYEventCallBackBlock)failBlock;

- (void)ORCidCard:(NSArray *)idcardImages
      ResultBlock:(HYEventCallBackBlock)ResultBlock
        failBlock:(HYEventCallBackBlock)failBlock;
@end
