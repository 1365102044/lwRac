//
//  HYAddPhotoView.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/4.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYAddPhotoView.h"
#import "HYAddImageItemView.h"
@interface HYAddPhotoView()
{
    NSInteger MAXIMGS;
    NSInteger COLS;
}

@property (nonatomic, strong) HYBaseView * imageBgView;
@property (nonatomic, strong) UIImageView * defaultImageView;


/**
 UIImageView数组
 */
@property (nonatomic, strong) NSMutableArray * ImageViewDataArr;

@end

@implementation HYAddPhotoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        MAXIMGS = 3;
        COLS = 3;
        
        _titleLable = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(15)
                                               text:@"添加照片:"
                                          textColor:HYCOLOR.color_c4];
        
        UIImageView *defaultImageView = [[UIImageView alloc] init];
        defaultImageView.image = IMAGENAME(@"addphoto_default_n");
        defaultImageView.contentMode = UIViewContentModeScaleToFill;
        defaultImageView.tag = 100;
        defaultImageView.userInteractionEnabled = YES;
        [self.ImageViewDataArr addObject:defaultImageView];
        _defaultImageView = defaultImageView;
        [self addSubview:_titleLable];
        [self addSubview:self.imageBgView];
        
        [_titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.mas_equalTo(self);
        }];
        [_imageBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self);
            make.top.mas_equalTo(_titleLable.mas_bottom).mas_offset(MARGIN);
            make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-MARGIN);
        }];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addImage:)];
        [defaultImageView addGestureRecognizer:tap];
        
        [self updateImagesContrans];
        
        ADD_NOTI(clickDeleBtn:, @"clickDelebtn");
        ADD_NOTI(clickReuploadBtn:, @"clickreuploadbtn");
        ADD_NOTI(uploadresut:, @"uploadresult_baoxiu");
        
        ADD_NOTI(uploadresut_progress:, @"uploadresult_baoxiu_progress");
    }
    return self;
}

- (void)uploadresut_progress:(NSNotification *)noti
{
    CGFloat progress = [noti.object[@"progress"] floatValue];
    UIImage *img = noti.object[@"image"];
    
    if([self.ImagesDataArr containsObject:img]){
        for (HYAddImageItemView * item in _imageBgView.subviews) {
            if ([item isKindOfClass:[HYAddImageItemView class]] && [item.itemImageView.image isEqual:img]) {
                [item uploadWithProgress:progress];
            }
        }
    }
}

- (void)dealloc
{
    REMOVIE_NOTI(@"clickDelebtn");
    REMOVIE_NOTI(@"clickreuploadbtn");
    REMOVIE_NOTI(@"uploadresult_baoxiu");
}

//上传失败的通知
- (void)uploadresut:(NSNotification *)noti
{
    UIImage *img = noti.object[@"image"];
    BOOL res = ([noti.object[@"result"] isEqualToString:@"1"]) ? YES : NO;
    
    if([self.ImagesDataArr containsObject:img]){
        for (HYAddImageItemView * item in _imageBgView.subviews) {
            if ([item isKindOfClass:[HYAddImageItemView class]] && [item.itemImageView.image isEqual:img]) {
                res ? [item dismissMasklayer] : [item showMasklayer];
                if (!res) {
                    [item setMaskerTitle:@"上传失败"];
                }
            }
        }
    }
}

/**
 选择图片后，更新数据和布局
 */
- (void)chooseImages:(NSArray *)imgs
{
    NSInteger canCount = self.ImagesDataArr.count >= MAXIMGS ? 0 : MAXIMGS - self.ImagesDataArr.count;
    if (canCount > 0) {
        [self.ImagesDataArr addObjectsFromArray:[imgs subarrayWithRange:NSMakeRange(0, canCount >= imgs.count ? imgs.count : canCount)]];
    }
    for (int i = 0; i < imgs.count; i++ ) {
        if ([imgs[i] isKindOfClass:[UIImage class]]) {
            HYAddImageItemView *item = [[HYAddImageItemView alloc] init];
            item.tag = self.ImageViewDataArr.count  ;
            item.itemImageView.image = imgs[i];
            [self.ImageViewDataArr insertObject:item atIndex:self.ImageViewDataArr.count - 1];
            if (self.ImageViewDataArr.count - 1 == MAXIMGS) {
                break;
            }
            [item.masklayer addTarget:self action:@selector(clickMasklayer:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    [self updateImagesContrans];
}

//重新上传
- (void)clickReuploadBtn:(NSNotification *)noti
{
    HYAddImageItemView * sender =  noti.object;
    if ([self.delegate respondsToSelector:@selector(reUploadImage:)]) {
        [self.delegate reUploadImage:sender.itemImageView.image];
    }
}

/**
 删除后 更新图片数据
 */
- (void)clickDeleBtn:(NSNotification *)noti
{
    HYAddImageItemView * sender =  noti.object;
    if ([self.ImageViewDataArr containsObject:sender]) {
        [self.ImageViewDataArr removeObject:sender];
    }
    if ([self.ImagesDataArr containsObject:sender.itemImageView.image]) {
        [self.ImagesDataArr removeObject:sender.itemImageView.image];
    }
    if([self.delegate respondsToSelector:@selector(deleImage:)]){
        [self.delegate deleImage:sender.itemImageView.image];
    }
    [self updateImagesContrans];
}

/**
 重新上传
 */
- (void)clickMasklayer:(UIButton *)sender
{
    HYAddImageItemView *item = (HYAddImageItemView *)sender.superview;
    if([self.delegate respondsToSelector:@selector(reUploadImage:)]){
        [self.delegate reUploadImage:item.itemImageView.image];
    }
}

/**
 点击添加图片
 */
- (void)addImage:(UITapGestureRecognizer *)tap
{
    if ([self.delegate respondsToSelector:@selector(gotoChooseImages)]) {
        [self.delegate gotoChooseImages];
    }
}

/**
 更新布局
 */
- (void)updateImagesContrans
{
    _defaultImageView.hidden = NO;
    [_imageBgView removeAllSubviews];
    CGFloat IMAGE_W = (self.width - (COLS + 1)*MARGIN)/COLS;
    NSInteger max_count = self.ImageViewDataArr.count  >= MAXIMGS + 1 ? MAXIMGS + 1 : self.ImageViewDataArr.count;
    for (int i = 0 ; i < max_count; i++) {
        UIView *imageview= self.ImageViewDataArr[i];
        NSInteger cols = i%COLS;
        NSInteger rows = i/COLS;
        [_imageBgView addSubview:imageview];
        [imageview mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_imageBgView.mas_left).mas_offset((IMAGE_W + MARGIN)*cols + MARGIN);
            make.top.mas_equalTo(_imageBgView.mas_top).mas_offset((IMAGE_W + MARGIN)*rows + MARGIN);
            make.width.height.mas_offset(IMAGE_W);
            if ((i == self.ImageViewDataArr.count - 1) && (max_count != MAXIMGS + 1)) {
                make.bottom.mas_equalTo(_imageBgView.mas_bottom).mas_offset(-MARGIN);
            }else if((max_count == MAXIMGS + 1) && (i == MAXIMGS - 1))
            {
                make.bottom.mas_equalTo(_imageBgView.mas_bottom).mas_offset(-MARGIN);
            }
        }];
    }
    
    if (max_count == MAXIMGS + 1) {
        _defaultImageView.hidden = YES;
    }
}

- (HYBaseView*)imageBgView
{
    if (!_imageBgView) {
        _imageBgView = [[HYBaseView alloc] init];
    }
    return _imageBgView;
}

- (NSMutableArray*)ImageViewDataArr
{
    if (!_ImageViewDataArr) {
        _ImageViewDataArr = [[NSMutableArray alloc] init];
    }
    return _ImageViewDataArr;
}

- (NSMutableArray*)ImagesDataArr
{
    if (!_ImagesDataArr) {
        _ImagesDataArr = [[NSMutableArray alloc] init];
    }
    return _ImagesDataArr;
}
@end
