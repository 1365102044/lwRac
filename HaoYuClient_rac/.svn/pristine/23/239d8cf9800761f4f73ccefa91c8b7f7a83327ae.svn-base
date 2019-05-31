//
//  LWStartPingJiaView.m
//  HaoYuClient
//
//  Created by 刘文强 on 2019/5/20.
//  Copyright © 2019年 LWQ. All rights reserved.
//

#import "LWStartPingJiaView.h"

@interface LWStartPingJiaView ()
{
    CGFloat IMAGE_W;
    CGFloat IMAGE_H;
    BOOL _isAddStart;
    UIImageView *_startItem;
    UIImageView *_lastItem;
}
@property (nonatomic, strong) NSMutableArray * subItemMuArray;

@end
@implementation LWStartPingJiaView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _subItemMuArray = [[NSMutableArray alloc] init];
        IMAGE_H = IMAGE_W = 25;
        [self configureUI];
        _startItem = _subItemMuArray.firstObject;
        _lastItem = _subItemMuArray.lastObject;
    }
    return self;
}

- (void)configureUI
{
    UIView *bgview = [[UIView alloc] init];
    [self addSubview:bgview];
    for (int i = 0; i < 5; i++) {
        UIImageView *item = [[UIImageView alloc] init];
        item.image = IMAGENAME(@"empty_star");
        [_subItemMuArray addObject:item];
        [bgview addSubview:item];
        item.userInteractionEnabled = YES;
        [item mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_offset(CGSizeMake(IMAGE_W, IMAGE_H));
            make.left.mas_equalTo(bgview.mas_left).offset(10 + i * (IMAGE_W + 10));
            make.top.mas_equalTo(bgview.mas_top).mas_offset(5);
            make.bottom.mas_equalTo(bgview.mas_bottom).mas_offset(-5);
            if(i == 4) {
                make.right.mas_equalTo(bgview.mas_right).mas_offset(-10);
            }
        }];
    }
    [bgview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
//        make.centerX.mas_equalTo(self.mas_centerX);
//        make.centerY.mas_equalTo(self.mas_centerY);
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint point = [[touches anyObject] locationInView:self];
    if (point.x > _startItem.ex_x && point.x < CGRectGetMaxX(_lastItem.frame) &&
        point.y > CGRectGetMinY(_startItem.frame) && point.y < CGRectGetMaxY(_startItem.frame)) {
        _isAddStart = YES;
    }else{
        _isAddStart = NO;
    }
}
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (_isAddStart) {
        [self setItemStateWithPoint:[[touches anyObject] locationInView:self]];
    }
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (_isAddStart) {
        [self setItemStateWithPoint:[[touches anyObject] locationInView:self]];
    }
}
- (void)setItemStateWithPoint:(CGPoint )point
{
    self.score = 0;
    self.score = self.score + [self getScoreWithItem:_subItemMuArray[0] point:point];
    self.score = self.score + [self getScoreWithItem:_subItemMuArray[1] point:point];
    self.score = self.score + [self getScoreWithItem:_subItemMuArray[2] point:point];
    self.score = self.score + [self getScoreWithItem:_subItemMuArray[3] point:point];
    self.score = self.score + [self getScoreWithItem:_subItemMuArray[4] point:point];
 
    //评论最少半星
    if(self.score == 0){
//        self.score = 0.5;
        [_startItem setImage:[UIImage imageNamed:@"empty_star"]];
    }
    NSLog(@"分数 %f",self.score);
}

- (CGFloat)getScoreWithItem:(UIImageView *)item point:(CGPoint)point
{
    if (point.x > item.ex_x + item.width/2) {
        [item setImage:[UIImage imageNamed:@"full_star"]];
        return 2;
    }else if (point.x > item.ex_x){
        [item setImage:[UIImage imageNamed:@"full_star"]];
        return 2;
    }else{
        [item setImage:[UIImage imageNamed:@"empty_star"]];
        return 0;
    }
}

@end
