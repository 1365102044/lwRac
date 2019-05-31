//
//  LWChoosePayMentTableViewCell.h
//  HaoYuClient
//
//  Created by 刘文强 on 2019/1/25.
//  Copyright © 2019年 LWQ. All rights reserved.
//

#import "HYBaseTableViewCell.h"

@interface LWChoosePayMentTableViewCell : HYBaseTableViewCell

@property (nonatomic, assign) NSInteger payTag;

- (void)setTitle:(NSString *)title imageName:(NSString *)imageName;

- (void)isSelectCell:(BOOL)isSelect;

@end
