//
//  HYQianYue_IdCardView.h
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/19.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYBaseView.h"
#import "HYIdCardORCModel.h"

//单个上传图片
typedef void(^uploadImageBlock)(NSString *imageKey, UIImage *image);

@interface HYQianYue_IdCardView : HYBaseView
@property (nonatomic, copy) uploadImageBlock uploadImageBlock;
//识别身份证正面信息
@property (nonatomic, strong) HYIdCardORCModel * idcardModel;
/**
 选择的图片
 */
@property (nonatomic, strong) NSMutableArray * selectImageArrary;
@property (nonatomic, strong) NSMutableDictionary * param;

/**
 检查参数的合法性
 */
- (BOOL)checkParaLegal;
//上传 处理UI
- (void)handleUploadResult:(NSString *)imageKey status:(BOOL)isSuccess;
/**
 图片地址回传
 */
- (void)setUrlPara:(NSString *)urlKey urlValue:(NSString *)urlValue;
@end
