//
//  HYBaseUrlUtils.m
//  HaoYuClient
//
//  Created by 刘文强 on 2019/1/9.
//  Copyright © 2019年 LWQ. All rights reserved.
//

#import "HYBaseUrlUtils.h"

@implementation HYBaseUrlModel 

@end

@implementation HYBaseUrlUtils

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSString * jsonpath = [[NSBundle mainBundle] pathForResource:@"HYBaseURLConfigure" ofType:@"json"];
        NSData * jsondata =  [NSData dataWithContentsOfFile:jsonpath];
        NSError *error = nil;
        if (!jsondata) return nil;
        id json = [NSJSONSerialization JSONObjectWithData:jsondata options:NSJSONReadingAllowFragments error:&error];
        NSArray *urls = json[@"baseurls"];
        NSMutableArray *urlsM = [NSMutableArray array];
        for (NSDictionary *dic in urls) {
            [urlsM addObject:[HYBaseUrlModel modelWithJSON:dic]];
        }
        self.baseUrlsArray = urlsM;
    }
    return self;
}

- (HYBaseUrlModel *)currentUrlModel
{
    NSInteger index = [USERDEFAULTS_GET(SAVE_CURRENT_SERVICETYPE_KEY) integerValue];
    if (index >= self.baseUrlsArray.count) {
        index = 2;
    }
    HYBaseUrlModel *model = self.baseUrlsArray[index];
    return model;
}

#ifdef DEBUG
- (NSString *)currentServiceName
{
    return [self currentUrlModel].urlName;
}
- (NSString *)currentServiceURL
{
    return [self currentUrlModel].url;
}
#else
- (NSString *)currentServiceURL
{
    self.currentServiceName = @"正式服务器";
    return BASE_URL;
}
#endif

@end
