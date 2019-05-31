//
//  HYHomeTableViewCellView.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/7/12.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYHomeTableViewCellView.h"

#define  HOMECOLLECTIDENTIFIER  @"HOMECOLLECTIDENTIFIER"
@interface HYHomeTableViewCellView ()

@end
@implementation HYHomeTableViewCellView

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
        [self.CollectView registerClass:[HYHomeCollectionViewCell class] forCellWithReuseIdentifier:HOMECOLLECTIDENTIFIER];
    }
    return self;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    HYHomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:HOMECOLLECTIDENTIFIER forIndexPath:indexPath];
    if ([self.dataModelArrary.firstObject isKindOfClass:[HYHomePageModel class]]) {
        HYHomePageModel *projectModel = self.dataModelArrary[indexPath.row];
        if (projectModel.tag == 100) {
            cell.houseItemImageView.image = IMAGENAME(projectModel.popuPic);
        }else{
            [cell.houseItemImageView sd_setImageWithURL:[NSURL URLWithString:HYIMAGEURLSTRING(HYProjectImageURLStringMid, projectModel.picModel.big)] placeholderImage:IMAGENAME(@"占位图-500_460")];
        }
        cell.houseNameLable.text =  projectModel.itemName;
        cell.housePriceLable.text = projectModel.roomTypeName;
    }else if ([self.dataModelArrary.firstObject isKindOfClass:[HYHomeHuXingModel class]]){
        HYHomeHuXingModel *huxingModel = self.dataModelArrary[indexPath.row];
        if (huxingModel.tag == 100) {
            cell.houseItemImageView.image = IMAGENAME(huxingModel.popuPic);
        }else{
            [cell.houseItemImageView sd_setImageWithURL:[NSURL URLWithString:HYIMAGEURLSTRING(HYProjectImageURLStringMid, huxingModel.picModel.big)] placeholderImage:IMAGENAME(@"占位图-600_460")];
        }
        cell.houseNameLable.text =  huxingModel.itemName;
        cell.housePriceLable.text = huxingModel.roomTypeName;
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
    return  CGSizeMake(ADJUST_PERCENT_FLOAT(250), ADJUST_PERCENT_FLOAT(220));
}

@end
