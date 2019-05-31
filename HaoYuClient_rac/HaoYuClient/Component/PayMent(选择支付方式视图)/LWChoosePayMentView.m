//
//  LWChoosePayMentView.m
//  HaoYuClient
//
//  Created by 刘文强 on 2019/1/25.
//  Copyright © 2019年 LWQ. All rights reserved.
//

#import "LWChoosePayMentView.h"
#import "LWChoosePayMentTableViewCell.h"
@interface LWChoosePayMentView  ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) HYBaseView * contentView;
@property (nonatomic, strong) HYBaseView * bottomView;
@property (nonatomic, strong) HYBaseView * bgView;

@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, strong) HYDefaultLabel * content_header_title;
@property (nonatomic, strong) HYDefaultLabel * content_header_price;
@property (nonatomic, strong) UIImageView * content_header_logo;

@property (nonatomic, strong) HYBaseTableView *payTableView;

@property (nonatomic, strong) NSArray * paySourceArray;

@property (nonatomic, strong) NSIndexPath * lastSelectIndexPath;

@property (nonatomic, copy) HYEventCallBackBlock callBlackBlock;

/**
 选择的支付方式 1.微信； 2.支付吧
 */
@property (nonatomic, assign) NSInteger payTag;

@end

@implementation LWChoosePayMentView

/**
 显示支付视图
 
 @param title 标题
 @param desc 描述（内部拼接：价格L：desc）
 @param callBlackBlock 点击底部按钮的回调（1：取消支付，2：确认支付）
 */
+ (instancetype)showChoosePayMethodViewWithTitle:(NSString *)title desc:(NSString *)desc imageName:(NSString *)imageName callBlackBlock:(HYEventCallBackBlock)callBlackBlock
{
    LWChoosePayMentView *instance = [LWChoosePayMentView new];
    [instance showChoosePayTypeViewWithTitle:title desc:desc imageName:imageName  callBlackBlock:callBlackBlock];
    return instance;
}

/**
 显示支付视图
 
 @param title 标题
 @param desc 描述（内部拼接：价格L：desc）
 @param callBlackBlock 点击底部按钮的回调（1：取消支付，2：确认支付）
 */
- (void)showChoosePayTypeViewWithTitle:(NSString *)title desc:(NSString *)desc imageName:(NSString *)imageName callBlackBlock:(HYEventCallBackBlock)callBlackBlock;
{
    [self confiMainUI];
    self.content_header_title.text = title;
    self.content_header_price.text = [NSString stringWithFormat:@"%@",desc];
    self.content_header_logo.image = IMAGENAME(imageName);
    self.callBlackBlock =  callBlackBlock;
}

- (void)dismiss
{
    self.payTag = 0;
    if (self.selectPayMethodBlock) {
        self.selectPayMethodBlock(@(self.payTag));
    }
    
    [_contentView.superview layoutIfNeeded];
    [UIView animateWithDuration:0.25 animations:^{
        [_contentView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(_window.mas_bottom).mas_offset(SCREEN_HEIGHT*0.6);
        }];
        [_contentView.superview layoutIfNeeded];
    } completion:^(BOOL finished) {
        self.bgView.alpha = 0;
        [self.bgView removeFromSuperview];
        [self.contentView removeFromSuperview];
    }];
   
}

- (void)confiMainUI
{
    _window = UIApplication.sharedApplication.keyWindow;
    
    [_window addSubview:self.bgView];
    [_window addSubview:self.contentView];
    self.bgView.alpha = 0.4;
    
//    //如果其约束还没有生成的时候需要动画的话，就请先强制刷新后才写动画，否则所有没生成的约束会直接跑动画
    [_contentView.superview layoutIfNeeded];
    
    [UIView animateWithDuration:0.25 animations:^{
        [_contentView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(_window.mas_bottom).mas_offset(0);
        }];
        [_contentView.superview layoutIfNeeded];
    } completion:^(BOOL finished) {

    }];

//    // 默认选中第一行
//    [self.payTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:(UITableViewScrollPositionNone)];
}

/**
 点击底部按钮 1.取消； 2.确认支付

 @param sender btn
 */
- (void)clickBottomBtn:(UIButton *)sender
{
    if (self.callBlackBlock) {
        self.callBlackBlock(@(sender.tag));
    }
    if (sender.tag == 1) {
        [self dismiss];
    }
}

- (HYBaseView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[HYBaseView alloc] init];
        
        HYDefaultButton *left_btn = [HYDefaultButton buttonWithTitleStringKey:@"取消支付" titleColor:HYCOLOR.color_c2 titleFont:SYSTEM_REGULARFONT(15) target:self selector:@selector(clickBottomBtn:)];
        left_btn.backgroundColor = HYCOLOR.color_c0;
        left_btn.tag = 1;
        HYDefaultButton *right_btn = [HYDefaultButton buttonWithTitleStringKey:@"确认支付" titleColor:HYCOLOR.color_c0 titleFont:SYSTEM_REGULARFONT(15) target:self selector:@selector(clickBottomBtn:)];
        right_btn.backgroundColor = HYCOLOR.color_c5;
        right_btn.tag = 2;
        [_bottomView addSubviews:@[left_btn,right_btn]];
        [left_btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_offset(ADJUST_PERCENT_FLOAT(50));
            make.left.bottom.mas_equalTo(_bottomView);
            make.width.mas_equalTo(right_btn.mas_width);
            make.width.offset(ADJUST_PERCENT_FLOAT(SCREEN_WIDTH/2));
            make.top.bottom.mas_equalTo(_bottomView);
        }];
        [right_btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.mas_equalTo(_bottomView);
            make.width.height.mas_equalTo(left_btn);
        }];
    }
    return _bottomView;
}

- (void)confiContentUI
{
    HYBaseView *headerView = [[HYBaseView alloc] init];
    UIImageView *icon = [[UIImageView alloc] init];
    
    [icon setBoundWidth:0 cornerRadius:6];
    self.content_header_logo = icon;
    _content_header_title = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(15) text:@"房租缴费" textColor:HYCOLOR.color_c4];
    _content_header_price = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(13) text:@"" textColor:HYCOLOR.color_c4];
    [headerView addSubviews:@[icon,_content_header_title,_content_header_price]];
    
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(ADJUST_PERCENT_FLOAT(60), ADJUST_PERCENT_FLOAT(60)));
        make.left.equalTo(headerView).mas_offset(ADJUST_PERCENT_FLOAT(20));
        make.centerY.mas_equalTo(headerView.centerY);
    }];
    [_content_header_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(icon.mas_right).offset(ADJUST_PERCENT_FLOAT(10));
        make.right.mas_equalTo(headerView.mas_right).offset(-ADJUST_PERCENT_FLOAT(10));
        make.centerY.mas_equalTo(headerView.centerY).mas_offset(-ADJUST_PERCENT_FLOAT(10));
    }];
    [_content_header_price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(_content_header_title);
        make.centerY.mas_equalTo(headerView.centerY).mas_offset(ADJUST_PERCENT_FLOAT(10));
    }];
    _content_header_price.numberOfLines = 2;
    self.payTableView = [[HYBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.payTableView.delegate = self;
    self.payTableView.dataSource = self;
    self.payTableView.rowHeight = ADJUST_PERCENT_FLOAT(60);
    self.payTableView.backgroundColor = HYCOLOR.color_c1;
    [self.contentView addSubview:self.payTableView];
    self.payTableView.tableHeaderView = headerView;
    headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, ADJUST_PERCENT_FLOAT(100));
    
    [_contentView addSubview:self.bottomView];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(_contentView);
    }];
    
    [self.payTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(_contentView);
        make.bottom.mas_equalTo(_contentView);
    }];
    

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LWChoosePayMentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell){
        cell = [[LWChoosePayMentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        NSDictionary *dic = self.paySourceArray[indexPath.row];
        [cell setTitle:dic[@"title"] imageName:dic[@"imageName"]];
        cell.payTag = indexPath.row + 1;
    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    HYBaseView *sectionView = [[HYBaseView alloc] init];
    if (section == 0) {
        sectionView.backgroundColor = HYCOLOR.color_c1;
    }else if (section == 1){
        UIView *lefticon = [[UIView alloc] init];
        lefticon.backgroundColor = HYCOLOR.color_c3;
        
        HYDefaultLabel *desc = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(13) text:@"选择支付方式" textColor:HYCOLOR.color_c4];
        [sectionView addSubviews:@[lefticon,desc]];
        
        [lefticon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_offset(CGSizeMake(ADJUST_PERCENT_FLOAT(4), ADJUST_PERCENT_FLOAT(20)));
            make.left.mas_equalTo(sectionView.mas_left).mas_offset(ADJUST_PERCENT_FLOAT(20));
            make.centerY.mas_equalTo(sectionView.mas_centerY);
        }];
        [desc mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(lefticon.mas_right).mas_offset(ADJUST_PERCENT_FLOAT(10));
            make.centerY.mas_equalTo(sectionView.mas_centerY);
        }];
    }
    return sectionView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return section == 1 ? ADJUST_PERCENT_FLOAT(40) : 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return section == 1 ? self.paySourceArray.count : 0;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_lastSelectIndexPath) {
        LWChoosePayMentTableViewCell *cell = [tableView cellForRowAtIndexPath:_lastSelectIndexPath];
        [cell isSelectCell:NO];
    }
    LWChoosePayMentTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell isSelectCell:YES];
    self.lastSelectIndexPath = indexPath;
    self.payTag = cell.payTag;
    if (self.selectPayMethodBlock) {
        self.selectPayMethodBlock(@(self.payTag));
    }
}

- (HYBaseView *)contentView
{
    if (!_contentView) {
        _contentView = [[HYBaseView alloc] init];
        _contentView.backgroundColor = HYCOLOR.color_c2;
        [_window addSubview:_contentView];
        
        [self confiContentUI];
        
        [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(_window);
            make.height.mas_offset(SCREEN_HEIGHT*0.6);
            make.bottom.equalTo(_window.mas_bottom).mas_offset(SCREEN_HEIGHT*0.6);
        }];
        
        
    }
    return _contentView;
}

- (NSArray*)paySourceArray
{
    if (!_paySourceArray) {
        _paySourceArray = @[@{@"title":@"微信",@"imageName":@"pay_weixin_b_icon"},
                            @{@"title":@"支付宝",@"imageName":@"pay_zhifubao_b_icon"}];
        
    }
    return _paySourceArray;
}

- (HYBaseView*)bgView
{
    if (!_bgView) {
        _bgView = [[HYBaseView alloc] init];
        
        _bgView.backgroundColor = [UIColor blackColor];
        [_window addSubview:_bgView];
        
        [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(_window);
        }];
        _bgView.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
            [self dismiss];
        }];
        [_bgView addGestureRecognizer:tap];
        
    }
    return _bgView;
}
@end

