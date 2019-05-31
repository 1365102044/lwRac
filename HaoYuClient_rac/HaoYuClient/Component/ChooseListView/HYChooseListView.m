//
//  HYChooseListView.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/7.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYChooseListView.h"
#import "HYContractModel.h"
#import "HYWeiXiuQuYuModel.h"
#import "HYCityModel.h"
#import "HYDiscountModel.h"
#import "HYChooseListTitleTableViewCell.h"
@interface HYChooseListView ()<UITableViewDelegate,UITableViewDataSource>
@end

@implementation HYChooseListView

+ (instancetype)showChooseListView:(NSArray *)dataArr callBackBlock:(HYEventCallBackBlock)callBackBlock
{
    HYChooseListView *temp      = [[HYChooseListView alloc] init];
    temp.dataArr                = dataArr;
    temp.callBackBlock          = callBackBlock;
    [temp setUI];
    return temp;
}

- (void)setUI
{
    [self.bgView addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(self.bgView).mas_offset(MARGIN);
        make.bottom.right.mas_equalTo(self.bgView).mas_offset(-MARGIN);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
//    if ([self.dataArr[indexPath.row] isKindOfClass:[HYDiscountModel class]]){
//        HYChooseListTitleTableViewCell *cell = [[HYChooseListTitleTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"disc"];
//        HYDiscountModel *model = self.dataArr[indexPath.row];
//        cell.inforLable.left_L.text = model.couponDesc;
//        cell.inforLable.right_L.text = model.couponMoney;
//        return cell;
//    }
    
    if([self.dataArr[indexPath.row] isKindOfClass:[HYContractModel class]]){
        HYContractModel *model = self.dataArr[indexPath.row];
        cell.textLabel.text = [NSString stringWithFormat:@"%@   %@",model.houseItemName,model.houseNo];
    }else if([self.dataArr[indexPath.row] isKindOfClass:[HYWeiXiuQuYuModel class]]){
        HYWeiXiuQuYuModel *model = self.dataArr[indexPath.row];
        cell.textLabel.text = [NSString stringWithFormat:@"%@",model.key];
    }else if ([self.dataArr[indexPath.row] isKindOfClass:[HYProjectLevelListModel class]]){
        HYProjectLevelListModel *model = self.dataArr[indexPath.row];
        cell.textLabel.text = [NSString stringWithFormat:@"%@",model.houseItemName];
    }else if ([self.dataArr[indexPath.row] isKindOfClass:[HYHuXingLevelListModel class]]){
        HYHuXingLevelListModel *model = self.dataArr[indexPath.row];
        cell.textLabel.text = [NSString stringWithFormat:@"%@",model.roomTypeName];
    }else if ([self.dataArr[indexPath.row] isKindOfClass:[HYFangJianHaoLevelListModel class]]){
        HYFangJianHaoLevelListModel *model = self.dataArr[indexPath.row];
        cell.textLabel.text = [NSString stringWithFormat:@"%@",model.fangNo];
    }
    else if(indexPath.row < _dataArr.count) {
        cell.textLabel.text = self.dataArr[indexPath.row];
    }
    cell.textLabel.font = SYSTEM_REGULARFONT(14);
    cell.textLabel.textColor = HYCOLOR.color_c4;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if ([self.dataArr[indexPath.row] isKindOfClass:[HYDiscountModel class]]){
//        HYDiscountModel *model = self.dataArr[indexPath.row];
//        if (model.isSelect) {
//            return;
//        }
//    }
    [self dismiss];
    if (self.callBackBlock) {
        self.callBackBlock([NSString stringWithFormat:@"%ld",(long)indexPath.row]);
    }
}

- (HYBaseTableView*)tableView
{
    if (!_tableView) {
        _tableView = [[HYBaseTableView alloc] initWithFrame:self.bgView.bounds];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = ADJUST_PERCENT_FLOAT(50);
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.showsVerticalScrollIndicator = NO;
    }
    return _tableView;
}

- (void)updateContrans:(UIView *)referenceView
{
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgView).mas_offset(MARGIN/2);
        make.bottom.mas_equalTo(self.bgView).mas_offset(-MARGIN/2);
        make.left.right.mas_equalTo(self.bgView);
    }];
    self.maskView.alpha = 0.2;
    UIWindow * window=[[[UIApplication sharedApplication] delegate] window];
    CGRect ViewRect=[referenceView convertRect: referenceView.bounds toView:window];
    self.bgView.frame = CGRectMake(ViewRect.origin.x, ViewRect.origin.y+ViewRect.size.height, ViewRect.size.width, SCREEN_HEIGHT*0.4);
}

@end
