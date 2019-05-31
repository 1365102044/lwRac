//
//  HYBaseTableViewCell.h
//  HaoYuClient
//
//  Created by 刘文强 on 2018/5/22.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import <UIKit/UIKit.h>
//typedef void(^clickCellBlock)(NSIndexPath *indexPath);
@interface HYBaseTableViewCell : UITableViewCell
{
    CGFloat MARGIN;
}
@property (nonatomic, strong) HYBaseView *bottomSpacingLineView;
@property (nonatomic, strong) NSIndexPath * indexPath;
@property (nonatomic, copy) HYEventCallBackBlock  clickBlock;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end
