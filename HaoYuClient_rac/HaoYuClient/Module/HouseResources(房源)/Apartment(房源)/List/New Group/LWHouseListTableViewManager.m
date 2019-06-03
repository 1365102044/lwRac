//
//  LWHouseListTableViewManager.m
//  HaoYuClient
//
//  Created by 刘文强 on 2019/6/3.
//  Copyright © 2019年 LWQ. All rights reserved.
//

#import "LWHouseListTableViewManager.h"
#import <UIKit/UIKit.h>
#import "HYHouseRescourcesListTableViewCell.h"
#import "HYHomePageModel.h"
#import "HYHouseRescourceDeatilViewController.h"

#define  HOUSERESCOURCESLISTCELLIDNTIFIER @"HOUSERESCOURCESLISTCELLIDNTIFIER"

@interface  LWHouseListTableViewManager()
@property (nonatomic, strong) LWHouseListViewModel * houseViewModel;
@end
@implementation LWHouseListTableViewManager

+ (instancetype)createListTableViewManagerBindViewModel:(LWHouseListViewModel *)viewModel;
{
    LWHouseListTableViewManager *instance = [[LWHouseListTableViewManager alloc] init];
    instance.houseViewModel = viewModel;
    return instance;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HYHouseRescourcesListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:HOUSERESCOURCESLISTCELLIDNTIFIER];
    if(!cell){
        cell = [[HYHouseRescourcesListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:HOUSERESCOURCESLISTCELLIDNTIFIER];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.indexPath = indexPath;
    HYHouseRescourcesModel *dataModel = self.houseViewModel.dataMutableArray[indexPath.row];
    cell.houseRescourcesModel = dataModel;
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.houseViewModel.dataMutableArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id model = self.houseViewModel.dataMutableArray[indexPath.row];
    NSString * customId ;
    if ([model isKindOfClass:[HYHouseRescourcesModel class]]) {
        HYHouseRescourcesModel *tem_M = model;
        customId = tem_M.customId;
    }else if ([model isKindOfClass:[HYHomePageModel class]]){
        HYHomePageModel *tem_M = model;
        customId = tem_M.itemId;
    }
    if (self.pushVcSubject) {
        [self.pushVcSubject sendNext:customId];
    }
}

- (RACSubject *)pushVcSubject
{
    if (!_pushVcSubject) {
        _pushVcSubject = [[RACSubject alloc] init];
    }
    return _pushVcSubject;
}
@end
