//
//  LWHomeBaseTableViewCellView.m
//  HaoYuClient
//
//  Created by 刘文强 on 2019/5/10.
//  Copyright © 2019年 LWQ. All rights reserved.
//

#import "LWHomeBaseTableViewCellView.h"

@implementation LWHomeBaseTableViewCellView

- (void)setDataModelArrary:(NSArray *)dataModelArrary
{
    _dataModelArrary = dataModelArrary;
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
        self.dataData = @[@{@"title":@"好寓精选",@"desc":@"只生活，不漂泊，你值得一寓"},
                          @{@"title":@"热门户型",@"desc":@"房子可以租，生活不将就"},
                          @{@"title":@"好寓Soule",@"desc":@""},
                          @{@"title":@"热门分享",@"desc":@""},];
    }
    return self;
}

- (void)setTopInfor:(NSInteger)index
{
    NSDictionary *dict = self.dataData[index];
    _titleLable.text = dict[@"title"];
    _descLable.text = dict[@"desc"];
}

- (void)setUI
{
    _titleLable = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(16)
                                           text:@""
                                      textColor:HYCOLOR.color_c4];
    _descLable = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(12)
                                          text:@""
                                     textColor:HYCOLOR.color_c2];
    HYDefaultLabel *moreLable = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(14)
                                                         text:@"查看更多"
                                                    textColor:HYCOLOR.color_c2];
    UIImageView *arrowImageView = [[UIImageView alloc] init];
    arrowImageView.image = IMAGENAME(@"arrow_right_nor");
    
    [self addSubview:_titleLable];
    [self addSubview:_descLable];
    [self addSubview:moreLable];
    [self addSubview:arrowImageView];
    [self addSubview:self.CollectView];
    [_titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(MARGIN);
        make.top.mas_equalTo(self).mas_offset(MARGIN);
    }];
    [_descLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_titleLable.mas_left);
        make.top.mas_equalTo(_titleLable.mas_bottom).mas_offset(MARGIN/3);
    }];
    [arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(8,MARGIN*1.3));
        make.centerY.mas_equalTo(_titleLable.mas_centerY).mas_offset(2);
        make.right.mas_equalTo(self.mas_right).mas_offset(-MARGIN*2);
    }];
    [moreLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(arrowImageView.mas_left).mas_offset(-MARGIN/2);
        make.centerY.mas_equalTo(arrowImageView.mas_centerY);
    }];
    [self.CollectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_descLable.mas_bottom);
        make.left.mas_equalTo(self.mas_left).mas_offset(MARGIN);
        make.right.mas_equalTo(self.mas_right).mas_offset(-MARGIN);
        make.height.mas_offset(ADJUST_PERCENT_FLOAT(220));
    }];
    moreLable.userInteractionEnabled = YES;
    WEAKSELF(self);
    [moreLable bk_whenTapped:^{
        NSIndexPath *indexpath = [NSIndexPath indexPathForRow:0 inSection:0];
        NSMutableArray *tem_data_modle = [[NSMutableArray alloc] initWithArray:_dataModelArrary];
        if (_dataModelArrary.count == 2) {
            HYBaseHomeModel *homeBaseModel = tem_data_modle.lastObject;
            if (homeBaseModel.tag == 100) {
                [tem_data_modle removeObject:homeBaseModel];
            }
        }
        if (weakself.clickCollectCellBlock) {
            weakself.clickCollectCellBlock(10000,indexpath,tem_data_modle);
        }
        
        if ([weakself.delegate respondsToSelector:@selector(cellEventsWithcellTag:indexPath:dataModelArray:Title:)]) {
            [weakself.delegate cellEventsWithcellTag:10000 indexPath:indexpath dataModelArray:tem_data_modle Title:_titleLable.text];
        }
    }];
}

//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    HYHomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:HOMECOLLECTIDENTIFIER forIndexPath:indexPath];
//
//    if ([self.dataModelArrary.firstObject isKindOfClass:[HYHomePageModel class]]) {
//        HYHomePageModel *projectModel = self.dataModelArrary[indexPath.row];
//        if (projectModel.tag == 100) {
//            cell.houseItemImageView.image = IMAGENAME(projectModel.popuPic);
//        }else{
//            [cell.houseItemImageView sd_setImageWithURL:[NSURL URLWithString:HYIMAGEURLSTRING(HYProjectImageURLStringMid, projectModel.picModel.big)] placeholderImage:IMAGENAME(@"占位图-500_460")];
//        }
//        cell.houseNameLable.text =  projectModel.itemName;
//        cell.housePriceLable.text = projectModel.roomTypeName;
//    }else if ([self.dataModelArrary.firstObject isKindOfClass:[HYHomeHuXingModel class]]){
//        HYHomeHuXingModel *huxingModel = self.dataModelArrary[indexPath.row];
//        if (huxingModel.tag == 100) {
//            cell.houseItemImageView.image = IMAGENAME(huxingModel.popuPic);
//        }else{
//            [cell.houseItemImageView sd_setImageWithURL:[NSURL URLWithString:HYIMAGEURLSTRING(HYProjectImageURLStringMid, huxingModel.picModel.big)] placeholderImage:IMAGENAME(@"占位图-600_460")];
//        }
//        cell.houseNameLable.text =  huxingModel.itemName;
//        cell.housePriceLable.text = huxingModel.roomTypeName;
//    }else if([self.dataModelArrary.firstObject isKindOfClass:[HYHomePageHotModel class]]){
//        HYHomePageHotModel *hotmodel = self.dataModelArrary[indexPath.row];
//        [cell.houseItemImageView sd_setImageWithURL:[NSURL URLWithString:HYIMAGEURLSTRING(HYProjectImageURLStringMid, hotmodel.pics)] placeholderImage:IMAGENAME(@"占位图-600_460")];
//        cell.houseNameLable.text =  @"";
//    }
//    return cell;
//}
//
//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    HYBaseHomeModel *homebase_model = _dataModelArrary[indexPath.row];
//    if (homebase_model.tag != 100) {
//        if (self.clickCollectCellBlock) {
//            self.clickCollectCellBlock(20000,indexPath,_dataModelArrary);
//        }
//    }
//}
//-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
//{
//    return (self.dataModelArrary.count > 5) ? 5 : self.dataModelArrary.count;
//}
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    HYBaseHomeModel *homeModel = _dataModelArrary.firstObject;
//    NSLog(@"-----------itemsize：%@",homeModel.section > 1? @"170" : @"210");
//    return homeModel.section > 1 ? CGSizeMake(ADJUST_PERCENT_FLOAT(250), ADJUST_PERCENT_FLOAT(170)):  CGSizeMake(ADJUST_PERCENT_FLOAT(250), ADJUST_PERCENT_FLOAT(210));
//}

- (HYBaseCollectionView*)CollectView
{
    if (!_CollectView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 5;
        layout.minimumInteritemSpacing = 5;
        _CollectView = [[HYBaseCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _CollectView.delegate = self;
        _CollectView.dataSource = self;
        _CollectView.showsHorizontalScrollIndicator = NO;
    }
    return _CollectView;
}

@end
