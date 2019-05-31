//
//  HYChooseListTitleView.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/9/21.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYChooseListTitleView.h"
#import "HYDiscountModel.h"
#import "HYChooseListTitleTableViewCell.h"
@interface HYChooseListTitleView ()<UITableViewDelegate,UITableViewDataSource>

@end
@implementation HYChooseListTitleView

+ (instancetype)showChooseListViewTitle:(NSString *)title
                                dataArr:(NSArray *)dataArr
                          callBackBlock:(HYEventCallBackBlock)callBackBlock
{
    HYChooseListTitleView *temp      = [[HYChooseListTitleView alloc] init];
    temp.dataArr = dataArr;
    temp.callBackBlock = callBackBlock;
    [temp setUI];
    temp.titleL.text = title;
    return temp;
}

- (void)setUI
{
    [super setUI];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.bgView.frame = CGRectMake(0, 0, SCREEN_WIDTH*.7, SCREEN_HEIGHT*0.5);
    self.bgView.center = self.window.center;
    self.titleL = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(15)
                                           text:@""
                                      textColor:HYCOLOR.color_c4];
    [self.bgView addSubview:self.titleL];
    [self.titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgView.mas_top).mas_offset(MARGIN);
        make.centerX.mas_equalTo(self.bgView.mas_centerX);
    }];
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleL.mas_bottom).mas_offset(MARGIN);
        make.left.mas_equalTo(self.bgView).mas_offset(MARGIN);
        make.bottom.right.mas_equalTo(self.bgView).mas_offset(-MARGIN);
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HYChooseListTitleTableViewCell *cell = [[HYChooseListTitleTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"disc"];
    HYDiscountModel *model = self.dataArr[indexPath.row];
    cell.inforLable.left_L.text = model.couponDesc;
    cell.inforLable.right_L.text = model.iosDedicated;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HYDiscountModel *model = self.dataArr[indexPath.row];
    if (model.isSelect) {
        return;
    }
    [self dismiss];
}

@end
