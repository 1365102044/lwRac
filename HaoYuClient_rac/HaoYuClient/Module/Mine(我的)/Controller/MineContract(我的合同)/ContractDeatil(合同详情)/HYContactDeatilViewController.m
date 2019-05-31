//
//  HYContactDeatilViewController.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/5/30.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYContactDeatilViewController.h"
#import "HYContractDeatilMainView.h"
#import "HYContractModel.h"
#import "HYContractPDFViewController.h"

@interface HYContactDeatilViewController ()
@property (nonatomic, strong) HYContractDeatilMainView * MainView;

@end

@implementation HYContactDeatilViewController


#pragma mark - First.通知

#pragma mark - Second.网络请求
- (void)requestContractDeatilInfor
{
    PARA_CREART;
    PARA_SET([_contractInforModel.chengzuId isNullToString], @"id");
    [[HYServiceManager share] postRequestAnWithurl:GET_MINEHETONGDEATILINFOR_URL
                                         paramters:para
                                      successBlock:^(id objc, id requestInfo) {
                                          LWLog(@"\n\n\n\n\n\nhetong_deatil:%@",objc);
                                          HYContractModel *contractModel = [HYContractModel modelWithJSON:objc[@"result"]];
                                          self.contractInforModel.chengZuZuKeList = contractModel.chengZuZuKeList;
                                          self.MainView.contractModel = self.contractInforModel;
                                      } failureBlock:^(id error, id requestInfo) {
                                          
                                      }];
}

- (void)requestHeTongPDF
{
    PARA_CREART;
    PARA_SET([_contractInforModel.chengzuId isNullToString], @"id");
    [[HYServiceManager share] postRequestAnWithurl:GET_MINEHETONGPDFINFOR_URL
                                         paramters:para
                                      successBlock:^(id objc, id requestInfo) {
                                          LWLog(@"\n\n\n\n\n\nhetong_PDF:%@",objc);
                                          NSString *pdf_url = objc[@"result"];
                                          if (pdf_url) {
                                              HYContractPDFViewController *pdf_vc = [[HYContractPDFViewController alloc] init];
                                              pdf_vc.pdf_url = pdf_url;
                                              [self.navigationController pushViewController:pdf_vc animated:YES];
                                          }else{
                                              ALERT(@"未查询到合同信息");
                                          }
                                      } failureBlock:^(id error, id requestInfo) {
                                          
                                      }];
}

#pragma mark - Third.点击事件
- (void)clickBtn:(UIButton *)sender
{
    if ([_contractInforModel.status integerValue] == 2) {
        [self requestHeTongPDF];
    }else{
        ALERT(@"未查询到有效的电子合同！");
        return;
    }
}

#pragma mark - Fourth.代理方法

#pragma mark - Fifth.视图生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"合同详情";
    self.view.backgroundColor = HYCOLOR.color_c0;
    [self setUI];
    [self requestContractDeatilInfor];
}

#pragma mark - Sixth.界面配置
- (void)setUI
{
    self.MainScrollView.backgroundColor = HYCOLOR.color_c1;
    [self.MainScrollView addSubview:self.MainView];
    [self.view addSubview:self.MainScrollView];
    
    [self.MainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.MainScrollView);
        make.width.mas_offset(SCREEN_WIDTH);
    }];
    [self.MainScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view.mas_bottom).mas_offset(([_contractInforModel.isElectron integerValue] == 1) ?  -ADJUST_PERCENT_FLOAT(45) : 0);
    }];
    
    // 2019年01月10日15:16:40  只有电子合同的才能查看电子合同
    if ([_contractInforModel.isElectron integerValue] == 1) {
        HYFillLongButton *btn_left = [HYFillLongButton buttonCorWithTitleStringKey:@"查看电子合同" target:self selector:@selector(clickBtn:)];
        [self.view addSubview:btn_left];
        [btn_left mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_offset(ADJUST_PERCENT_FLOAT(40));
            make.bottom.mas_equalTo(self.view.mas_bottom).mas_offset(-ADJUST_PERCENT_BOTTOM(5));
            make.left.mas_equalTo(self.view.mas_left).mas_offset(MARGIN);
            make.right.mas_equalTo(self.view.mas_right).mas_offset(-MARGIN);
        }];
    }
}

#pragma mark - Seventh.懒加载
- (HYContractDeatilMainView*)MainView
{
    if (!_MainView) {
        _MainView = [[HYContractDeatilMainView alloc] init];
        _MainView.backgroundColor = HYCOLOR.color_c1;
    }
    return _MainView;
}
#pragma mark - Eigth.Other


@end
