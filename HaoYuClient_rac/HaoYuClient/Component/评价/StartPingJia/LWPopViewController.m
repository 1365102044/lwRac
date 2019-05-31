//
//  LWBasePopView.m
//  HaoYuClient
//
//  Created by 刘文强 on 2019/5/21.
//  Copyright © 2019年 LWQ. All rights reserved.
//

#import "LWPopViewController.h"

@interface LWPopViewController ()

@property (nonatomic, strong) LWPingJiaPopView * popView;

@property (nonatomic, strong) NSDictionary * paramPingJia;

@end
@implementation LWPopViewController
- (void)dismiss;
{
    [self.popView removeFromSuperview];
    [self dismissViewControllerAnimated:YES completion:nil];
}

+ (instancetype)showPopViewWithSourceVC:(UIViewController *)sourceVC popView:(LWPingJiaPopView *)popView extend:(id)extend
{
   LWPopViewController *instance = [LWPopViewController new];
    instance.popView = popView;
    instance.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    instance.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    sourceVC.modalPresentationStyle = UIModalPresentationCurrentContext;
    [sourceVC presentViewController:instance animated:YES completion:nil];
    instance.paramPingJia = extend;
    return instance;
}

#pragma mark - First.通知

#pragma mark - Second.网络请求
- (void)sumitData:(NSDictionary *)param
{
    NSLog(@"+++++++++++提交评价的参数：%@",param);
    
    NSString *url = BAOJIE_ZUEKE_PINGJIA_URL;
    if ([[_paramPingJia valueForKey:@"type"] isEqualToString:@"2"]) {
        url = WEIXIU_ZUEKE_PINGJIA_URL;
    }else if ([[_paramPingJia valueForKey:@"type"] isEqualToString:@"3"]) {
        url = TOUSU_ZUEKE_PINGJIA_URL;
    }
    [[HYServiceManager share] postRequestAnWithurl:url paramters:param successBlock:^(id objc, id requestInfo) {
        ALERT(@"评价成功！");
        [self dismiss];
        POST_NOTI(@"REFRESHLISTWHENAFTERPINGJIA_NOTI", nil);
    }];
}
#pragma mark - Third.点击事件
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismiss];
}
#pragma mark - Fourth.代理方法

#pragma mark - Fifth.视图生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.popView];
    [_popView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.view.mas_centerY);
        make.left.mas_equalTo(self.view).mas_offset(20);
        make.right.mas_equalTo(self.view).mas_offset(-20);
    }];
    [_popView setBoundWidth:0 cornerRadius:6];
    
    WEAKSELF(self);
    self.popView.eventsBlock = ^(NSDictionary * _Nonnull para, NSInteger tag) {
        if (tag == 1) {
            [weakself dismiss];
        }else{
            [weakself handleParam:para];
        }
    };
}

/** 处理参数 */
- (void)handleParam:(NSDictionary *)param
{
    NSArray *pics = param[@"picLists"];
//    if (!pics || pics.count == 0) {
//        return;
//    }
    NSMutableArray *picList = [[NSMutableArray alloc] init];
    for (NSString *picurl in pics) {
        if (picurl.length > 3) {
            NSMutableDictionary *picDict = [[NSMutableDictionary alloc] init];
            picDict[@"big"] = picurl;
            picDict[@"tblId"] = _paramPingJia[@"id"];
            picDict[@"subType"] = @"2";
            if([_paramPingJia[@"type"] isEqualToString:@"3"]){
                picDict[@"type"] = @"135";
            }else{
                picDict[@"type"] = ([_paramPingJia[@"type"] integerValue] == 1) ?@"133":@"132";
            }
            NSString *pictype = [picurl substringWithRange:NSMakeRange(picurl.length-3, 3)];
            picDict[@"fileType"] = pictype?:@"png";
            picDict[@"name"] = @"pic.png";
            [picList addObject:picDict];
        }
    }
    PARA_CREART;
    [para addEntriesFromDictionary:param];
    PARA_SET(picList, @"picList");
    if(_paramPingJia[@"id"]) PARA_SET(_paramPingJia[@"id"], @"id");
    [self sumitData:para];
}
#pragma mark - Sixth.界面配置

#pragma mark - Seventh.懒加载

#pragma mark - Eigth.Other


@end
