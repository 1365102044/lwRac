//
//  HYMessageLocalData.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/12/12.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYMessageLocalData.h"
#import "HYMessageModel.h"
#import "LWFmdb.h"
@implementation HYMessageLocalData

/**
 处理信息数据
 
 @param objc 请求到的数据
 */
+ (void)handleMessageInforDatas:(id)objc isFromMsgPage:(BOOL)isFromMsgPage
{
    //    dispatch_async(dispatch_get_global_queue(0, 0), ^{
    
    NSDictionary *dic =  objc[@"result"];
    NSString *nowDate = nil;
    if([dic isKindOfClass:[NSDictionary class]]){
        nowDate = objc[@"result"][@"nowDate"];
    }
    
    NSMutableArray *dataMutableArray = [NSMutableArray array];
    NSArray *datas = objc[@"result"][@"list"];
    if([datas isKindOfClass:[NSArray class]]){
        for (NSDictionary *dict in datas) {
            HYMessageModel *model = [HYMessageModel modelWithJSON:dict];
            [dataMutableArray addObject:model];
        }
    }
    
    //如果本地没有上次更新的时间则清空数据库，重新请求所有数据
    NSString * lastDate =  USERDEFAULTS_GET(SAVE_DB_MESSAGE_LAST_UPDATE_DATE);
    if (!lastDate) {
        [[LWFmdb share] deleteAllDataWithtableType:LWDBTableTypeMessge];
    }
    
    if(dataMutableArray.count == 0) {
        //            dispatch_async(dispatch_get_main_queue(), ^{
        
        #warning ++++++++++++++++暂时注释掉++++++++++++++
        if(nowDate) USERDEFAULTS_SET(nowDate, SAVE_DB_MESSAGE_LAST_UPDATE_DATE);
        [SYSTEM_USERDEFAULTS setBool:NO forKey:ISHAVENOTLOOKMESSAGE];
        [SYSTEM_USERDEFAULTS synchronize];
        //发送通知，改变图标
        POST_NOTI(GETMESSAGEINFORKNOEISORNOTNOLOOKMESSAGE, nil);
        return;
        //            });
    }else{
        
        BOOL res = [[LWFmdb share] insertDataToDBWithData:dataMutableArray tableType:LWDBTableTypeMessge];
        
        //            dispatch_async(dispatch_get_main_queue(), ^{
        
        if(res){
            //数据成功插入数据库后，再保存上次
            if(nowDate) USERDEFAULTS_SET(nowDate, SAVE_DB_MESSAGE_LAST_UPDATE_DATE);
        }else{
            LWLog(@"**************数据插入失败");
        }
        
        if(!isFromMsgPage){
            //保存有新的未读消息标识
            [SYSTEM_USERDEFAULTS setBool:YES forKey:ISHAVENOTLOOKMESSAGE];
            [SYSTEM_USERDEFAULTS synchronize];
            //发送通知，改变图标
            POST_NOTI(GETMESSAGEINFORKNOEISORNOTNOLOOKMESSAGE, nil);
            
        }else{
            [SYSTEM_USERDEFAULTS setBool:NO forKey:ISHAVENOTLOOKMESSAGE];
            [SYSTEM_USERDEFAULTS synchronize];
            //发送通知，改变图标
            POST_NOTI(GETMESSAGEINFORKNOEISORNOTNOLOOKMESSAGE, nil);
        }
        //            });
    }
    //    });
}

@end
