//
//  LWHomeBaseTableViewCellView.h
//  HaoYuClient
//
//  Created by 刘文强 on 2019/5/10.
//  Copyright © 2019年 LWQ. All rights reserved.
//

#import "HYBaseView.h"
#import "HYHomePageModel.h"
#import "HYBaseModel.h"
#import "HYBaseCollectionView.h"
#import "HYHomeCollectionViewCell.h"

@protocol LWHomePageCellEventsDelegate <NSObject>

@optional
- (void)cellEventsWithcellTag:(NSInteger)tag indexPath:(NSIndexPath *)indexPath dataModelArray:(NSArray *)dataModelArray Title:(NSString *)title;
@end

typedef void(^clickCellBlock)(NSInteger tag, NSIndexPath* indexPath, NSArray* dataModelArrary);
NS_ASSUME_NONNULL_BEGIN

@interface LWHomeBaseTableViewCellView : HYBaseView<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) HYBaseCollectionView * CollectView;
@property (nonatomic, strong) NSArray * dataData;
@property (nonatomic, strong) HYDefaultLabel * titleLable;
@property (nonatomic, strong) HYDefaultLabel * descLable;

@property (nonatomic, copy) clickCellBlock  clickCollectCellBlock;
@property (nonatomic, strong) NSArray * dataModelArrary;

@property (nonatomic, weak) id<LWHomePageCellEventsDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
