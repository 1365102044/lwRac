//
//  LWHomeHotTableViewCellView.m
//  HaoYuClient
//
//  Created by 刘文强 on 2019/5/10.
//  Copyright © 2019年 LWQ. All rights reserved.
//

#import "LWHomeHotTableViewCellView.h"

#define HOMEHOTCOLLECTIDENTRIFIER @"HOMEHOTCOLLECTIDENTRIFIER"
@implementation LWHomeHotTableViewCellView

- (void)setDataModelArrary:(NSArray *)dataModelArrary
{
    super.dataModelArrary = dataModelArrary;
    HYBaseHomeModel *homeModel = dataModelArrary.firstObject;
    NSDictionary *dict = self.dataData[homeModel.section];
    self.titleLable.text = dict[@"title"];
    self.descLable.text = dict[@"desc"];

    [self.CollectView reloadData];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
         [self.CollectView registerClass:[HYHomeCollectionViewCell class] forCellWithReuseIdentifier:HOMEHOTCOLLECTIDENTRIFIER];
        [self.CollectView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.descLable.mas_bottom).mas_offset(MARGIN/2);
            make.left.mas_equalTo(self.mas_left).mas_offset(MARGIN);
            make.right.mas_equalTo(self.mas_right).mas_offset(-MARGIN);
            make.height.mas_offset(ADJUST_PERCENT_FLOAT(180));
        }];
    }
    return self;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HYHomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:HOMEHOTCOLLECTIDENTRIFIER forIndexPath:indexPath];
    
    if([self.dataModelArrary.firstObject isKindOfClass:[HYHomePageHotModel class]]){
        HYHomePageHotModel *hotmodel = self.dataModelArrary[indexPath.row];
        [cell.houseItemImageView sd_setImageWithURL:[NSURL URLWithString:HYIMAGEURLSTRING(HYProjectImageURLStringMid, hotmodel.pics)] placeholderImage:IMAGENAME(@"占位图-600_460")];
        cell.houseNameLable.text =  @"";
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    HYBaseHomeModel *homebase_model = self.dataModelArrary[indexPath.row];
    if (homebase_model.tag != 100) {
        if (self.clickCollectCellBlock) {
            self.clickCollectCellBlock(20000,indexPath,self.dataModelArrary);
        }
    }
    if ([self.delegate respondsToSelector:@selector(cellEventsWithcellTag:indexPath:dataModelArray:Title:)]) {
        [self.delegate cellEventsWithcellTag:20000 indexPath:indexPath dataModelArray:self.dataModelArrary Title:self.titleLable.text];
    }
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return (self.dataModelArrary.count > 5) ? 5 : self.dataModelArrary.count;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(ADJUST_PERCENT_FLOAT(250), ADJUST_PERCENT_FLOAT(170));
}

@end
