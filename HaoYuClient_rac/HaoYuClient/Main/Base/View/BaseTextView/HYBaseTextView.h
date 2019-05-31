//
//  HYBaseTextView.h
//  HaoYuClient
//
//  Created by 刘文强 on 2018/5/23.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface HYbasetextview:UITextView

@end

@interface HYBaseTextView : HYBaseView
@property (nonatomic, assign) NSInteger  maxCount;
@property (nonatomic, strong) HYbasetextview * TextView;
@property (nonatomic, strong) HYDefaultLabel * placeHolderLable;
- (void)setUI;
@end
