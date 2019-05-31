//
//  HYZuYue_InforBaseView.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/14.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYZuYue_InforBaseView.h"
#import "HYLeftRightArrowView.h"
@interface HYZuYue_InforBaseView ()
    
    @end

@implementation HYZuYue_InforBaseView
    
- (instancetype)initWithFrame:(CGRect)frame
    {
        self = [super initWithFrame:frame];
        if (self) {
            _titleLable = [HYAttributedStringLabel labelWithFont:SYSTEM_MEDIUMFONT(16)
                                                            text:@""
                                                       textColor:HYCOLOR.color_c4];
            UIView *line = [[UIView alloc] init];
            line.backgroundColor = HYCOLOR.color_c3;
            [self addSubview:_titleLable];
            [self addSubview:line];
            _itemView = [[HYBaseView alloc] init];
            [self addSubview:_itemView];
            [line mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_offset(MARGIN*2);
                make.top.mas_equalTo(self.mas_top).mas_offset(MARGIN);
                make.left.mas_equalTo(self.mas_left).mas_offset(MARGIN);
                make.width.mas_offset(2);
            }];
            [_titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(line.mas_centerY);
                make.left.mas_equalTo(line.mas_right).mas_offset(MARGIN);
            }];
            [_itemView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(_titleLable.mas_bottom).mas_offset(MARGIN);
                make.left.right.mas_equalTo(self);
                make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-MARGIN);
            }];
        }
        return self;
    }
    
- (void)setDataArray:(NSArray *)dataArray
    {
        _dataArray = dataArray;
        if (dataArray.count == 0) {
            return;
        }
        NSMutableArray *tem = [NSMutableArray array];
        for ( int i = 0; i < dataArray.count ; i++) {
            NSDictionary *dict = dataArray[i];
            HYLeftRightArrowView * item;
            if([dict[@"type"] isEqualToString:@"TF"]){
               item = [HYLeftRightArrowView creatLeftRightTextFieldArrowViewWithLeftStr:dict[@"left"]
                                                                                rightStr:dict[@"right"]
                                                                           showArrowIcon:NO
                                                                           CallBackBlock:^(id sender) {
                                                                               
                                                                           }];
                item.rightTextField.textFiled.enabled = NO;
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
                    if (self.callBackBlock) {
                        self.callBackBlock(item);
                    }
                }];
                [item.rightTextField addGestureRecognizer:tap];
            }else{
                item = [HYLeftRightArrowView creatLeftRightLableArrowViewWithLeftStr:dict[@"left"]
                                                                            rightStr:dict[@"right"]
                                                                       showArrowIcon:NO
                                                                       CallBackBlock:^(id sender) {
                                                                           if (self.callBackBlock) {
                                                                               self.callBackBlock(sender);
                                                                           }
                                                                       }];
            }
            [_itemView addSubview:item];
            [item mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_offset(MARGIN*5);
                make.left.mas_equalTo(_itemView);
                make.right.mas_equalTo(_itemView.mas_right).mas_offset(-MARGIN);
                if (i == 0) {
                    make.top.mas_equalTo(_itemView.mas_top);
                }else{
                    HYDefaultLabel *lastLable = tem.lastObject;
                    make.top.mas_equalTo(lastLable.mas_bottom);
                }
                if (i == dataArray.count - 1) {
                    make.bottom.mas_equalTo(_itemView.mas_bottom).mas_offset(-MARGIN);
                }
            }];
            [tem addObject:item];
        }
    }
    
    
    @end
