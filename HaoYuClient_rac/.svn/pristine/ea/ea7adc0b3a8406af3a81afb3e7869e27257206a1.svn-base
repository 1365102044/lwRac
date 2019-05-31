//
//  LWPingJiaPopView.m
//  HaoYuClient
//
//  Created by 刘文强 on 2019/5/20.
//  Copyright © 2019年 LWQ. All rights reserved.
//

#import "LWPingJiaPopView.h"
#import "HYBaseTextView.h"
#import "LWStartPingJiaView.h"
#import "HYAddPhotoView.h"
#import "LWAddPhotoManager.h"
#import "HYPlaceHolderTextView.h"

@interface LWPingJiaPopView ()
@property (nonatomic, strong) HYAddPhotoView * addPhotoView;
@property (nonatomic, strong) LWStartPingJiaView * startView;
@property (nonatomic, strong) HYPlaceHolderTextView * textView;

@end
@implementation LWPingJiaPopView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self confiUI];
        _addPicManager = [[LWAddPhotoManager alloc] init];
        [_addPicManager setAddPicManager:_addPhotoView];
    }
    return self;
}

- (void)confiUI
{
    HYDefaultLabel *titleL = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(16) text:@"评价" textColor:HYCOLOR.color_c4];
    titleL.textAlignment = NSTextAlignmentCenter;
    
    LWStartPingJiaView *startView = [[LWStartPingJiaView alloc] init];
    HYDefaultLabel *textviewTitleL = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(14) text:@"请输入评价:" textColor:HYCOLOR.color_c4];
    _startView = startView;
    
    HYPlaceHolderTextView *textView = [HYPlaceHolderTextView creatPlaceHolderTextViewWithPlaceHolder:@"请输入评价"];
    textView.maxCount = 10;
    _textView = textView;
    
    HYDefaultButton *cancelBtn = [HYDefaultButton buttonWithTitleStringKey:@"取消" titleColor:HYCOLOR.color_c4 titleFont:SYSTEM_REGULARFONT(15) target:self selector:@selector(clickBottomBtn:)];
    cancelBtn.tag = 1;
    HYDefaultButton *confirBtn = [HYDefaultButton buttonWithTitleStringKey:@"提交" titleColor:HYCOLOR.color_c4 titleFont:SYSTEM_REGULARFONT(15) target:self selector:@selector(clickBottomBtn:)];
    confirBtn.tag = 2;
    
    [self addSubviews:@[titleL,startView,textView,textviewTitleL,self.addPhotoView,cancelBtn,confirBtn]];
    
    [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(self).mas_offset(10);
        make.right.mas_equalTo(self).mas_offset(-10);
    }];
    [startView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleL.mas_bottom).mas_offset(10);
        make.centerX.mas_equalTo(self.mas_centerX);
    }];
    [textviewTitleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(startView.mas_bottom).mas_offset(15);
        make.left.mas_equalTo(self).mas_offset(10);
    }];
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(textviewTitleL.mas_bottom).mas_offset(8);
        make.left.mas_equalTo(self).mas_offset(10);
        make.right.mas_equalTo(self).mas_offset(-10);
        make.height.mas_offset(100);
    }];
    [_addPhotoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(textView);
        make.top.mas_equalTo(textView.mas_bottom).mas_offset(10);
    }];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(70, 30));
        make.centerX.mas_equalTo(self.mas_centerX).mas_offset(-50);
        make.top.mas_equalTo(_addPhotoView.mas_bottom).mas_offset(10);
        make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-10);
    }];
    [confirBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(cancelBtn);
        make.centerX.mas_equalTo(self.mas_centerX).mas_offset(50);
        make.centerY.mas_equalTo(cancelBtn.mas_centerY);
    }];
    
    [cancelBtn setBoundWidth:1 cornerRadius:4 boardColor:HYCOLOR.color_c3];
    [confirBtn setBoundWidth:1 cornerRadius:4 boardColor:HYCOLOR.color_c3];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // 拦截控制器事件
}

- (HYAddPhotoView*)addPhotoView
{
    if (!_addPhotoView) {
        _addPhotoView = [[HYAddPhotoView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - MARGIN *2, 1)];;
        _addPhotoView.titleLable.text = @"添加照片:(最大数量3张)";
    }
    return _addPhotoView;
}

- (void)clickBottomBtn:(UIButton *)sender
{
    PARA_CREART;
    if (sender.tag == 1) {
        
    }else{
        if (self.startView.score == 0) {
            ALERT(@"请先评分");
            return;
        }

        if (!_addPicManager.selectImages) {
            return;
        }
        NSString *scoreStr = [NSString stringWithFormat:@"%.0f",self.startView.score];
        PARA_SET(scoreStr, @"grade");
        PARA_SET(self.textView.TextView.text, @"gradeContent");
        if(_addPicManager.selectImages) PARA_SET(_addPicManager.selectImages, @"picLists");
    }
    
    if (self.eventsBlock) {
        self.eventsBlock(para,sender.tag);
    }
    
}
@end
