//
//  LWTouSuJianYiReply.m
//  HaoYuClient
//
//  Created by 刘文强 on 2019/5/10.
//  Copyright © 2019年 LWQ. All rights reserved.
//

#import "LWTouSuJianYiReplyView.h"
#import "HYPhotoBrowserViewController.h"
#import "LWPingJiaPopView.h"
#import "LWPopViewController.h"
@interface LWTouSuJianYiReplyView()<PBViewControllerDataSource,PBViewControllerDelegate>
{
    CGFloat pic_w ;
    CGFloat pic_h ;
    CGFloat pic_x ;
    CGFloat pic_margin;
}
@property (nonatomic, strong) HYBaseScrollView * picScrollView;
@property (nonatomic, strong) NSMutableArray * imageViews;
@property (nonatomic, strong) NSArray * imageUrlStringArray;
@property (nonatomic, strong) HYFillLongButton * pingJiaBtn;
@property (nonatomic, strong) NSArray * dataArray;

@end
@implementation LWTouSuJianYiReplyView

/** 评价 */
- (void)clickPingJiaBtn
{
    [LWPopViewController showPopViewWithSourceVC:self.currentViewController popView:[[LWPingJiaPopView alloc] init] extend:_paraForPingJia];
}

- (void)clickItemImage:(UITapGestureRecognizer *)tap
{
    UIImageView *itemView = (UIImageView *)tap.view;
    NSInteger index = [_imageViews indexOfObject:itemView];
    
    HYPhotoBrowserViewController *pbViewController = [[HYPhotoBrowserViewController alloc]init];
    pbViewController.pb_dataSource = self;
    pbViewController.pb_delegate = self;
    pbViewController.pb_startPage = index;
    [self.currentViewController presentViewController:pbViewController animated:YES completion:nil];
}


#pragma mark - PBViewControllerDataSource

- (NSInteger)numberOfPagesInViewController:(PBViewController *)viewController {
    return self.imageUrlStringArray.count;
}

- (void)viewController:(PBViewController *)viewController presentImageView:(UIImageView *)imageView forPageAtIndex:(NSInteger)index progressHandler:(void (^)(NSInteger, NSInteger))progressHandler {
    
    NSString *imageUrl = self.imageUrlStringArray[index];
    imageUrl = [NSString stringWithFormat:@"%@",imageUrl];
    imageUrl = HYIMAGEURLSTRING(HYProjectImageURLStringLarge, imageUrl);
    
    [imageView sd_setImageWithURL:[NSURL URLWithString: imageUrl]
                 placeholderImage:nil
                        completed:^(UIImage * _Nullable image,
                                    NSError * _Nullable error,
                                    SDImageCacheType cacheType,
                                    NSURL * _Nullable imageURL) {
                        }];
}

#pragma mark - PBViewControllerDelegate
- (void)viewController:(nonnull PBViewController *)viewController didSingleTapedPageAtIndex:(NSInteger)index presentedImage:(nullable UIImage *)presentedImage
{
    [self.currentViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)setDataArray:(NSArray *)dataArray replyContent:(NSString *)replycontent paramForPingJia:(NSDictionary *)paramForPingJia hiddenPingJiaBtn:(BOOL)hiddenPingJiaBtn
{
    self.paraForPingJia = paramForPingJia;
    self.dataArray = dataArray;
    self.pingJiaBtn.hidden = hiddenPingJiaBtn;
    
    self.picScrollView.contentSize = CGSizeMake(dataArray.count * pic_w + pic_x*2 + pic_margin*dataArray.count, 0);
    _picScrollView.showsHorizontalScrollIndicator = NO;
    _imageUrlStringArray = dataArray;
    self.picScrollView.hidden = dataArray.count == 0;
    if (dataArray.count == 0) {
        [_picScrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_offset(0);
        }];
        if(!hiddenPingJiaBtn){
            [_contentLable mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.mas_left).mas_offset(ADJUST_PERCENT_FLOAT(10));
                make.right.mas_equalTo(self.pingJiaBtn.mas_left).mas_offset(-5);
                make.top.mas_equalTo(self.mas_top).mas_offset(ADJUST_PERCENT_FLOAT(10));
                make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-ADJUST_PERCENT_FLOAT(5));
            }];
        }else{
        [_contentLable mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).mas_offset(ADJUST_PERCENT_FLOAT(10));
            make.right.mas_equalTo(self.mas_right).mas_offset(-ADJUST_PERCENT_FLOAT(10));
            make.top.mas_equalTo(self.mas_top).mas_offset(ADJUST_PERCENT_FLOAT(10));
            make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-ADJUST_PERCENT_FLOAT(5));
        }];
            }
    }else{
        [_contentLable mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).mas_offset(ADJUST_PERCENT_FLOAT(10));
            make.right.mas_equalTo(self.mas_right).mas_offset(-ADJUST_PERCENT_FLOAT(10));
            make.top.mas_equalTo(self.mas_top).mas_offset(ADJUST_PERCENT_FLOAT(10));
            //            make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-ADJUST_PERCENT_FLOAT(10));
        }];
        [self.picScrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.left.mas_equalTo(_contentLable);
            make.top.mas_equalTo(_contentLable.mas_bottom).mas_offset(ADJUST_PERCENT_FLOAT(10));
            make.height.mas_offset(ADJUST_PERCENT_FLOAT(60));
            make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-ADJUST_PERCENT_FLOAT(0));
        }];
    }
    
    
    [self.picScrollView removeAllSubviews];
    for (int i = 0; i < (dataArray.count <= 3 ? dataArray.count :3); i ++) {
        UIImageView *itemImageView = [[UIImageView alloc] init];
        [self.imageViews addObject:itemImageView];
        itemImageView.backgroundColor = [UIColor lightGrayColor];
        [itemImageView sd_setImageWithURL:[NSURL URLWithString:dataArray[i]]];
        [self.picScrollView addSubview:itemImageView];
        [itemImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_offset(CGSizeMake(pic_w, pic_h));
            make.left.mas_equalTo(self.picScrollView.mas_left).mas_offset(pic_x + pic_margin * (i - 1) + pic_w * i);
            make.top.mas_equalTo(self.picScrollView.mas_top).mas_offset(ADJUST_PERCENT_FLOAT(0));
            if (dataArray.count - 1 == i) {
                make.right.mas_equalTo(self.picScrollView.mas_right).mas_offset(-MARGIN);
            }
        }];
        itemImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickItemImage:)];
        [itemImageView addGestureRecognizer:tap];
    }
    [_contentLable setAttributedStringWithContentArray:@[@{@"color" :HYCOLOR.color_c4,
                                                                 @"content" : @"管家回复: ",
                                                                 @"size" : SYSTEM_BOLDFONT(13),
                                                                 @"lineSpacing": @5},
                                                         @{@"color" :HYCOLOR.color_c4,
                                                           @"content" : replycontent ? replycontent : @"",
                                                           @"size" : SYSTEM_REGULARFONT(13),
                                                           @"lineSpacing": @5}
                                                         ]
     ];
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        pic_w = ADJUST_PERCENT_FLOAT(60);
        pic_h = pic_w;
        pic_x = ADJUST_PERCENT_FLOAT(10);
        pic_margin = ADJUST_PERCENT_FLOAT(10);
        
        
        _contentLable = [HYAttributedStringLabel labelWithFont:SYSTEM_REGULARFONT(13)
                                                       text:@""
                                                  textColor:HYCOLOR.color_c4];
        UIView* lineView = [[UIView alloc] init];
        lineView.backgroundColor = HYCOLOR.color_c6;
        [self addSubviews:@[lineView,self.picScrollView,self.contentLable]];
        
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top).mas_offset(1);
            make.height.mas_offset(0.5);
            make.left.right.mas_equalTo(self);
        }];
        
        [_contentLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).mas_offset(ADJUST_PERCENT_FLOAT(10));
            make.right.mas_equalTo(self.mas_right).mas_offset(-ADJUST_PERCENT_FLOAT(10));
            make.top.mas_equalTo(self.mas_top).mas_offset(ADJUST_PERCENT_FLOAT(10));
//            make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-ADJUST_PERCENT_FLOAT(10));
        }];
        [self.picScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.left.mas_equalTo(_contentLable);
            make.top.mas_equalTo(_contentLable.mas_bottom).mas_offset(ADJUST_PERCENT_FLOAT(10));
            make.height.mas_offset(ADJUST_PERCENT_FLOAT(60));
            make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-ADJUST_PERCENT_FLOAT(0));
        }];
        
        [self addSubview:self.pingJiaBtn];
        [self.pingJiaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_offset(CGSizeMake(80, 30));
            make.right.mas_equalTo(self.mas_right).mas_offset(-MARGIN);
            make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-0);
        }];
        
        self.pingJiaBtn.hidden = YES;
    }
    return self;
}
- (HYFillLongButton*)pingJiaBtn
{
    if (!_pingJiaBtn) {
        _pingJiaBtn = [HYFillLongButton buttonCorWithTitleStringKey:@"评价" target:self selector:@selector(clickPingJiaBtn)];
    }
    return _pingJiaBtn;
}
- (HYBaseScrollView*)picScrollView
{
    if (!_picScrollView) {
        _picScrollView = [[HYBaseScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-MARGIN*4, 60)];
        _picScrollView.showsHorizontalScrollIndicator = NO;
    }
    return _picScrollView;
}
- (NSMutableArray*)imageViews
{
    if (!_imageViews) {
        _imageViews = [[NSMutableArray alloc] init];
    }
    return _imageViews;
}
@end
