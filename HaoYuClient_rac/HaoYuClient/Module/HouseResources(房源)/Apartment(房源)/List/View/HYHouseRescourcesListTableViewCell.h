//
//  HYHouseRescourcesListTableViewCell.h
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/10.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYBaseTableViewCell.h"
#import "HYHouseRescourcesCellView.h"
#import "HYHouseRescourcesModel.h"
@interface HYHouseRescourcesListTableViewCell : HYBaseTableViewCell
@property (nonatomic, strong) id houseRescourcesModel;
@property (nonatomic, strong) HYHouseRescourcesCellView * cellView;
@end
