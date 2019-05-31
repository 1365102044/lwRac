//
//  HYAboutUsViewController.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/5/25.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYAboutUsViewController.h"
#import "HYAboutUsView.h"

@interface HYAboutUsViewController ()

@end

@implementation HYAboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于我们";
    self.view.backgroundColor = HYCOLOR.color_c0;
    HYAboutUsView * infor =  [[HYAboutUsView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:infor];
    [infor mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.view);
    }];
    
}



@end
