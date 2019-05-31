//
//  LWRegisterXieYiViewController.m
//  AizhizuPartner
//
//  Created by 刘文强 on 2019/1/28.
//  Copyright © 2019年 herenke. All rights reserved.
//

#import "LWRegisterXieYiViewController.h"

@interface LWRegisterXieYiViewController ()

@end

@implementation LWRegisterXieYiViewController


#pragma mark - First.通知

#pragma mark - Second.网络请求

#pragma mark - Third.点击事件

#pragma mark - Fourth.代理方法

#pragma mark - Fifth.视图生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *url =  @"http://pms.hntpsjwy.com/wechatApps/weixin/homeCenter/privacy.html";
    
    UIWebView *webview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NAVIGATOR_HEIGHT)];
    [self.view addSubview:webview];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [webview loadRequest:request];
}

- (void)clickBackBtn:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)needNavigationBar
{
    return YES;
}
#pragma mark - Sixth.界面配置

#pragma mark - Seventh.懒加载

#pragma mark - Eigth.Other

@end
