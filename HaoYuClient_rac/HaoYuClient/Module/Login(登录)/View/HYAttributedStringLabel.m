//
//  HYAttributedStringLabel.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/5/24.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYAttributedStringLabel.h"
#import "HYBaseLabelAttributeStringModel.h"

@implementation HYAttributedStringLabel

- (void)setAttributedStringWithContentArray:(NSArray *)array
{
    self.numberOfLines              = 0;
    NSMutableArray *tempArrayM      = [NSMutableArray arrayWithCapacity:array.count];
    [array enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull obj,
                                        NSUInteger
                                        idx,
                                        BOOL * _Nonnull stop) {
        [tempArrayM addObject:[HYBaseLabelAttributeStringModel modelWithDictionary: obj]];
    }];
    [super setAttributedStringWithContentArray: tempArrayM.copy];
}

@end
